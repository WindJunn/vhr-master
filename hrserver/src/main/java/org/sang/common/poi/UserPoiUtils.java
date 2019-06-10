package org.sang.common.poi;

import org.apache.poi.hpsf.DocumentSummaryInformation;
import org.apache.poi.hpsf.SummaryInformation;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.sang.bean.Department;
import org.sang.bean.Hr;
import org.sang.bean.Nation;
import org.sang.service.DepartmentService;
import org.sang.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by sang on 2018/1/16.
 */
public class UserPoiUtils {
    @Autowired
    DepartmentService departmentService;
    @Autowired
    StudentService studentService;

    StudentService studentService1 = new StudentService();


    public static ResponseEntity<byte[]> exportUser2Excel(Map<String, Object> map) {
        HttpHeaders headers = null;
        ByteArrayOutputStream baos = null;
        List<Hr> hrs = (List<Hr>) map.get("hrs");
        List<Department> deps = (List<Department>) map.get("depss");
        List<Nation> nations = (List<Nation>) map.get("nations");
        try {
            //1.创建Excel文档
            HSSFWorkbook workbook = new HSSFWorkbook();
            //2.创建文档摘要
            workbook.createInformationProperties();
            //3.获取文档信息，并配置
            DocumentSummaryInformation dsi = workbook.getDocumentSummaryInformation();
            //3.1文档类别
            dsi.setCategory("管理员信息");
            //3.2设置文档管理员
            dsi.setManager("admin");
            //3.3设置组织机构
            dsi.setCompany("XXX集团");
            //4.获取摘要信息并配置
            SummaryInformation si = workbook.getSummaryInformation();
            //4.1设置文档主题
            si.setSubject("管理员信息表");
            //4.2.设置文档标题
            si.setTitle("管理员信息");
            //4.3 设置文档作者
            si.setAuthor("XXX集团");
            //4.4设置文档备注
            si.setComments("备注信息暂无");
            //创建Excel表单
            HSSFSheet sheet = workbook.createSheet("管理员信息表");
            //创建日期显示格式
            HSSFCellStyle dateCellStyle = workbook.createCellStyle();
            dateCellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy"));
            //创建标题的显示样式
            HSSFCellStyle headerStyle = workbook.createCellStyle();
            headerStyle.setFillForegroundColor(IndexedColors.YELLOW.index);
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            //定义列的宽度
            sheet.setColumnWidth(0, 5 * 256);
            sheet.setColumnWidth(1, 12 * 256);
            sheet.setColumnWidth(2, 10 * 256);
            sheet.setColumnWidth(3, 5 * 256);
            sheet.setColumnWidth(4, 12 * 256);
            sheet.setColumnWidth(5, 20 * 256);
            sheet.setColumnWidth(6, 10 * 256);
            sheet.setColumnWidth(7, 10 * 256);
            sheet.setColumnWidth(8, 16 * 256);
            sheet.setColumnWidth(9, 12 * 256);
            sheet.setColumnWidth(10, 15 * 256);

            //5.设置表头
            HSSFRow headerRow = sheet.createRow(0);
            HSSFCell cell0 = headerRow.createCell(0);
            cell0.setCellValue("编号");
            cell0.setCellStyle(headerStyle);
            HSSFCell cell1 = headerRow.createCell(1);
            cell1.setCellValue("姓名");
            cell1.setCellStyle(headerStyle);
            HSSFCell cell2 = headerRow.createCell(2);
            cell2.setCellValue("手机号码");
            cell2.setCellStyle(headerStyle);
            HSSFCell cell3 = headerRow.createCell(3);
            cell3.setCellValue("性别");
            cell3.setCellStyle(headerStyle);
            HSSFCell cell4 = headerRow.createCell(4);
            cell4.setCellValue("联系地址");
            cell4.setCellStyle(headerStyle);
            HSSFCell cell5 = headerRow.createCell(5);
            cell5.setCellValue("所属部门");
            cell5.setCellStyle(headerStyle);
            HSSFCell cell6 = headerRow.createCell(6);
            cell6.setCellValue("身份证号码");
            cell6.setCellStyle(headerStyle);
            HSSFCell cell7 = headerRow.createCell(7);
            cell7.setCellValue("出生日期");
            cell7.setCellStyle(headerStyle);
            HSSFCell cell8 = headerRow.createCell(8);
            cell8.setCellValue("邮箱");
            cell8.setCellStyle(headerStyle);
            HSSFCell cell10 = headerRow.createCell(9);
            cell10.setCellValue("民族");
            cell10.setCellStyle(headerStyle);


            //6.装数据
            for (int i = 0; i < hrs.size(); i++) {
                HSSFRow row = sheet.createRow(i + 1);
                Hr hr = hrs.get(i);
                row.createCell(0).setCellValue(hr.getId());
                row.createCell(1).setCellValue(hr.getName());
                row.createCell(2).setCellValue(hr.getPhone());
                row.createCell(3).setCellValue(hr.getGender());
                row.createCell(4).setCellValue(hr.getAddress());
                for (int j = 0; j < deps.size(); j++) {
                    if (deps.get(j).getId().equals(hr.getDepartmentId())) {
                        row.createCell(5).setCellValue(deps.get(j).getName());
                        break;

                    }
                }
                row.createCell(6).setCellValue(hr.getIdCard());

                HSSFCell birthdayCell = row.createCell(7);
                birthdayCell.setCellValue(hr.getBirthday());
                birthdayCell.setCellStyle(dateCellStyle);
                row.createCell(8).setCellValue(hr.getEmail());
                for (int k = 0; k < nations.size(); k++) {
                    if (nations.get(k).getId().equals(hr.getNationId())) {
                        row.createCell(9).setCellValue(nations.get(k).getName());
                        break;
                    }
                }

            }
            headers = new HttpHeaders();
            headers.setContentDispositionFormData("attachment",
                    new String("管理员表.xls".getBytes("UTF-8"), "iso-8859-1"));
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            baos = new ByteArrayOutputStream();
            workbook.write(baos);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return new ResponseEntity<byte[]>(baos.toByteArray(), headers, HttpStatus.CREATED);
    }

    public static List<Hr> importUser2List(MultipartFile file,
                                           List<Nation> allNations,
                                           List<Department> allDeps) {
        List<Hr> hrs = new ArrayList<>();
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        try {
            HSSFWorkbook workbook =
                    new HSSFWorkbook(new POIFSFileSystem(file.getInputStream()));
            int numberOfSheets = workbook.getNumberOfSheets();
            for (int i = 0; i < numberOfSheets; i++) {
                HSSFSheet sheet = workbook.getSheetAt(i);
                int physicalNumberOfRows = sheet.getPhysicalNumberOfRows();
                Hr hr;
                for (int j = 0; j < physicalNumberOfRows; j++) {
                    if (j == 0) {
                        continue;//标题行
                    }
                    HSSFRow row = sheet.getRow(j);
                    if (row == null) {
                        continue;//没数据
                    }
                    int physicalNumberOfCells = row.getPhysicalNumberOfCells();
                    hr = new Hr();
                    String encode = encoder.encode("123");
                    for (int k = 0; k < physicalNumberOfCells; k++) {
                        HSSFCell cell = row.getCell(k);
                        switch (cell.getCellTypeEnum()) {
                            case STRING: {
                                String cellValue = cell.getStringCellValue();
                                if (cellValue == null) {
                                    cellValue = "";
                                }
                                switch (k) {
                                    case 1:
                                        hr.setName(cellValue);
                                        break;
                                    case 2:
                                        hr.setPhone(cellValue);
                                        hr.setUsername(cellValue);
                                        hr.setPassword(encode);

                                        break;
                                    case 3:
                                        hr.setGender(cellValue);
                                        break;
                                    case 4:
                                        hr.setAddress(cellValue);
                                        break;
                                    case 5:
                                        int depIndex = allDeps.indexOf(new Department(cellValue));
                                        hr.setDepartmentId(allDeps.get(depIndex).getId());
                                        break;
                                    case 6:
                                        hr.setIdCard(cellValue);
                                        break;
                                    case 8:
                                        hr.setEmail(cellValue);
                                        break;
                                    case 9:
                                        int nationIndex = allNations.indexOf(new Nation(cellValue));
                                        hr.setNationId(allNations.get(nationIndex).getId());
                                        break;
                                }
                            }
                            break;
                            default: {
                                switch (k) {
                                    case 7:
                                        hr.setBirthday(cell.getDateCellValue());
                                        break;
                                }
                            }
                            break;
                        }
                    }
                    hrs.add(hr);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return hrs;
    }
}

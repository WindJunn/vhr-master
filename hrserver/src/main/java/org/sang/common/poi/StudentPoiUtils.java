package org.sang.common.poi;

import org.apache.poi.hpsf.DocumentSummaryInformation;
import org.apache.poi.hpsf.SummaryInformation;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.sang.bean.*;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by sang on 2018/1/16.
 */
public class StudentPoiUtils {

    public static ResponseEntity<byte[]> exportEmp2Excel(List<Student> emps) {
        HttpHeaders headers = null;
        ByteArrayOutputStream baos = null;
        try {
            //1.创建Excel文档
            HSSFWorkbook workbook = new HSSFWorkbook();
            //2.创建文档摘要
            workbook.createInformationProperties();
            //3.获取文档信息，并配置
            DocumentSummaryInformation dsi = workbook.getDocumentSummaryInformation();
            //3.1文档类别
            dsi.setCategory("学员信息");
            //3.2设置文档管理员
            dsi.setManager("admin");
            //3.3设置组织机构
            dsi.setCompany("XXX集团");
            //4.获取摘要信息并配置
            SummaryInformation si = workbook.getSummaryInformation();
            //4.1设置文档主题
            si.setSubject("学员信息表");
            //4.2.设置文档标题
            si.setTitle("学员信息");
            //4.3 设置文档作者
            si.setAuthor("XXX集团");
            //4.4设置文档备注
            si.setComments("备注信息暂无");
            //创建Excel表单
            HSSFSheet sheet = workbook.createSheet("学员信息表");
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
            sheet.setColumnWidth(11, 20 * 256);
            sheet.setColumnWidth(12, 16 * 256);

            //5.设置表头
            HSSFRow headerRow = sheet.createRow(0);
            HSSFCell cell0 = headerRow.createCell(0);
            cell0.setCellValue("编号");
            cell0.setCellStyle(headerStyle);
            HSSFCell cell1 = headerRow.createCell(1);
            cell1.setCellValue("姓名");
            cell1.setCellStyle(headerStyle);
            HSSFCell cell2 = headerRow.createCell(2);
            cell2.setCellValue("工号");
            cell2.setCellStyle(headerStyle);
            HSSFCell cell3 = headerRow.createCell(3);
            cell3.setCellValue("性别");
            cell3.setCellStyle(headerStyle);
            HSSFCell cell4 = headerRow.createCell(4);
            cell4.setCellValue("出生日期");
            cell4.setCellStyle(headerStyle);
            HSSFCell cell5 = headerRow.createCell(5);
            cell5.setCellValue("身份证号码");
            cell5.setCellStyle(headerStyle);
            HSSFCell cell6 = headerRow.createCell(6);
            cell6.setCellValue("婚姻状况");
            cell6.setCellStyle(headerStyle);
            HSSFCell cell7 = headerRow.createCell(7);
            cell7.setCellValue("民族");
            cell7.setCellStyle(headerStyle);
            HSSFCell cell8 = headerRow.createCell(8);
            cell8.setCellValue("籍贯");
            cell8.setCellStyle(headerStyle);
            HSSFCell cell10 = headerRow.createCell(9);
            cell10.setCellValue("电话号码");
            cell10.setCellStyle(headerStyle);
            HSSFCell cell11 = headerRow.createCell(10);
            cell11.setCellValue("联系地址");
            cell11.setCellStyle(headerStyle);
            HSSFCell cell12 = headerRow.createCell(11);
            cell12.setCellValue("所属部门");
            cell12.setCellStyle(headerStyle);


            //6.装数据
            for (int i = 0; i < emps.size(); i++) {
                HSSFRow row = sheet.createRow(i + 1);
                Student emp = emps.get(i);
                row.createCell(0).setCellValue(emp.getId());
                row.createCell(1).setCellValue(emp.getName());
                row.createCell(2).setCellValue(emp.getWorkID());
                row.createCell(3).setCellValue(emp.getGender());
                HSSFCell birthdayCell = row.createCell(4);
                birthdayCell.setCellValue(emp.getBirthday());
                birthdayCell.setCellStyle(dateCellStyle);
                row.createCell(5).setCellValue(emp.getIdCard());
                row.createCell(6).setCellValue(emp.getWedlock());
                row.createCell(7).setCellValue(emp.getNation().getName());
                row.createCell(8).setCellValue(emp.getNativePlace());
                row.createCell(9).setCellValue(emp.getPhone());
                row.createCell(10).setCellValue(emp.getAddress());
                row.createCell(11).setCellValue(emp.getDepartment().getName());
            }
            headers = new HttpHeaders();
            headers.setContentDispositionFormData("attachment",
                    new String("学员表.xls".getBytes("UTF-8"), "iso-8859-1"));
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            baos = new ByteArrayOutputStream();
            workbook.write(baos);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return new ResponseEntity<byte[]>(baos.toByteArray(), headers, HttpStatus.CREATED);
    }

    public static List<Student> importEmp2List(MultipartFile file,
                                               List<Nation> allNations,
                                               List<Department> allDeps) {
        List<Student> emps = new ArrayList<>();
        try {
            HSSFWorkbook workbook =
                    new HSSFWorkbook(new POIFSFileSystem(file.getInputStream()));
            int numberOfSheets = workbook.getNumberOfSheets();
            for (int i = 0; i < numberOfSheets; i++) {
                HSSFSheet sheet = workbook.getSheetAt(i);
                int physicalNumberOfRows = sheet.getPhysicalNumberOfRows();
                Student employee;
                for (int j = 0; j < physicalNumberOfRows; j++) {
                    if (j == 0) {
                        continue;//标题行
                    }
                    HSSFRow row = sheet.getRow(j);
                    if (row == null) {
                        continue;//没数据
                    }
                    int physicalNumberOfCells = row.getPhysicalNumberOfCells();
                    employee = new Student();
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
                                        employee.setName(cellValue);
                                        break;
                                    case 2:
                                        employee.setWorkID(cellValue);
                                        break;
                                    case 3:
                                        employee.setGender(cellValue);
                                        break;
                                    case 5:
                                        employee.setIdCard(cellValue);
                                        break;
                                    case 6:
                                        employee.setWedlock(cellValue);
                                        break;
                                    case 7:
                                        int nationIndex = allNations.indexOf(new Nation(cellValue));
                                        employee.setNationId(allNations.get(nationIndex).getId());
                                        break;
                                    case 8:
                                        employee.setNativePlace(cellValue);
                                        break;
                                    case 9:
                                        employee.setPhone(cellValue);
                                        break;
                                    case 10:
                                        employee.setAddress(cellValue);
                                        break;
                                    case 11:
                                        int depIndex = allDeps.indexOf(new Department(cellValue));
                                        employee.setDepartmentId(allDeps.get(depIndex).getId());
                                        break;

                                }
                            }
                            break;
                            default: {
                                switch (k) {
                                    case 4:
                                        employee.setBirthday(cell.getDateCellValue());
                                        break;
                                }
                            }
                            break;
                        }
                    }
                    emps.add(employee);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return emps;
    }
}

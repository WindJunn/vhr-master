package org.sang.controller.emp;

import org.sang.bean.RespBean;
import org.sang.bean.Student;
import org.sang.common.poi.StudentPoiUtils;
import org.sang.service.DepartmentService;
import org.sang.service.JobLevelService;
import org.sang.service.PositionService;
import org.sang.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.thymeleaf.TemplateEngine;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;

/**
 * Created by sang on 2018/1/12.
 */
@RestController
@RequestMapping("/student/basic")
public class StudentController {
    @Autowired
    StudentService studentService;
    @Autowired
    DepartmentService departmentService;
    @Autowired
    PositionService positionService;
    @Autowired
    JobLevelService jobLevelService;
    @Autowired
    ExecutorService executorService;
    @Autowired
    TemplateEngine templateEngine;
  /*  @Autowired
    JavaMailSender javaMailSender;*/

    @RequestMapping(value = "/basicdata", method = RequestMethod.GET)
    public Map<String, Object> getAllNations() {
        Map<String, Object> map = new HashMap<>();
        map.put("nations", studentService.getAllNations());
        map.put("deps", departmentService.getDepByPid(-1L));
        map.put("workID", String.format("%010d", studentService.getMaxWorkID() + 1));
        return map;
    }

    @RequestMapping("/maxWorkID")
    public String maxWorkID() {
        return String.format("%010d", studentService.getMaxWorkID() + 1);
    }

    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    public RespBean addStudent(Student student) {
        if (studentService.addStudent(student) == 1) {
            return RespBean.ok("添加成功!");
        }
        return RespBean.error("添加失败!");
    }

    @RequestMapping(value = "/emp", method = RequestMethod.PUT)
    public RespBean updateEmp(Student student) {
        if (studentService.updateStudent(student) == 1) {
            return RespBean.ok("更新成功!");
        }
        return RespBean.error("更新失败!");
    }

    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public RespBean deleteEmpById(@PathVariable String ids) {
        if (studentService.deleteStudentById(ids)) {
            return RespBean.ok("删除成功!");
        }
        return RespBean.error("删除失败!");
    }

    @RequestMapping(value = "/emp", method = RequestMethod.GET)
    public Map<String, Object> getEmployeeByPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(defaultValue = "") String keywords,
            Long politicId, Long nationId, Long departmentId) {
        Map<String, Object> map = new HashMap<>();
        List<Student> employeeByPage = studentService.getStudentByPage(page, size,
                keywords, nationId, departmentId);
        Long count = studentService.getCountByKeywords(keywords, politicId, nationId);
        map.put("emps", employeeByPage);
        map.put("count", count);
        return map;
    }

    @RequestMapping(value = "/exportEmp", method = RequestMethod.GET)
    public ResponseEntity<byte[]> exportEmp() {
        return StudentPoiUtils.exportEmp2Excel(studentService.getAllStudents());
    }

    @RequestMapping(value = "/importEmp", method = RequestMethod.POST)
    public RespBean importEmp(MultipartFile file) {
        List<Student> emps = StudentPoiUtils.importEmp2List(file,
                studentService.getAllNations(), departmentService.getAllDeps());
        if (studentService.addStudents(emps) == emps.size()) {
            return RespBean.ok("导入成功!");
        }
        return RespBean.error("导入失败!");
    }


    @RequestMapping(value = "/updatePoint", method = RequestMethod.PUT)
    public RespBean updatePoint(Long id) {
        if (studentService.updatePoint(id) == 1) {
            return RespBean.ok("更新积分成功!");
        }
        return RespBean.error("更新积分失败!");
    }

}

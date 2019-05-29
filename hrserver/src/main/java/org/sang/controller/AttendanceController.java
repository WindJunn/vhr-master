package org.sang.controller;

import org.sang.bean.Attendance;
import org.sang.bean.RespBean;
import org.sang.service.AttendanceService;
import org.sang.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.thymeleaf.TemplateEngine;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;

/**
 * Created by sang on 2018/1/12.
 */
@RestController
@RequestMapping("/attendance")
public class AttendanceController {
    @Autowired
    AttendanceService attendanceService;
    @Autowired
    DepartmentService departmentService;
    @Autowired
    ExecutorService executorService;
    @Autowired
    TemplateEngine templateEngine;
  /*  @Autowired
    JavaMailSender javaMailSender;*/

    @RequestMapping(value = "/basicdata", method = RequestMethod.GET)
    public Map<String, Object> getAllAttname() {
        Map<String, Object> map = new HashMap<>();
        map.put("attname", attendanceService.getAllAttname());
        map.put("deps", departmentService.getDepByPid(-1L));
        return map;
    }


    @RequestMapping(value = "/att", method = RequestMethod.POST)
    public RespBean addAtt(Attendance attendance) {
        if (attendanceService.addAtt(attendance) == 1) {
            return RespBean.ok("添加成功!");
        }
        return RespBean.error("添加失败!");
    }

    @RequestMapping(value = "/att", method = RequestMethod.PUT)
    public RespBean updateAtt(Attendance attendance) {
        if (attendanceService.updateAtt(attendance) == 1) {
            return RespBean.ok("更新成功!");
        }
        return RespBean.error("更新失败!");
    }

    @RequestMapping(value = "/att/{ids}", method = RequestMethod.DELETE)
    public RespBean deleteAttById(@PathVariable String ids) {
        if (attendanceService.deleteAttById(ids)) {
            return RespBean.ok("删除成功!");
        }
        return RespBean.error("删除失败!");
    }

    @RequestMapping(value = "/att", method = RequestMethod.GET)
    public Map<String, Object> getAttByPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(defaultValue = "") String keywords,
            String atime, Long stateId,
            Long sid, Long departmentId) {
        Map<String, Object> map = new HashMap<>();
        List<Attendance> atts = attendanceService.getAttByPage(page, size,
                keywords, atime, stateId, sid, departmentId);
        Long count = attendanceService.getCountByKeywords(keywords, atime,
                stateId, sid, departmentId);
        map.put("atts", atts);
//        map.put("count", count);
        return map;
    }

/*    @RequestMapping(value = "/exportEmp", method = RequestMethod.GET)
    public ResponseEntity<byte[]> exportEmp() {
        return PoiUtils.exportEmp2Excel(attendanceService.getAllEmployees());
    }

    @RequestMapping(value = "/importEmp", method = RequestMethod.POST)
    public RespBean importEmp(MultipartFile file) {
        List<Employee> emps = PoiUtils.importEmp2List(file,
                attendanceService.getAllNations(), attendanceService.getAllPolitics(),
                departmentService.getAllDeps(), positionService.getAllPos(),
                jobLevelService.getAllJobLevels());
        if (attendanceService.addStudents(emps) == emps.size()) {
            return RespBean.ok("导入成功!");
        }
        return RespBean.error("导入失败!");
    }*/
}

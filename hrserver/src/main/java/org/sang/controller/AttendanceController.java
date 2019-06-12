package org.sang.controller;

import org.sang.bean.Attendance;
import org.sang.bean.Attname;
import org.sang.bean.RespBean;
import org.sang.common.poi.StudentAttPoiUtils;
import org.sang.service.AttendanceService;
import org.sang.service.AttnameService;
import org.sang.service.DepartmentService;
import org.sang.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
    StudentService studentService;

    @Autowired
    AttnameService attnameService;


    @RequestMapping(value = "/basicdata", method = RequestMethod.GET)
    public Map<String, Object> getAllAttname() {
        Map<String, Object> map = new HashMap<>();
        map.put("attname", attendanceService.getAllAttname());
        map.put("deps", departmentService.getDepByPid(-1L));
        return map;
    }

    @RequestMapping(value = "/count", method = RequestMethod.GET)
    public Map<String, Object> getAttCountBySidAndStateId(Long sid) {
        Map<String, Object> map = new HashMap<>();
        Map<String, Long> att = new HashMap<>();
        List<Attname> allAttname = attendanceService.getAllAttname();
        for (int i = 0; i < allAttname.size(); i++) {
            att.put(allAttname.get(i).getName(), attendanceService.getAttCountBySidAndStateId(sid,allAttname.get(i).getId()));
        }
        map.put("counts",att);
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
            Long sid, Long departmentId,Long upid) {
        Map<String, Object> map = new HashMap<>();
        List<Attendance> atts = attendanceService.getAttByPage(page, size,
                keywords, atime, stateId, sid, departmentId,upid);
//        Long count = attendanceService.getCountByKeywords(keywords, atime,
//                stateId, sid, departmentId);
        map.put("atts", atts);
//        map.put("count", count);
        return map;
    }

  /*  @RequestMapping(value = "/exportAtt", method = RequestMethod.GET)
    public ResponseEntity<byte[]> exportEmp() {
        return PoiUtils.exportEmp2Excel(attendanceService.getAllEmployees());
    }*/

    @RequestMapping(value = "/importAtt", method = RequestMethod.POST)
    public RespBean importEmp(MultipartFile file) {
        List<Attendance> atts = StudentAttPoiUtils.importAtt2List(file,
                studentService.getAllStudents(), attnameService.getAllCategories());
        if (attendanceService.addAtts(atts) == atts.size()) {
            return RespBean.ok("导入成功!");
        }
        return RespBean.error("导入失败!");
    }
}

package org.sang.controller;

import org.sang.bean.RespBean;
import org.sang.bean.Schedules;
import org.sang.service.SchedulesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by sang on 2017/12/20.
 */
@RestController
@RequestMapping("/schedules")
public class SchedulesController {

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

    @Autowired
    SchedulesService schedulesService;

    @RequestMapping(value = "/sch", method = RequestMethod.GET)
    public Map<String, Object> getEmployeeByPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(defaultValue = "") String keywords, Long userId, Long departmentId) {
        Map<String, Object> map = new HashMap<>();
        List<Schedules> schedules = schedulesService.getSchedulesByPage(page, size,
                keywords, userId, departmentId);
//        Long count = schedulesService.getCountByKeywords(keywords, politicId, userId);
        map.put("schedules", schedules);
//        map.put("count", count);
        return map;
    }

    @RequestMapping(value = "/sch", method = RequestMethod.POST)
    public RespBean addSchedules(Schedules schedules) {
        if (schedulesService.addStudents(schedules) == 1) {
            return RespBean.ok("添加成功!");
        }
        return RespBean.error("添加失败!");
    }

    @RequestMapping(value = "/sch", method = RequestMethod.PUT)
    public RespBean updateSchedules(Schedules schedules) {
        if (schedulesService.updateSchedules(schedules) == 1) {
            return RespBean.ok("更新成功!");
        }
        return RespBean.error("更新失败!");
    }

    @RequestMapping(value = "/sch/{ids}", method = RequestMethod.DELETE)
    public RespBean deleteSchedulesById(@PathVariable String ids) {
        if (schedulesService.deleteSchedulesById(ids)) {
            return RespBean.ok("删除成功!");
        }
        return RespBean.error("删除失败!");
    }
}

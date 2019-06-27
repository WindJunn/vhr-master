package org.sang.service;


import org.sang.bean.Department;
import org.sang.bean.Schedules;
import org.sang.common.DepartmentUtil;
import org.sang.common.Util;
import org.sang.mapper.DepartmentMapper;
import org.sang.mapper.SchedulesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.List;

@Service
@Transactional
public class SchedulesService {

    @Autowired
    private SchedulesMapper schedulesMapper;

    @Autowired
    DepartmentMapper departmentMapper;

    public List<Schedules> getSchedulesByPage(Integer page, Integer size, String keywords, Long userId, Long departmentId) {
        int start = (page - 1) * size;
        List<Long> depList = null;
        Long upid = Util.getCurrentUser().getDepartmentId();

        if (upid != null && upid != 0) {
            List<Department> deps = departmentMapper.getDepByPid(upid);
            depList = DepartmentUtil.findDeps(upid, deps);
        }

        return schedulesMapper.getSchedulesByPage(start, size, keywords, userId,departmentId,depList);
    }

    public Long getCountByKeywords(String keywords,  Long userId, Long departmentId) {

        return schedulesMapper.getCountByKeywords(keywords, userId, departmentId);
    }

    public int addSchedules(Schedules schedules) {
        return schedulesMapper.addSchedules(schedules);
    }


    public int updateSchedules(Schedules schedules) {
        return schedulesMapper.updateSchedules(schedules);
    }

    public boolean deleteSchedulesById(String ids) {
        String[] split = ids.split(",");
        return schedulesMapper.deleteSchedulesById(split) == split.length;
    }


}

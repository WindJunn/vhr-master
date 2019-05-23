package org.sang.service;


import org.sang.bean.Schedules;
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

    SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
    SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
    SimpleDateFormat birthdayFormat = new SimpleDateFormat("yyyy-MM-dd");
    DecimalFormat decimalFormat = new DecimalFormat("##.00");

    public List<Schedules> getSchedulesByPage(Integer page, Integer size, String keywords, Long userId, Long departmentId) {
        int start = (page - 1) * size;
        return schedulesMapper.getSchedulesByPage(start, size, keywords, userId,departmentId);
    }

    public Long getCountByKeywords(String keywords,  Long userId, Long departmentId) {

        return schedulesMapper.getCountByKeywords(keywords, userId, departmentId);
    }

    public int addStudents(Schedules schedules) {
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

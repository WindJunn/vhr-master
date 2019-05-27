package org.sang.mapper;

import org.apache.ibatis.annotations.Param;
import org.sang.bean.Schedules;

import java.util.List;

/**
 * Created by sang on 2017/12/17.
 */

public interface SchedulesMapper {

    List<Schedules> getSchedulesByPage(@Param("start") Integer start, @Param("size") Integer size,
                                       @Param("keywords") String keywords, @Param("userId") Long userId, @Param("departmentId") Long departmentId);

    Long getCountByKeywords(@Param("keywords") String keywords,  @Param("userId") Long userId, @Param("departmentId") Long departmentId);


    List<Schedules> getSchedulesByDepartmentId(Long departmentId);

    Schedules getSchedulesById(Long id);

    int addSchedules(@Param("schedule") Schedules schedule);

    int updateSchedules(@Param("schedule") Schedules schedule);

    int deleteSchedulesById(@Param("ids") String[] ids);


}

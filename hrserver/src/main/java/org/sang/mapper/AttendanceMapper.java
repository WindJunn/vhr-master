package org.sang.mapper;

import org.apache.ibatis.annotations.Param;
import org.sang.bean.Attendance;
import org.sang.bean.Attname;

import java.util.List;

/**
 * Created by sang on 2018/1/12.
 */
public interface AttendanceMapper {
    List<Attname> getAllAttname();

    int addAtt(Attendance att);

    List<Attendance> getAttByPage(@Param("start") Integer start, @Param("size") Integer size,
                                  @Param("keywords") String keywords,@Param("atime") String atime,
                                  @Param("stateId") Long stateId, @Param("sid") Long sid,
                                  @Param("departmentId") Long departmentId,@Param("depList") List depList);

    Long getCountByKeywords(@Param("keywords") String keywords,@Param("atime") String atime,
                            @Param("stateId") Long stateId, @Param("sid") Long sid,
                            @Param("departmentId") Long departmentId,@Param("depList") List depList);

    int updateAtt(@Param("att") Attendance att);

    int deleteAttById(@Param("ids") String[] ids);

    int addAtts(@Param("atts") List<Attendance> atts);

    List<Attendance> getAttByPageShort(@Param("start") int start, @Param("size") Integer size);

    Long getAttCountBySidAndStateId(@Param("sid") Long sid,  @Param("stateId") Long stateId);
}

package org.sang.mapper;

import org.apache.ibatis.annotations.Param;
import org.sang.bean.SystemName;

import java.util.List;

/**
 * Created by sang on 2017/12/19.
 */
public interface SystemnameMapper {
    List<SystemName> getAllSysName();

    int updateSysNameById(@Param("title") String title, @Param("leftname") String leftname);

    int updateSysName(@Param("emp") SystemName systemName);

}

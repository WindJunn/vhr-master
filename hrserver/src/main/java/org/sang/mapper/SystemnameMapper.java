package org.sang.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.sang.bean.SystemName;

import java.util.List;

/**
 * Created by sang on 2017/12/19.
 */
@Mapper
public interface SystemnameMapper {
    List<SystemName> getAllSysName();

    int updateSysNameById(SystemName systemName);

}

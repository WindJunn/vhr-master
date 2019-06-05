package org.sang.mapper;

import org.apache.ibatis.annotations.Param;
import org.sang.bean.Pointoption;

import java.util.List;

/**
 * Created by sang on 2018/1/12.
 */
public interface PointoptionMapper {

    List<Pointoption> getAllPointoption();

    int addPointoption(Pointoption pointoption);

    int updatePointoption(Pointoption pointoption);

    int deletePointoptionByIds(@Param("ids") String[] ids);

}

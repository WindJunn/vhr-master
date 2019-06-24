package org.sang.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.sang.bean.Articletop;

/**
 * @author WindJunn
 * @date 2019-06-24 11:49
 */
@Mapper
public interface ArticletopMapper {

    int updateArticletop(Articletop articletop);

    int updateArticletopAid(@Param("aid")Long aid);

    Articletop getArticletop();
}

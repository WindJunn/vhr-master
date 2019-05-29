package org.sang.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.sang.bean.Attname;

import java.util.List;

/**
 * Created by sang on 2017/12/19.
 */
@Mapper
public interface AttnameMapper {
    List<Attname> getAllAtt();

    int deleteAttnameByIds(@Param("ids") String[] ids);

    int updateAttById(Attname attname);

    int addAtt(Attname attname);
}

package org.sang.mapper;

import org.apache.ibatis.annotations.Param;
import org.sang.bean.Hr;
import org.sang.bean.Role;

import java.util.List;

/**
 * Created by sang on 2017/12/28.
 */
public interface HrMapper {
    Hr loadUserByUsername(String username);

    List<Role> getRolesByHrId(Long id);

    int hrReg(@Param("username") String username, @Param("password") String password);

    List<Hr> getHrsByKeywords(@Param("start") Integer start, @Param("size") Integer size,
                              @Param("keywords") String keywords, @Param("nationId") Long nationId,
                              @Param("departmentId") Long departmentId, @Param("nameZh") String nameZh
            , @Param("depList") List depList);


    int updateHr(@Param("hr") Hr hr);


    int deleteRoleByHrId(Long hrId);

    int addRolesForHr(@Param("hrId") Long hrId, @Param("rids") Long[] rids);

    Hr getHrById(Long hrId);

    int deleteHr(Long hrId);

    int deleteHrs(@Param("ids") String[] ids);

    List<Hr> getAllHr(@Param("currentId") Long currentId);

    int addHr(@Param("hr") Hr hr);

    int addHrs(@Param("hrs") List<Hr> hrs);

    int updateHreg(@Param("hr") Hr hr);

    Hr getHrByUsername(String username);

    Hr getHrByUsernameAndPassword(@Param("username") String username, @Param("password") String password);

    int updateHrPassword(@Param("username") String username, @Param("password") String password);
}

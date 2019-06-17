package org.sang.service;

import org.sang.bean.Department;
import org.sang.bean.Hr;
import org.sang.common.DepartmentUtil;
import org.sang.common.HrUtils;
import org.sang.mapper.DepartmentMapper;
import org.sang.mapper.HrMapper;
import org.sang.mapper.RoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sang on 2017/12/28.
 */
@Service
@Transactional
public class HrService implements UserDetailsService {

    @Autowired
    HrMapper hrMapper;

    @Autowired
    RoleMapper roleMapper;

    @Autowired
    DepartmentMapper departmentMapper;

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        Hr hr = hrMapper.loadUserByUsername(s);
        if (hr == null) {
            throw new UsernameNotFoundException("用户名不对");
        }
        return hr;
    }

    public int hrReg(String username, String password) {
        //如果用户名存在，返回错误
        if (hrMapper.loadUserByUsername(username) != null) {
            return -1;
        }
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String encode = encoder.encode(password);
        return hrMapper.hrReg(username, encode);
    }

    public int updateHrPassword(String username, String password) {

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String encode = encoder.encode(password);
        return hrMapper.updateHrPassword(username, encode);
    }

    public List<Hr> getHrsByKeywords(Integer page,Integer size,String keywords,Long nationId,Long departmentId,Long upid,String nameZh) {

        List<Long> depList = null;

        if (upid != null && upid > 0) {
            List<Department> deps = departmentMapper.getDepByPid(upid);
            depList =  DepartmentUtil.findDeps(upid,deps);

        }

        return hrMapper.getHrsByKeywords(page,size,keywords,nationId,departmentId,nameZh,depList);
    }

    public int updateHr(Hr hr) {
        return hrMapper.updateHr(hr);
    }

    public int updateHrRoles(Long hrId, Long[] rids) {
        int i = hrMapper.deleteRoleByHrId(hrId);
        return hrMapper.addRolesForHr(hrId, rids);
    }

    public Hr getHrById(Long hrId) {
        return hrMapper.getHrById(hrId);
    }

    public Hr getHrByUsername(String username) {
        return hrMapper.getHrByUsername(username);
    }


    public int deleteHr(Long hrId) {
        return hrMapper.deleteHr(hrId);
    }
    public boolean deleteHrs(String ids) {
        String[] split = ids.split(",");
        return hrMapper.deleteHrs(split) == split.length;
    }

    public List<Hr> getAllHrExceptAdmin() {
        return hrMapper.getAllHr(HrUtils.getCurrentHr().getId());
    }
    public List<Hr> getAllHr() {
        return hrMapper.getAllHr(null);
    }

    public int addHr(Hr hr){
        hr.setUsername(hr.getPhone());
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String encode = encoder.encode(hr.getPassword());
        hr.setPassword(encode);
        return hrMapper.addHr(hr);
    }

    public int addHrs(List<Hr> hrs) {
        return hrMapper.addHrs(hrs);
    }
    public int updateHreg(Hr hr){
        return hrMapper.updateHreg(hr);
    }

}

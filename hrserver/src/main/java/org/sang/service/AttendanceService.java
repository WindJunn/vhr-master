package org.sang.service;

import org.sang.bean.Attendance;
import org.sang.bean.Attname;
import org.sang.bean.Department;
import org.sang.common.DepartmentUtil;
import org.sang.mapper.AttendanceMapper;
import org.sang.mapper.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by sang on 2018/1/12.
 */
@Service
@Transactional
public class AttendanceService {
    @Autowired
    AttendanceMapper attendanceMapper;

    @Autowired
    DepartmentMapper departmentMapper;
    SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
    SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
    SimpleDateFormat birthdayFormat = new SimpleDateFormat("yyyy-MM-dd");
    DecimalFormat decimalFormat = new DecimalFormat("##.00");


    public List<Attname> getAllAttname() {
        return attendanceMapper.getAllAttname();
    }

    public int addAtt(Attendance att) {
        return attendanceMapper.addAtt(att);
    }


    public List<Attendance> getAttByPage(Integer page, Integer size, String keywords, String atime,
                                         Long stateId, Long sid, Long departmentId,Long upid) {

        Integer start = null;
        if (page != null || size != null) {
             start = (page - 1) * size;

        }
        List<Long> depList = null;

        if (upid != null && upid != 0) {
            List<Department> deps = departmentMapper.getDepByPid(upid);
            depList = new ArrayList<>();
            depList.add(upid);
            DepartmentUtil.findDep(deps, depList);
        }
        List<Attendance> attByPage = attendanceMapper.getAttByPage(start, size, keywords, atime, stateId, sid, departmentId,depList);

        return attByPage;
    }

    public Long getCountByKeywords(String keywords, String atime,
                                   Long stateId, Long sid, Long departmentId,Long upid) {

        Long count ;
        List<Long> depList = null;

        return attendanceMapper.getCountByKeywords(keywords, atime, stateId, sid, departmentId,depList);
    }

    public int updateAtt(Attendance att) {
        return attendanceMapper.updateAtt(att);
    }

    public boolean deleteAttById(String ids) {
        String[] split = ids.split(",");
        return attendanceMapper.deleteAttById(split) == split.length;
    }

    public List<Attendance> getAllEmployees() {
        return attendanceMapper.getAttByPage(null, null, "", null, null,null, null, null);
    }

    public int addAtts(List<Attendance> atts) {
        return attendanceMapper.addAtts(atts);
    }

    public List<Attendance> getEmployeeByPageShort(Integer page, Integer size) {
        int start = (page - 1) * size;
        return attendanceMapper.getAttByPageShort(start, size);
    }

    public Long getAttCountBySidAndStateId(Long stateId, Long sid) {
        return attendanceMapper.getAttCountBySidAndStateId(stateId, sid);
    }
}

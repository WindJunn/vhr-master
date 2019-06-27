package org.sang.service;

import org.sang.bean.Department;
import org.sang.bean.Hr;
import org.sang.bean.Nation;
import org.sang.bean.Student;
import org.sang.common.DepartmentUtil;
import org.sang.common.Util;
import org.sang.mapper.DepartmentMapper;
import org.sang.mapper.StudentMapper;
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
public class StudentService {

    @Autowired
    StudentMapper studentMapper;

    @Autowired
    DepartmentMapper departmentMapper;


    SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
    SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
    SimpleDateFormat birthdayFormat = new SimpleDateFormat("yyyy-MM-dd");
    DecimalFormat decimalFormat = new DecimalFormat("##.00");

    public List<Nation> getAllNations() {
        return studentMapper.getAllNations();
    }


    public int addStudent(Student student) {
        return studentMapper.addStudent(student);
    }

    public Long getMaxWorkID() {
        Long maxWorkID = studentMapper.getMaxWorkID();
        return maxWorkID == null ? 0 : maxWorkID;
    }

    public List<Student> getStudentByPage(Integer page, Integer size, String keywords, Long nationId, Long departmentId, Long upid) {
        int start = (page - 1) * size;

        List<Long> depList = null;
        if (upid != null && upid != 0) {
            List<Department> deps = departmentMapper.getDepByPid(upid);
            depList = DepartmentUtil.findDeps(upid, deps);
        }
        return studentMapper.getStudentByPage(start, size, keywords, nationId, departmentId, depList);
    }


    public Long getCountByKeywords(String keywords, Long nationId, Long departmentId, Long upid) {
        List<Long> depList = null;
        if (upid != null && upid != 0) {
            List<Department> deps = departmentMapper.getDepByPid(upid);

            depList = DepartmentUtil.findDeps(upid, deps);
        }
        return studentMapper.getCountByKeywords(keywords, nationId, departmentId, depList);
    }

    public int updateStudent(Student student) {
        return studentMapper.updateStudent(student);
    }

    public boolean deleteStudentById(String ids) {
        String[] split = ids.split(",");
        return studentMapper.deleteStudentById(split) == split.length;
    }

    public List<Student> getAllStudents() {
        return studentMapper.getStudentByPage(null, null, "", null, null, null);
    }

    public List<Student> getAllStudentsByDep() {
        List<Long> depList = null;
        Long upid = Util.getCurrentUser().getDepartmentId();

        if (upid != null && upid != 0) {
            List<Department> deps = departmentMapper.getDepByPid(upid);
            depList = DepartmentUtil.findDeps(upid, deps);
        }
        return studentMapper.getStudentByPage(null, null, "", null, null, depList);

    }

    public int addStudents(List<Student> students) {
        return studentMapper.addStudents(students);
    }

    public int updatePoint(Long id) {
        return studentMapper.updatePoint(id);
    }

   /* public List<Student> getEmplStudentByPageShort(Integer page, Integer size) {
        int start = (page - 1) * size;
        return studentMapper.getEmplStudentByPageShort(start,size);
    }*/
}

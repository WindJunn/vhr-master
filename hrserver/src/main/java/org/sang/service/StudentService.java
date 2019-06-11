package org.sang.service;

import org.sang.bean.Department;
import org.sang.bean.Nation;
import org.sang.bean.Student;
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
    DepartmentService departmentService;


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

    public List<Student> getStudentByPage(Integer page, Integer size, String keywords, Long nationId, Long departmentId) {
        int start = (page - 1) * size;
        List<Long> depList=null;
//        List<Department> allDeps = departmentService.getAllDeps();
//        for (Department dep : allDeps) {
//            if (dep.getId().equals(departmentId)){
//                departmentId=dep.getParentId();
//                break;
//            }
//        }
        if (departmentId != null && departmentId != 0){
            List<Department> deps = departmentService.getDepByPid(departmentId);
             depList = new ArrayList<>();
            depList.add(departmentId);
            for (int i = 0; i < deps.size(); i++) {
                depList.add(deps.get(i).getId());
                while (deps.get(i).getChildren().size()>0){

                }
            }
        }
        return studentMapper.getStudentByPage(start, size, keywords, nationId, departmentId,depList);
    }

    public Long getCountByKeywords(String keywords, Long nationId, Long departmentId) {

        return studentMapper.getCountByKeywords(keywords, nationId, departmentId);
    }

    public int updateStudent(Student student) {
        return studentMapper.updateStudent(student);
    }

    public boolean deleteStudentById(String ids) {
        String[] split = ids.split(",");
        return studentMapper.deleteStudentById(split) == split.length;
    }

    public List<Student> getAllStudents() {
        return studentMapper.getStudentByPage(null, null, "", null, null,null);
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

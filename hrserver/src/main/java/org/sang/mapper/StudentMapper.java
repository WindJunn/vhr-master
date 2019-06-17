package org.sang.mapper;

import org.apache.ibatis.annotations.Param;
import org.sang.bean.Nation;
import org.sang.bean.Student;

import java.util.List;

/**
 * Created by sang on 2018/1/12.
 */
public interface StudentMapper {
    List<Nation> getAllNations();


    int addStudent(Student student);

    Long getMaxWorkID();

    List<Student> getStudentByPage(@Param("start") Integer start, @Param("size") Integer size, @Param("keywords") String keywords, @Param("nationId") Long nationId,
                                   @Param("departmentId") Long departmentId,@Param("depList") List depList);

    Long getCountByKeywords(@Param("keywords") String keywords, @Param("nationId") Long nationId,
                            @Param("departmentId") Long departmentId,@Param("depList") List depList);

    int updateStudent(@Param("emp") Student student);

    int deleteStudentById(@Param("ids") String[] ids);

    int addStudents(@Param("emps") List<Student> students);

    int updatePoint(Long id);

//    List<Student> getStudentByPageShort(@Param("start") int start, @Param("size") Integer size);
}

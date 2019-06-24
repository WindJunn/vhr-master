package org.sang;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.sang.bean.Department;
import org.sang.bean.Hr;
import org.sang.service.DepartmentService;
import org.sang.service.HrService;
import org.sang.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.ArrayList;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class HrserverApplicationTest {

    @Autowired
    StudentService studentService;

    @Autowired
    HrService hrService;

    @Test
    public void test() {
        Hr hr = hrService.getHrById(1L);
        String password = hr.getPassword();
        String pass = "admin";
        BCryptPasswordEncoder bcryptPasswordEncoder = new BCryptPasswordEncoder();
        boolean f = bcryptPasswordEncoder.matches("123",password);



    }







}

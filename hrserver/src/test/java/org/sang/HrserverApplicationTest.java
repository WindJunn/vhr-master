package org.sang;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.sang.bean.Department;
import org.sang.service.DepartmentService;
import org.sang.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.ArrayList;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class HrserverApplicationTest {

    @Autowired
    StudentService studentService;

    @Autowired
    DepartmentService departmentService;

    @Test
    public void test() {
        List<Long> depList = null;
//        List<Department> allDeps = departmentService.getAllDeps();
//        for (Department dep : allDeps) {
//            if (dep.getId().equals(departmentId)){
//                departmentId=dep.getParentId();
//                break;
//            }
//        }
        List<Department> deps = departmentService.getDepByPid(94L);
        depList = new ArrayList<>();
//        depList.add(1L);
//        for (int i = 0; i < deps.size(); i++) {
//            depList.add(deps.get(i).getId());
//            List<Department> children = deps.get(i).getChildren();
//            if (children.size()>0) {
//
//            }
//        }
        finddep(deps, depList);
        System.out.println("==============");
        System.out.println(depList);
        System.out.println("==============");

    }

    public void finddep(List<Department> deps, List<Long> depList) {
        if (deps.size() > 0) {
            for (int i = 0; i < deps.size(); i++) {
                Long id = deps.get(i).getId();
                depList.add(id);
                List<Department> children = deps.get(i).getChildren();
                if (children.size() > 0) {
                    finddep(children, depList);
                } else {
                    continue;
                }
            }
        }
    }

    @Test
    public void returnRest() {
        for (int i = 0; i < 5; i++) {
            System.out.println("i值为：" + i);
            if (i == 2)
                return;
            System.out.println("使用return后执行的语句！");
        }
    }

    @Test
    public void testBreak() {
        tag:
        for (int i = 1; i <= 5; i++) {
            // 内层循环
            for (int j = 1; j <= 3; j++) {
                System.out.println("i的值为:" + i + " j的值为:" + j);
                if (j == 2) {
                    break;
                }
            }
        }
    }


}

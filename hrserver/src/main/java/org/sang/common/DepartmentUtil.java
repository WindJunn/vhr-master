package org.sang.common;

import org.sang.bean.Department;
import org.sang.mapper.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

public class DepartmentUtil {

    @Autowired
    DepartmentMapper departmentMapper;


    /**
     * 递归查找当前部门下的子部门
     *
     * @param deps
     * @param depList
     */
    public static void findDep(List<Department> deps, List<Long> depList) {
        if (deps.size() > 0) {
            for (int i = 0; i < deps.size(); i++) {
                Long id = deps.get(i).getId();
                depList.add(id);
                List<Department> children = deps.get(i).getChildren();
                if (children.size() > 0) {
                    findDep(children, depList);
                } else {
                    continue;
                }
            }
        }
    }

    public static List<Long> findDeps(Long upid, List<Department> deps) {
        List<Long> depList = new ArrayList<>();
        depList.add(upid);
        DepartmentUtil.findDep(deps, depList);
        return depList;
    }
}

package org.sang.common;

import org.sang.bean.Department;

import java.util.List;

public class DepartmentUtil {


    /**
     * 递归查找当前部门下的子部门
     * @param deps
     * @param depList
     */
    public static void findDep(List<Department> deps, List<Long> depList) {
        if (deps.size()>0){
            for (int i = 0; i < deps.size(); i++) {
                Long id = deps.get(i).getId();
                depList.add(id);
                List<Department> children = deps.get(i).getChildren();
                if (children.size()>0) {
                    findDep(children,depList);
                } else {
                    continue;
                }
            }
        }
    }
}

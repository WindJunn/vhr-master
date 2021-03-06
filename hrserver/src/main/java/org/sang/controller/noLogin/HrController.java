package org.sang.controller.noLogin;

import org.sang.bean.Department;
import org.sang.bean.Hr;
import org.sang.bean.RespBean;
import org.sang.common.poi.UserPoiUtils;
import org.sang.service.DepartmentService;
import org.sang.service.HrService;
import org.sang.service.RoleService;
import org.sang.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by sang on 2018/1/2.
 */
@RestController
@RequestMapping("/hr")
public class HrController {
    @Autowired
    HrService hrService;

    @Autowired
    StudentService studentService;
    @Autowired
    DepartmentService departmentService;

    @Autowired
    RoleService roleService;

    @RequestMapping(value = "/basicdata", method = RequestMethod.GET)
    public Map<String, Object> getAllNations() {
        Map<String, Object> map = new HashMap<>();
        map.put("nations", studentService.getAllNations());
        map.put("deps", departmentService.getDepByPid(-1L));
        map.put("roles", roleService.roles());
        return map;
    }

    @RequestMapping(value = "/dep", method = RequestMethod.GET)
    public Map<String, Object> getAllDeps(Long id) {
        Map<String, Object> map = new HashMap<>();
        map.put("deps", departmentService.getDepByPid(id));
        return map;
    }


    @RequestMapping("/id/{hrId}")
    public Hr getHrById(@PathVariable Long hrId) {
        return hrService.getHrById(hrId);
    }

    @RequestMapping("/name/{username}")
    public Hr getHrByUsername(@PathVariable String username) {
        return hrService.getHrByUsername(username);
    }

    @RequestMapping("/logins")
    public RespBean getHrByUsernameAndPassword(String username, String password) {
        Hr hr = hrService.getHrByUsernameAndPassword(username, password);
        if (hr != null) {
            return RespBean.ok("登录成功!", hr);
        }
        return RespBean.error("账号或密码错误！");

    }

    @RequestMapping(value = "/{ids}", method = RequestMethod.DELETE)
    public RespBean deleteHrs(@PathVariable String ids) {
        if (hrService.deleteHrs(ids)) {
            return RespBean.ok("删除成功!");
        }
        return RespBean.error("删除失败!");
    }

    @RequestMapping(value = "/", method = RequestMethod.PUT)
    public RespBean updateHr(Hr hr) {
        if (hrService.updateHr(hr) == 1) {
            return RespBean.ok("更新成功!");
        }
        return RespBean.error("更新失败!");
    }

    @RequestMapping(value = "/roles", method = RequestMethod.PUT)
    public RespBean updateHrRoles(Long hrId, Long[] rids) {
        if (hrService.updateHrRoles(hrId, rids) == rids.length) {
            return RespBean.ok("更新成功!");
        }
        return RespBean.error("更新失败!");
    }

    @RequestMapping(value = "/")
    public Map<String, Object> getHrsByKeywords(@RequestParam(defaultValue = "1") Integer page,
                                                @RequestParam(defaultValue = "10") Integer size,
                                                @RequestParam(defaultValue = "") String keywords,
                                                Long nationId, Long departmentId, Long upid, String nameZh) {
        List<Hr> hrs = hrService.getHrsByKeywords(page, size, keywords, nationId, departmentId, upid, nameZh);
        Map<String, Object> map = new HashMap<>();
        map.put("hrs", hrs);
        return map;
    }


    @RequestMapping(value = "/hr/reg", method = RequestMethod.POST)
    public RespBean hrReg(String username, String password) {
        int i = hrService.hrReg(username, password);
        if (i == 1) {
            return RespBean.ok("注册成功!");
        } else if (i == -1) {
            return RespBean.error("用户名重复，注册失败!");
        }
        return RespBean.error("注册失败!");
    }


    @RequestMapping(value = "/updateps", method = RequestMethod.POST)
    public RespBean updateHrPassword(String username, String password) {
        int i = hrService.updateHrPassword(username, password);
        if (i == 1) {
            return RespBean.ok("修改成功!");
        }
        return RespBean.error("修改失败!");
    }

    @RequestMapping(value = "/", method = RequestMethod.POST)
    public RespBean addHr(Hr hr) {

        if (hrService.addHr(hr) == 1) {
            return RespBean.ok("添加成功!");
        }
        return RespBean.error("添加失败!");
    }

    @RequestMapping(value = "/exportUsers", method = RequestMethod.GET)
    public ResponseEntity<byte[]> exportEmp() {
        Map<String, Object> map = getAllNations();
        List<Hr> hrs = hrService.getAllHr();
        List<Department> depss = departmentService.getAllDeps();
        map.put("depss", depss);
        map.put("hrs", hrs);

        return UserPoiUtils.exportUser2Excel(map);
    }

    @RequestMapping(value = "/importUsers", method = RequestMethod.POST)
    public RespBean importEmp(MultipartFile file) {
        List<Hr> hrs = UserPoiUtils.importUser2List(file,
                studentService.getAllNations(), departmentService.getAllDeps());
        if (hrService.addHrs(hrs) == hrs.size()) {
            return RespBean.ok("导入成功!");
        }
        return RespBean.error("导入失败!");
    }

}

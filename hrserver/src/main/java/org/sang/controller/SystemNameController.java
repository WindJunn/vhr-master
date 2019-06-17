package org.sang.controller;

import org.sang.bean.RespBean;
import org.sang.bean.SystemName;
import org.sang.service.SystemnameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 超级管理员专属Controller
 */
@RestController
@RequestMapping("/systems/name")
public class SystemNameController {
    @Autowired
    SystemnameService systemnameService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public List<SystemName> getAllSysName() {
        return systemnameService.getAllSysName();
    }


    @RequestMapping(value = "/", method = RequestMethod.PUT)
    public RespBean updateSysNameById(String title, String leftname) {
        int i = systemnameService.updateSysNameById(title, leftname);
        if (i == 1) {
            return RespBean.ok("修改成功!");
        }
        return RespBean.error("修改失败!");
    }
}

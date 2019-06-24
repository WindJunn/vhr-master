package org.sang.controller;

import org.sang.bean.Articletop;
import org.sang.bean.Attname;
import org.sang.bean.RespBean;
import org.sang.service.ArticletopService;
import org.sang.service.AttnameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 *
 */
@RestController
@RequestMapping("/top")
public class ArticletopController {
    @Autowired
    ArticletopService articletopService;

    @RequestMapping(value = "/", method = RequestMethod.PUT)
    public RespBean updateArticletop(Articletop articletop) {
        int i = articletopService.updateArticletop(articletop);
        if (i == 1) {
            return  RespBean.ok("修改成功!");
        }
        return  RespBean.error("修改失败!");
    }

    @RequestMapping(value = "/aid", method = RequestMethod.PUT)
    public RespBean updateArticletopAid(Long aid) {
        int i = articletopService.updateArticletopAid(aid);
        if (i == 1) {
            return  RespBean.ok("修改成功!");
        }
        return  RespBean.error("修改失败!");
    }


    @RequestMapping(value = "/", method = RequestMethod.GET)
    public Articletop getArticletop() {
        return articletopService.getArticletop();
    }

}

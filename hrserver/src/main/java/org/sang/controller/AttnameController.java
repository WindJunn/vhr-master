package org.sang.controller;

import org.sang.bean.Attname;
import org.sang.bean.RespBean;
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
@RequestMapping("/attname")
public class AttnameController {
    @Autowired
    AttnameService attnameService;

    @RequestMapping(value = "/all", method = RequestMethod.GET)
    public List<Attname> getAllCategories() {
        return attnameService.getAllCategories();
    }

    @RequestMapping(value = "/{ids}", method = RequestMethod.DELETE)
    public RespBean deleteById(@PathVariable String ids) {
        boolean result = attnameService.deleteCategoryByIds(ids);
        if (result) {
            return  RespBean.ok( "删除成功!");
        }
        return  RespBean.error("删除失败!");
    }

    @RequestMapping(value = "/", method = RequestMethod.POST)
    public RespBean addNewCate(Attname attname) {
        int result = attnameService.addCategory(attname);
        if (result == 1) {
            return  RespBean.ok( "添加成功!");
        }
        return  RespBean.error( "添加失败!");
    }

    @RequestMapping(value = "/", method = RequestMethod.PUT)
    public RespBean updateCate(Attname attname) {
        int i = attnameService.updateCategoryById(attname);
        if (i == 1) {
            return  RespBean.ok("修改成功!");
        }
        return  RespBean.error("修改失败!");
    }
}

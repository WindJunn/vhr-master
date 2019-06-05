package org.sang.controller;

import org.sang.bean.Pointoption;
import org.sang.bean.RespBean;
import org.sang.service.PointoptionService;
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
@RequestMapping("/pointoption")
public class PointoptionController {
    @Autowired
    PointoptionService pointoptionService;

    @RequestMapping(value = "/all", method = RequestMethod.GET)
    public List<Pointoption> getAllPointoption( ) {
        return pointoptionService.getAllPointoption();
    }

    @RequestMapping(value = "/{ids}", method = RequestMethod.DELETE)
    public RespBean deletePointoptionByIds(@PathVariable String ids) {
        boolean result = pointoptionService.deletePointoptionByIds(ids);
        if (result) {
            return  RespBean.ok( "删除成功!");
        }
        return  RespBean.error("删除失败!");
    }

    @RequestMapping(value = "/", method = RequestMethod.POST)
    public RespBean addPointoption(Pointoption pointoption) {
        int result = pointoptionService.addPointoption(pointoption);
        if (result == 1) {
            return  RespBean.ok( "添加成功!");
        }
        return  RespBean.error( "添加失败!");
    }

    @RequestMapping(value = "/", method = RequestMethod.PUT)
    public RespBean updatePointoption(Pointoption pointoption) {
        int i = pointoptionService.updatePointoption(pointoption);
        if (i == 1) {
            return  RespBean.ok("修改成功!");
        }
        return  RespBean.error("修改失败!");
    }
}

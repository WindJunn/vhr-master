package org.sang.controller;

import org.sang.bean.Point;
import org.sang.bean.RespBean;
import org.sang.service.PointService;
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
@RequestMapping("/point")
public class PointController {
    @Autowired
    PointService pointService;

    @RequestMapping(value = "/all/{sid}", method = RequestMethod.GET)
    public List<Point> getAllCategories(@PathVariable Long sid) {
        return pointService.getPointsById(sid);
    }

    @RequestMapping(value = "/{ids}", method = RequestMethod.DELETE)
    public RespBean deleteById(@PathVariable String ids) {
        boolean result = pointService.deletePointByIds(ids);
        if (result) {
            return  RespBean.ok( "删除成功!");
        }
        return  RespBean.error("删除失败!");
    }

    @RequestMapping(value = "/", method = RequestMethod.POST)
    public RespBean addNewCate(Point point) {
        int result = pointService.addPoint(point);
        if (result == 1) {
            return  RespBean.ok( "添加成功!");
        }
        return  RespBean.error( "添加失败!");
    }

    @RequestMapping(value = "/", method = RequestMethod.PUT)
    public RespBean updateCate(Point point) {
        int i = pointService.updatePoint(point);
        if (i == 1) {
            return  RespBean.ok("修改成功!");
        }
        return  RespBean.error("修改失败!");
    }
}

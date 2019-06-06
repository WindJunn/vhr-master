package org.sang.controller;

import org.sang.bean.Point;
import org.sang.bean.RespBean;
import org.sang.service.PointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 */
@RestController
@RequestMapping("/point")
public class PointController {
    @Autowired
    PointService pointService;

    @RequestMapping(value = "/all/{sid}", method = RequestMethod.GET)
    public Map<String, Object> getPointsById(@PathVariable Long sid) {
        Map<String, Object> map = new HashMap<>();

        List<Point> points = pointService.getPointsById(sid);
        map.put("points",points);
        return map;

    }

    @RequestMapping(value = "/{ids}", method = RequestMethod.DELETE)
    public RespBean deletePointByIds(@PathVariable String ids) {
        boolean result = pointService.deletePointByIds(ids);
        if (result) {
            return  RespBean.ok( "删除成功!");
        }
        return  RespBean.error("删除失败!");
    }

    @RequestMapping(value = "/", method = RequestMethod.POST)
    public RespBean addPoint(Point point) {
        int result = pointService.addPoint(point);
        if (result == 1) {
            return  RespBean.ok( "添加成功!");
        }
        return  RespBean.error( "添加失败!");
    }

    @RequestMapping(value = "/", method = RequestMethod.PUT)
    public RespBean updatePoint(Point point) {
        int i = pointService.updatePoint(point);
        if (i == 1) {
            return  RespBean.ok("修改成功!");
        }
        return  RespBean.error("修改失败!");
    }
}

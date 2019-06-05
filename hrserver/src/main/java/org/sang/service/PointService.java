package org.sang.service;

import org.sang.bean.Point;
import org.sang.mapper.PointMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by sang on 2017/12/19.
 */
@Service
@Transactional
public class PointService {
    @Autowired
    PointMapper pointMapper;

    public List<Point> getPointsById(Long sid) {
        return pointMapper.getPointsById(sid);
    }

    public boolean deletePointByIds(String ids) {
        String[] split = ids.split(",");
        int result = pointMapper.deletePointByIds(split);
        return result == split.length;
    }

    public int updatePoint(Point point) {
        return pointMapper.updatePoint(point);
    }

    public int addPoint(Point point) {
        return pointMapper.addPoint(point);
    }
}

package org.sang.mapper;

import org.apache.ibatis.annotations.Param;
import org.sang.bean.Point;

import java.util.List;

/**
 * Created by sang on 2018/1/12.
 */
public interface PointMapper {

    List<Point> getPointsById(Long sid);

    int addPoint( Point point);

    int updatePoint(Point point);

    int deletePointByIds(@Param("ids") String[] ids);

}

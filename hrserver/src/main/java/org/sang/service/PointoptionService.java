package org.sang.service;

import org.sang.bean.Pointoption;
import org.sang.mapper.PointoptionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by sang on 2017/12/19.
 */
@Service
@Transactional
public class PointoptionService {
    @Autowired
    PointoptionMapper pointoptionMapper;

    public List<Pointoption> getAllPointoption() {
        return pointoptionMapper.getAllPointoption();
    }

    public boolean deletePointoptionByIds(String ids) {
        String[] split = ids.split(",");
        int result = pointoptionMapper.deletePointoptionByIds(split);
        return result == split.length;
    }

    public int updatePointoption(Pointoption pointoption) {
        return pointoptionMapper.updatePointoption(pointoption);
    }

    public int addPointoption(Pointoption pointoption) {
        return pointoptionMapper.addPointoption(pointoption);
    }
}

package org.sang.service;


import org.sang.bean.Articletop;
import org.sang.mapper.ArticletopMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * Created by sang on 2017/12/20.
 */
@Service
@Transactional
public class ArticletopService {
    @Autowired
    ArticletopMapper articletopMapper;

    public int updateArticletop(Articletop articletop) {
        return articletopMapper.updateArticletop(articletop);
    }

    public int updateArticletopAid(Long aid) {
        return articletopMapper.updateArticletopAid(aid);
    }

    public Articletop getArticletop() {
        return articletopMapper.getArticletop();
    }

}

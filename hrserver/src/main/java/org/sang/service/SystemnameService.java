package org.sang.service;

import org.sang.bean.SystemName;
import org.sang.mapper.SystemnameMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by sang on 2017/12/19.
 */
@Service
@Transactional
public class SystemnameService {
    @Autowired
    SystemnameMapper systemnameMapper;

    public List<SystemName> getAllSysName() {
        return systemnameMapper.getAllSysName();
    }

    public int updateSysNameById(String title, String leftname) {
        return systemnameMapper.updateSysNameById(title, leftname);
    }

}

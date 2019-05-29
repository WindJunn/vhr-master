package org.sang.service;

import org.sang.bean.Attname;
import org.sang.mapper.AttnameMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by sang on 2017/12/19.
 */
@Service
@Transactional
public class AttnameService {
    @Autowired
    AttnameMapper attnameMapper;

    public List<Attname> getAllCategories() {
        return attnameMapper.getAllAtt();
    }

    public boolean deleteCategoryByIds(String ids) {
        String[] split = ids.split(",");
        int result = attnameMapper.deleteAttnameByIds(split);
        return result == split.length;
    }

    public int updateCategoryById(Attname attname) {
        return attnameMapper.updateAttById(attname);
    }

    public int addCategory(Attname attname) {
        return attnameMapper.addAtt(attname);
    }
}

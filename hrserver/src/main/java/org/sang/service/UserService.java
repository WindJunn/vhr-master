package org.sang.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by sang on 2017/12/17.
 */
@Service
@Transactional
public class UserService implements UserDetailsService {
    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        return null;
    }
//    @Autowired
//    HrMapper hrMapper;
//    @Autowired
//    RoleMapper rolesMapper;

  /*  @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        Hr user = hrMapper.loadUserByUsername(s);
        if (user == null) {
            //避免返回null，这里返回一个不含有任何值的User对象，在后期的密码比对过程中一样会验证失败
            return new Hr();
        }
        //查询用户的角色信息，并返回存入user中
//        List<Role> roles = rolesMapper.getRolesByUid(user.getId());
//        user.setRoles(roles);
        return user;
    }*/

    /**
     * @param user
     * @return 0表示成功
     * 1表示用户名重复
     * 2表示失败
     */
  /*  public int reg(Hr user) {
        Hr loadUserByUsername = hrMapper.loadUserByUsername(user.getUsername());
        if (loadUserByUsername != null) {
            return 1;
        }
        //插入用户,插入之前先对密码进行加密
        user.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));
        user.setEnabled(true);//用户可用
//        long result = hrMapper.reg(user);
        //配置用户的角色，默认都是普通用户
        String[] roles = new String[]{"2"};
//        int i = rolesMapper.addRoles(roles, user.getId());
//        boolean b = i == roles.length && result == 1;
        if (b) {
            return 0;
        } else {
            return 2;
        }
    }

    public int updateUserEmail(String email) {
        return hrMapper.updateUserEmail(email, Util.getCurrentUser().getId());
    }

    public List<Hr> getUserByNickname(String nickname) {
        List<Hr> list = hrMapper.getUserByNickname(nickname);
        return list;
    }

    public List<Role> getAllRole() {
        return hrMapper.getAllRole();
    }

    public int updateUserEnabled(Boolean enabled, Long uid) {
        return hrMapper.updateUserEnabled(enabled, uid);
    }

    public int deleteUserById(Long uid) {
        return hrMapper.deleteUserById(uid);
    }

    public int updateUserRoles(Long[] rids, Long id) {
        int i = hrMapper.deleteUserRolesByUid(id);
        return hrMapper.setUserRoles(rids, id);
    }

    public Hr getUserById(Long id) {
        return hrMapper.getUserById(id);
    }*/
}

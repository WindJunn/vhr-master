package org.sang.controller;

import org.sang.bean.Hr;
import org.sang.bean.RespBean;
import org.sang.service.HrService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by sang on 2017/12/17.
 */
@RestController
public class LoginRegController {

    @Autowired
    HrService hrService;

    @RequestMapping("/login_error")
    public RespBean loginError() {
        return  RespBean.error( "登录失败!");
    }

    @RequestMapping("/login_success")
    public RespBean loginSuccess() {
        return  RespBean.ok("success", "登录成功!");
    }

    /**
     * 如果自动跳转到这个页面，说明用户未登录，返回相应的提示即可
     * <p>
     * 如果要支持表单登录，可以在这个方法中判断请求的类型，进而决定返回JSON还是HTML页面
     *
     * @return
     */
    @RequestMapping("/login_page")
    public RespBean loginPage() {
        return  RespBean.error("尚未登录，请登录!");
    }

    @RequestMapping("/reg")
    public RespBean reg(Hr user) {
        int result = hrService.hrReg(user.getUsername(),user.getPassword());
        if (result == 0) {
            //成功
            return  RespBean.ok("注册成功!");
        } else if (result == 1) {
            return  RespBean.error("用户名重复，注册失败!");
        } else {
            //失败
            return  RespBean.error("注册失败!");
        }
    }
}

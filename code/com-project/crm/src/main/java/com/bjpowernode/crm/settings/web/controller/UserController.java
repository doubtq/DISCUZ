package com.bjpowernode.crm.settings.web.controller;

import com.bjpowernode.crm.commors.contants.Contants;
import com.bjpowernode.crm.commors.domain.ReturnObject;
import com.bjpowernode.crm.commors.utils.DateUtils;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.UserService;
import org.apache.poi.ss.usermodel.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.xml.crypto.Data;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/setting/qx/user/toLogin.do")
    public String toLogin() {
        return "settings/qx/user/login";
    }

    @RequestMapping("/settings/qx/user/login.do")
    public @ResponseBody Object login(String loginAct, String loginPwd, String isRemPwd, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        map.put("loginAct", loginAct);
        map.put("loginPwd", loginPwd);

        User user = userService.queryUserByLoginActAndPwd(map);

        ReturnObject returnObject=new ReturnObject();

        if (user == null) {
            returnObject.setCode(Contants.RETURN_OBJECT_CODE_FALL);
            returnObject.setMessage("用户名或密码错误");
        } else {
//        user.getExpireTime()
//                new Data()


            if (DateUtils.fromateDateTime(new Date()).compareTo(user.getExpireTime()) > 0) {

                returnObject.setCode(Contants.RETURN_OBJECT_CODE_FALL);
                returnObject.setMessage("账号已过期");
            } else if ("0".equals(user.getLockState())) {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_FALL);
                returnObject.setMessage("状态被锁定");
            } else if (!user.getAllowIps().contains(request.getRemoteAddr())) {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_FALL);
                returnObject.setMessage("ip受限");

            } else {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);

            }

        }
        return returnObject;
    }

}

package com.xiaoqiang.controller;

import com.xiaoqiang.entity.Student;
import com.xiaoqiang.entity.Teacher;
import com.xiaoqiang.entity.User;
import com.xiaoqiang.service.StudentService;
import com.xiaoqiang.service.TeacherService;
import com.xiaoqiang.service.UserService;
import com.xiaoqiang.utils.MapControll;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
public class LogoutController {


    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:login";
    }

}

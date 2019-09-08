package com.loocc.controller;

import com.loocc.domain.Department;
import com.loocc.domain.Msg;
import com.loocc.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/dept")
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;
    /**
     * 返回所有的部门信息
     */
    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
         List<Department> listDept = departmentService.getDepts();
        return Msg.success().add("listDept",listDept);
    }
}

package com.loocc.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.loocc.domain.Employee;
import com.loocc.domain.Msg;
import com.loocc.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/emps")
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;
    /**
     * 查询员工数据(分布查询)
     * @return
     */
    @RequestMapping("/showEmps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
         //引入PageHelper插件
        //在查询之前只需要调用,插入页码,以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟扩查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //用pageinfo 包装查询的结果集,只要将pageInfo交给页面就行
        //里面封装了详细的分页信息,下面的5是显示连续显示的页数
        PageInfo pageInfo = new PageInfo(emps,5);
        model.addAttribute("pageInfo",pageInfo);

        return "list";
    }

    /**
     * @ResponseBody 以json字符串扩形式返回 需要引用jackson的包
     * @param pn
     * @return
     */
    @RequestMapping("/empsWithJson")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){

        PageHelper.startPage(pn,5);
        List<Employee> emps = employeeService.getAll();
        //for(Employee emp :emps){
        //    System.out.println(emp.getEmpName());
        //    System.out.println(emp.getGender());
        //    System.out.println(emp.getEmail());
        //    System.out.println(emp.getdId());
        //    System.out.println(emp.getEmpId());
        //}
        PageInfo pageInfo = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    /**
     * 员工 保存
     * 1，支持JSR303校验
     * 导入Hibernate-Validator
     * @Valid 保存用户的时候用JSR303校验，并把校验结果封装到result中
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/saveEmp", method=RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
        //  校验失败，在模态框中显示提示信息
            Map<String,Object>map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();//得到所有的错误信息
            for(FieldError error:errors){
                System.out.println("错误的字段名："+error.getField());
                System.out.println("错误信息："+error.getDefaultMessage());
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);

        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }

    @ResponseBody
    @RequestMapping("/checkUser")
    public Msg checkUser(String empName){
        /**
         * js中的正则表达示有/，java没有
         * （前端已校验，这是后端校验）
         *
         */
        String rex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(rex)){
                return Msg.fail().add("va_msg","用户名格式不对！");
        }
        boolean b = employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail();
        }
    }


    /**
     *
     * 根据id查询员工
     * @PathVariable可以从动态的url中获取请求入参
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getEmp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }


    /**
     *如果直接 发送put请求
     * 封装的数据  Employee{empId=1024, empName='null', gender='null', email='null', dId=null}
     * 员工更新,参数名和emp bean中的id名一样，不然不能更新。
     * 问题：
     * 请求体中有数据，但是Employee对象封装不上
     * 原因：
     * tomcat：1、将请求体中的数据封装成一个map，
     *     2、request.getParameter("empName")就会从map中取值
     *      3、springmvc封装pojo对象的时候，会把POJO中每个属性的值，从request.getParameter中取出来
     *      赋值
     *      ajax发送put请求的问题
     *      put请求，请求体中的数据，request.getParameter("empName")拿不到
     *      tomcat看到是put请求就不会封装请求体中的数据为map，只有post请求才封装请求体为map
     *
     *      解决方案;
     *         springmvc提供了一个过虑器HttpPutFormContentFilter
     *          配置后，会帮我们把请求体中的数据封装成一个map，request被重新包装，
     *          request.getParameter()方法被重写，就会从自己封装的map中取数据
     *
     *
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/updateEmp/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee){
        System.out.println("更新的员工数据："+employee.toString());
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    /**
     *
     * 单个批量二合一
     *  批量删除用：1-2-3
     * PathVariable  从路径中取出id的值
     * @param empIds
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/deleteEmpById/{empId}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("empId") String empIds){
        //批量删除
        if(empIds.contains("-")){
            List<Integer> listIds = new ArrayList<>();
            String[] ids = empIds.split("-");
            for(String id:ids){
                listIds.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(listIds);
        }else{
            //单个删除
            try {
                Integer id = Integer.parseInt(empIds);
                employeeService.deleteEmp(id);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        return Msg.success();
    }

}

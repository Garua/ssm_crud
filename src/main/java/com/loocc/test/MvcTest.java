package com.loocc.test;

import com.github.pagehelper.PageInfo;
import com.loocc.domain.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用spring测试模块提供的请求功能,测试crud请求的正确性\
 * Spring4测试的时候,需要Servlet3.0及以上的支持
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MvcTest {

    //虚拟的mvc请求,获取到处理结果
    MockMvc mockMvc;

    //传入springmvc的ioc,要Autowired容器,需要加一个WebAppConfiguration注解
    @Autowired
    WebApplicationContext context;

    @Before
    public void initMockMvc(){
         mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }


    @Test
    public void testPage() throws Exception{
        //模拟请求(传递参数)并拿到返回值
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/emps/showEmps").param("pn", "1")).andReturn();
        //请求域中有pageInfo

        //得到request
        MockHttpServletRequest request = mvcResult.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码:"+pageInfo.getPageNum());
        System.out.println("总页码:"+pageInfo.getPages());
        System.out.println("总记录数:"+pageInfo.getTotal());
        System.out.println("在页面需要连接显示的页码:");
        int [] nums = pageInfo.getNavigatepageNums();
        for(int i:nums){
            System.out.print("  "+i);
        }
        //拿到员工数据
        List<Employee> list = pageInfo.getList();
        for(Employee employee:list){
            System.out.println("ID:"+employee.getEmpId()+"==>"+employee.getEmpName());
        }

    }
}

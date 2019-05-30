package com.loocc.test;

import com.loocc.dao.DepartmentMapper;
import com.loocc.dao.EmployeeMapper;
import com.loocc.domain.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 测试dao层的工作
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class MapperTest {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;
    /**
     * 测试部门
     */
    @Test
    public void testCRUD(){

        //System.out.println(departmentMapper);
        //departmentMapper.insertSelective(new Department(null,"开发部"));
        //departmentMapper.insertSelective(new Department(null,"测试部"));

        System.out.println(employeeMapper);
        //employeeMapper.insertSelective(new Employee(null,"loocc","M","loocc@qq.com",1));
        //批量插入多个员工
        //EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        //for(int i = 0;i < 1000;i++){
        //    String uid = UUID.randomUUID().toString().substring(0, 5)+i;
        //    mapper.insertSelective(new Employee(null,uid,"M",uid+"@qq.com",1));
        //}
        System.out.println(employeeMapper.selectByPrimaryKey(2));
    }
}

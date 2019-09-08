package com.loocc.service;

import com.loocc.dao.EmployeeMapper;
import com.loocc.domain.Employee;
import com.loocc.domain.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return true,当前姓名可用
     */
    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }


    public void saveEmp(Employee employee){
        if(checkUser(employee.getEmpName())){
            employeeMapper.insertSelective(employee);
        }

    }

    public boolean checkUser(@RequestParam("empName") String empName){
        //创建查询条件
        EmployeeExample example = new EmployeeExample();
      EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    //按照id查询员工
    public Employee getEmp(Integer id){
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }


    //有选择的更新
    public void updateEmp(Employee employee){
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmp(Integer id){
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids){
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //delete from xxx where emp_id in (1,2,3,45);
        criteria.andEmpIdIn(ids);
        employeeMapper .deleteByExample(example);


    }

}

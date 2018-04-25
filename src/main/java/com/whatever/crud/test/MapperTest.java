package com.whatever.crud.test;

import com.whatever.crud.bean.Department;
import com.whatever.crud.bean.Employee;
import com.whatever.crud.dao.DepartmentMapper;
import com.whatever.crud.dao.EmployeeMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Test
    public void testCRUD(){

        /*
        // use spring context
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
        */

//        System.out.println(departmentMapper);
//
//        departmentMapper.insertSelective(new Department(null, "开发部"));
//        departmentMapper.insertSelective(new Department(null, "测试部"));

        employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@whatever.com", 4));

    }
}

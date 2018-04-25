package com.whatever.crud.service;

import com.whatever.crud.bean.Employee;
import com.whatever.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> getAll() {
        return  employeeMapper.selectByExampleWithDept(null);
    }
}

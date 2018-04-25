package com.whatever.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.whatever.crud.bean.Employee;
import com.whatever.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();

        PageInfo page = new PageInfo(emps);
        model.addAttribute("pageInfo", page);
        return "list";
    }
}

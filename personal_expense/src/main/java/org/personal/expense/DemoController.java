package org.personal.expense;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/personal/expense")
public class DemoController {

    @GetMapping(value = "/save")
    public String saveExpense(){
        return "Save Personal Expense Detail";
    }

    @GetMapping(value = "/get")
    public String getExpense(){
        return "Get Personal Expense";
    }
}

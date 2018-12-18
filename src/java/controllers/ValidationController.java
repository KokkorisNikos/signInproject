/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import dao.UserDAO;
import entities.User;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import validators.UserValidator;

/**
 *
 * @author nikos
 */
@RestController
public class ValidationController {

    @Autowired
    private UserDAO userDao;

    @Autowired
    UserValidator userValidator;
    

    @RequestMapping(value = "/emailConfirmation.htm", method = RequestMethod.GET, headers = "Accept=*/*", //header den einai ipoxrewtiko, mporw na valw mono
            produces = "application/json")                                                  //to onoma tis efarmogis gia na dexetai rquest mno apo tin efarmogi
    public @ResponseBody
    String checkMail(@RequestParam("userInput") String userInput) throws JsonProcessingException {       //sto produces lew ti 8a epistrepsw(xml, json h text)     
        List<User> users = userDao.searchUser(userInput);
        
        if (users.size() == 1) {
            String json = "[{\"message\":\"Email allready exists!\"}]";
            return json;
        } else {
            String json = "[{\"message\":\"Success\"}]";
            return json;
        }
    }
    
  
}

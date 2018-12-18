/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.UserDAO;
import entities.User;
import helper.BCrypt;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import validators.UserValidator;

/**
 *
 * @author nikos
 */
@Controller
@RequestMapping(value = "/user")

public class UserController {

    @Autowired
    UserDAO userDao;

    @Autowired
    UserValidator userValidator;

    @Autowired
    ServletContext servletContext;

    @RequestMapping(value = "/userregister.htm", method = RequestMethod.GET)
    public String register(ModelMap model) {
        User user = new User();
        model.addAttribute("user", user);
        return "register";
    }

    @RequestMapping(value = "userSignIn.htm")
    public String userSignIn(HttpSession session, ModelMap model, @RequestParam(value = "email") String email, @RequestParam(value = "password") String password) {

        String SignInInfo = "";
        User user = new User();
        List<User> userlist = userDao.checkUserLogin(email);

        System.out.println(userlist.isEmpty());
        if (!userlist.isEmpty()) {
            user = userlist.get(0);
            if (!BCrypt.checkpw(password, user.getPassword())) {
                model.addAttribute("message", "Incorrect  Password.");
                model.addAttribute("student", new User());
                return "index";
            } else {
                session.setAttribute("user", user);
                model.addAttribute("student", user);
                return "user_view";
            }
        }
        model.addAttribute("message", "Incorrect Username.");
        model.addAttribute("student", new User());
        return "index";

    }

    @RequestMapping(value = "/userregistration.htm", method = RequestMethod.POST)
    public String receiveRegistrationForm(HttpSession session, HttpServletRequest request,
            ModelMap model, User user,
            BindingResult bindingResult
    ) {
        List<User> students = userDao.searchUser(user.getEmail());
        userValidator.validate(user, bindingResult);
        if (bindingResult.hasErrors()) {
            System.out.println(bindingResult.getErrorCount());
            model.addAttribute("user", new User());
            return "register";
        } else {
            String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            user.setPassword(hashed);
            user.setFirstName(user.getFirstName().substring(0, 1).toUpperCase() + user.getFirstName().substring(1).toLowerCase());
            user.setLastName(user.getLastName().substring(0, 1).toUpperCase() + user.getLastName().substring(1).toLowerCase());
            userDao.insertUser(user);
            session.setAttribute("user", user);
            model.addAttribute("user", user);
            return "user_view";
        }
    }

    @RequestMapping(value = "/logOut.htm", method = RequestMethod.GET)
    public String logOut(ModelMap model, HttpSession session) {
        User user = new User();
        model.addAttribute("user", user);
        session.invalidate();
        return "index";
    }

    @RequestMapping(value = "/photoUpload.htm", method = RequestMethod.POST)
    public String photoUpload(HttpSession session,ModelMap model, @RequestParam("file") MultipartFile file) {
        try {
            BufferedOutputStream image = null;
            File f = null;
            if (!file.getOriginalFilename().isEmpty()) {

                try {
                    image = new BufferedOutputStream(new FileOutputStream(new File("C:\\images\\", file.getOriginalFilename())));
                    image.write(file.getBytes());
                    image.flush();
                    image.close();
                } catch (FileNotFoundException ex) {
                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (IOException ex) {
                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                
                }
            } else {
                model.addAttribute("message", "Something went wrong please try again");
                return "user_view";
            }
            User u =(User) session.getAttribute("user");
            u.setImage(file.getBytes());
            userDao.photoUpload(u);
        } catch (IOException ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return "user_view";
    }
}

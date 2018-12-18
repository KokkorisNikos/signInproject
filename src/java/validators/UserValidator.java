/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package validators;

import entities.User;
import helper.EmailValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 *
 * @author nikos
 */
@Component
public class UserValidator implements Validator {

    @Autowired
    private DataValidation dataValidation;

    @Override
    public boolean supports(Class<?> type) {
        return User.class.equals(type);
    }


    @Override
    public void validate(Object o, Errors errors) {
        User user = (User) o;
        EmailValidator validmail = new EmailValidator();
        boolean checkEmail = validmail.validateEmail(user.getEmail());
        boolean checkValidationPassword = dataValidation.checkPasswords(user.getPassword(), user.getPasswordValidation());
        boolean checkEmailExcists = dataValidation.checkEmailExcists(user);
        boolean checkLastname = dataValidation.checkLastname(user);
        boolean checkPassword = dataValidation.checkPassword(user);
        boolean checkFirstname = dataValidation.checkFirstname(user);
        if (checkFirstname == false) {
            errors.rejectValue("firstName", "Fname");
        }
        if (checkEmailExcists == false) {
            errors.rejectValue("email", "mail");
        }
        if (checkLastname == false) {
            errors.rejectValue("lastName", "lname");
        }
        if (checkPassword == false) {
            errors.rejectValue("password", "pass");
        }
        if (checkEmail == false) {
            errors.rejectValue("email", "mail");
        }
        if (checkValidationPassword == false) {
            errors.rejectValue("passwordValidation", "PasswordValidation");
        }
    }

}

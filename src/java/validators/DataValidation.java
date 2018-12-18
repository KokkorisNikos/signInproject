/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package validators;

import dao.UserDAO;
import entities.User;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 *
 * @author nikos
 */
@Component
public class DataValidation {

    @Autowired
    private UserDAO userDao;

    public boolean checkEmailExcists(User user) {
        List<User> users= userDao.checkUserMail(user.getEmail(), user.getPassword());
        return users.isEmpty();
    }

    public boolean checkFirstname(User user) {
        if (user.getFirstName().length() < 3 || user.getFirstName().length() > 10) {
            System.out.println("Firstname must have min 3 and max 10 characters");
            return false;
        }
        for (char c : user.getFirstName().toCharArray()) {
            if (!Character.isLetter(c)) {
                System.out.println("Firstname must not contain special characters");
                return false;
            }
        }
        return true;
    }

    public boolean checkLastname(User user) {
        if (user.getLastName().length() < 3 || user.getLastName().length() > 10) {
            System.out.println("Lastname must contain min 3 and max 10 characters");
            return false;
        }
        for (char c : user.getLastName().toCharArray()) {
            if (!Character.isLetter(c)) {
                System.out.println("Lastname must not contain special characters");
                return false;
            }
        }
        return true;
    }

    public boolean checkPassword(User user) {
        if (user.getPassword().length() < 8) {
            System.out.println("Password must contain at least 8 characters");
            return false;
        }
        boolean hasUppercase = !user.getPassword().equals(user.getPassword().toLowerCase());
        boolean hasLowercase = !user.getPassword().equals(user.getPassword().toUpperCase());
        boolean hasNumber = user.getPassword().matches(".*\\d.*");
        boolean hasSpecialChar = !user.getPassword().matches("[a-zA-Z0-9 ]*");
        return !(hasUppercase == false || hasLowercase == false || hasSpecialChar == false || hasNumber == false);
    }

    public boolean checkPasswords(String password, String confirmPassword) {
        if (password.equals(confirmPassword)) {
            return true;
        } else {
            return false;
        }
    }
}

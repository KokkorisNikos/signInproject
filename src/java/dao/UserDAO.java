/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.User;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;
import org.springframework.stereotype.Repository;

/**
 *
 * @author nikos
 */
@Repository
public class UserDAO {

    @PersistenceContext                   
    private EntityManager em;

    @Transactional                         
    public void insertUser(User st) {
        em.persist(st);
    }

    public List<User> searchUser(String email) {
        Query q = em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class);
        q.setParameter("email", email);
        List<User> users = q.getResultList();
        return users;
    }

    public List<User> checkUserMail(String email, String pass) {
        Query q = em.createQuery("SELECT s FROM User s WHERE s.email like :email", User.class);
        q.setParameter("email", email);
        List<User> user = q.getResultList();
        return user;
    }

    public List<User> checkUserLogin(String email) {
        Query q = em.createQuery("SELECT s FROM User s WHERE s.email like :email", User.class);
        q.setParameter("email", email);
        List<User> user = q.getResultList();
        return user;
    }

    @Transactional
    public void photoUpload(User user) {

        em.merge(user);
    }
}

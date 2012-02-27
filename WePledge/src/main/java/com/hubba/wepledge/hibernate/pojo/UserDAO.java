package com.hubba.wepledge.hibernate.pojo;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class UserDAO {
	private HibernateTemplate hibernateTemplate;

	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		hibernateTemplate = new HibernateTemplate(sessionFactory);
	}


	@SuppressWarnings("unchecked")
	public User getUserByEmail (String email) {
		List<User> users = hibernateTemplate.find("from User where email=?",email);
		if (users.size()!=1) return null;
		return users.get(0);
	}

	public User getUserById (long id) {
		return hibernateTemplate.get(User.class, id);
	}

	public void saveUser (User user) {
		hibernateTemplate.saveOrUpdate(user);
	}

	public void deleteUser (User user) {
		hibernateTemplate.delete(user);
	}

	@SuppressWarnings("unchecked")
	public List<User> listUsers() {
		return hibernateTemplate.find("from User");
	}
}
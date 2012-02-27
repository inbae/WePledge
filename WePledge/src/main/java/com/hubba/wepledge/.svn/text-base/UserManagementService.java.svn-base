package com.hubba.wepledge;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.hubba.wepledge.hibernate.pojo.*;
import com.hubba.wepledge.view.UserStruct;

@Service
public class UserManagementService {
	@Autowired
	protected UserDAO userDAO;

	/**
	 * Returns the current session
	 */
	/*package*/ static HttpSession getCurrentSession() {
		ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		return attr.getRequest().getSession();
	}

	public boolean loginUser (String email, String password) {
		User user = userDAO.getUserByEmail(email);
		if (user==null) return false; // not found

		boolean valid = user.getPassword().equals(password);
		if (!valid) return false;

		// login user in session
		getCurrentSession().setAttribute("loggedinUser", new UserStruct(user));
		return true;
	} // loginUser

	public void logoutCurrentUser() {
		getCurrentSession().removeAttribute("loggedinUser");
	}

	public UserStruct getCurrentUser() {
		return (UserStruct)getCurrentSession().getAttribute("loggedinUser");
	}
} // UserManagementService
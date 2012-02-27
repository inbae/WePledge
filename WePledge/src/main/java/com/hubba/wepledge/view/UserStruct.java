package com.hubba.wepledge.view;

import com.hubba.wepledge.hibernate.pojo.User;

public class UserStruct implements java.io.Serializable {
	private static final long serialVersionUID = 8423507609457971109L;

	protected long id;
	protected String email;

	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public UserStruct() {
	}

	public UserStruct (User user) {
		this.id = user.getId();
		this.email = user.getEmail();
	}
} // UserStruct
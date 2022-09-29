package com.site.meinsite.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Member implements Serializable{
	private static final long serialVersionUID = -8836551526983268642L;
	private String userid;
	private String userpwd;
	private String username;
	private String email;
	private String loginok;
	private String admin;
	private Date enroll_date;
	
	public Member() {}

	public Member(String userid, String userpwd, String username, String email, String loginok, String admin,
			Date enroll_date) {
		super();
		this.userid = userid;
		this.userpwd = userpwd;
		this.username = username;
		this.email = email;
		this.loginok = loginok;
		this.admin = admin;
		this.enroll_date = enroll_date;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUserpwd() {
		return userpwd;
	}

	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getLoginOK() {
		return loginok;
	}

	public void setLoginOK(String loginOK) {
		this.loginok = loginOK;
	}

	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}

	public Date getEnroll_date() {
		return enroll_date;
	}

	public void setEnroll_date(Date enroll_date) {
		this.enroll_date = enroll_date;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Member [userid=" + userid + ", userpwd=" + userpwd + ", username=" + username + ", email=" + email
				+ ", loginok=" + loginok + ", admin=" + admin + ", enroll_date=" + enroll_date + "]";
	}
	
	
}

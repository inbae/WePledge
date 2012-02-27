package com.hubba.wepledge.hibernate.pojo;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Table(name="pledge_history")
public class Pledge_history implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="id")
	@GeneratedValue
	private Long id;

	@Column(name="donor_fullname")
	private String donor_fullname;

	@Column(name="donor_email")
	private String donor_email;

	@Column(name="date_time")
	private Date date_time;
	
	@Column(name="latitude")
	private Double latitude;

	@Column(name="longitude")
	private Double longitude;

	@Column(name="amount")
	private Double amount;

	public Pledge_history() {
		super();
	}

	private Pledge_history(Long id, String donor_fullname, String donor_email, Date date_time,
			Double latitude, Double longitude) {
		super();
		this.id = id;
		this.donor_fullname = donor_fullname;
		this.donor_email = donor_email;
		this.date_time = date_time;
		this.latitude = latitude;
		this.longitude = longitude;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDonor_fullname() {
		return donor_fullname;
	}

	public void setDonor_fullname(String donor_fullname) {
		this.donor_fullname = donor_fullname;
	}

	public String getDonor_email() {
		return donor_email;
	}

	public void setDonor_email(String donor_email) {
		this.donor_email = donor_email;
	}

	public Date getDate_time() {
		return date_time;
	}

	public void setDate_time(Date date_time) {
		this.date_time = date_time;
	}

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	@Override
    public String toString(){
        return new ToStringBuilder(this).append("id",getId()).append("donor_email",getDonor_email()).toString();
    }
}

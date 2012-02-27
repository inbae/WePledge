package com.hubba.wepledge.hibernate.pojo;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Table(name="campaign")
public class Campaign implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="id")
	@GeneratedValue
	private Long id;

	@Column(name="name")
	private String name;

	@Column(name="donation_url")
	private String donation_url;

	@Column(name="description")
	private String description;

	@Column(name="active")
	private boolean active;

	@OneToMany(orphanRemoval=true, cascade = CascadeType.ALL)
	private Set<Pledge_history> pledgeHistories;	
	
	public Campaign() {
		super();
	}

	private Campaign(Long id, String name, String donation_url,
			String description, Set<Pledge_history> pledgeHistories) {
		super();
		this.id = id;
		this.name = name;
		this.donation_url = donation_url;
		this.description = description;
		this.pledgeHistories = pledgeHistories;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDonation_url() {
		return donation_url;
	}

	public void setDonation_url(String donation_url) {
		this.donation_url = donation_url;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public Set<Pledge_history> getPledgeHistories() {
		return pledgeHistories;
	}

	public void setPledgeHistories(Set<Pledge_history> pledgeHistories) {
		this.pledgeHistories = pledgeHistories;
	}

	@Override
    public String toString(){
        return new ToStringBuilder(this).append("id",getId()).append("name",getName()).toString();
    }
    
}

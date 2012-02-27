package com.hubba.wepledge.view;

import com.hubba.wepledge.hibernate.pojo.Campaign;

public class CampaignStruct implements java.io.Serializable {
	protected long id;
	protected String name;
	protected String url;
	protected String description;
	protected boolean active;

	public CampaignStruct() {
	}
	public CampaignStruct (Campaign campaign) {
		id = campaign.getId();
		name = campaign.getName();
		url = campaign.getDonation_url();
		description = campaign.getDescription();
		active = campaign.isActive();
	}

	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
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
} // CampaignStruct
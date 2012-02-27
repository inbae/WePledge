package com.hubba.wepledge.hibernate.pojo;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class CampaignDAO {
	private HibernateTemplate hibernateTemplate;

	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		hibernateTemplate = new HibernateTemplate(sessionFactory);
	}

	public Campaign getCampaignById (long id) {
		return hibernateTemplate.get(Campaign.class, id);
	}

	public void saveCampaign (Campaign campaign) {
		hibernateTemplate.saveOrUpdate(campaign);
	}

	public void deleteCampaign (Campaign campaign) {
		hibernateTemplate.delete(campaign);
	}

	@SuppressWarnings("unchecked")
	public List<Campaign> listCampaigns() {
		return hibernateTemplate.find("from Campaign");
	}

	@SuppressWarnings("unchecked")
	public List<Campaign> listActiveCampaigns() {
		return hibernateTemplate.find("from Campaign where active=true");
	}

	public long countPledgeHistoryItems() {
		return hibernateTemplate.execute(new HibernateCallback<Number>() {
			public Number doInHibernate(Session session)
					throws HibernateException, SQLException {
				return (Number)session.createQuery("select count(*) from Pledge_history").uniqueResult();
			}
		}).longValue();
	}

	public List<List<Double>> getPledgeHistoryLocations (final int maxresults) {
		return hibernateTemplate.execute(new HibernateCallback<List<List<Double>>>() {
			@SuppressWarnings("unchecked")
			public List<List<Double>> doInHibernate(Session session)
				throws HibernateException, SQLException {
				return (List<List<Double>>)session.createQuery("select latitude, longitude from Pledge_history where latitude is not null and longitude is not null order by date_time desc").setFetchSize(maxresults).list();
			}
		});
	}
}
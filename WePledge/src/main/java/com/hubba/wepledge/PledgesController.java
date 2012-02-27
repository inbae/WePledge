package com.hubba.wepledge;

import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Properties;

import javax.servlet.http.*;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.hubba.wepledge.hibernate.pojo.*;
import com.hubba.wepledge.view.PledgeForm;

@Controller
public class PledgesController {
	protected static Object updateLock = new Object();

	@Autowired
	protected CampaignDAO campaignDAO;

	@Autowired
	private MessageService messageService;
	
    EmailSender emailSender = new EmailSender();



	@RequestMapping(value="/pledge", method=RequestMethod.POST)
	public @ResponseBody String postPledge (
			@RequestParam (value="callback", required=false) String callback,
			@RequestBody PledgeForm pledgeForm,
			HttpServletRequest request,
			HttpServletResponse response) {

		Campaign campaign = campaignDAO.getCampaignById(pledgeForm.getCampaign_id());
		Pledge_history pledge = new Pledge_history();
		pledge.setDate_time(new Date (pledgeForm.getTime()));
		pledge.setAmount(pledgeForm.getAmount());
		pledge.setDonor_email(pledgeForm.getEmail());
		pledge.setDonor_fullname(pledgeForm.getFullname());
		pledge.setLatitude(pledgeForm.getLat());
		pledge.setLongitude(pledgeForm.getLng());
		campaign.getPledgeHistories().add(pledge);
		campaignDAO.saveCampaign(campaign);
		System.out.println("Accepted: " + pledge);

		incrementPledgeCount();


		String emailTemplate_par1 = messageService.getMessageSource().getMessage("email1_part1", new Object[] { pledgeForm.getFullname(), pledgeForm.getAmount(), campaign.getName() }, Locale.US);
		String emailTemplate_par2 = messageService.getMessageSource().getMessage("email1_part2", null, Locale.US);
		StringBuilder emailTemplate = new StringBuilder(emailTemplate_par1).append("<p>").append(campaign.getDescription()).append("</p>").append(emailTemplate_par2);
		
		
    	Properties p = new Properties();
        p.put("mail.smtp.host", "smtp.gmail.com");
        p.put("mail.smtp.auth", "true");
        p.put("mail.smtp.starttls.enable", "true");
        p.put("mail.smtp.socketFactory.port", "465");
        p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        p.put("mail.smtp.socketFactory.fallback", "false");
		emailSender.sendEmailFromGmail("test@hubba.com", pledgeForm.getEmail(), "Thanks for giving your pledge!", emailTemplate.toString(), p, "test@hubba.com", "hubba@215");
		

		if (callback!=null) return callback+"();";
		else return "";
	}

	protected static Long getPledgeCount() {
		// check application context for the count
		Long pledgeCount = (Long)UserManagementService.getCurrentSession().getServletContext().getAttribute("pledgeCount");
		return pledgeCount;
	}

	protected static long cachePledgeCount (CampaignDAO campaignDAO) {
		// calculate it
		Long pledgeCount;
		synchronized (updateLock) {
			pledgeCount = campaignDAO.countPledgeHistoryItems();
			UserManagementService.getCurrentSession().getServletContext().setAttribute("pledgeCount", pledgeCount);
		}

		return pledgeCount;
	}

	protected static void incrementPledgeCount() {
		synchronized (updateLock) {
			Long pledgeCount = (Long)UserManagementService.getCurrentSession().getServletContext().getAttribute("pledgeCount");
			if (pledgeCount==null)
				pledgeCount = 1l;
			else
				pledgeCount++;
			UserManagementService.getCurrentSession().getServletContext().setAttribute("pledgeCount", pledgeCount);
		}
	}

	@RequestMapping("/getPledgeCount")
	public @ResponseBody String getPledgeCount(
			@RequestParam (value="callback", required=false) String callback,
			HttpServletRequest request,
			HttpServletResponse response) {


		Long pledgeCount = getPledgeCount();
		if (pledgeCount==null) pledgeCount = cachePledgeCount(campaignDAO);

		if (callback!=null)
			return callback+"("+pledgeCount.toString()+")";
		else
			return pledgeCount.toString();
	}

	@RequestMapping("/getPledgeLocations")
	public @ResponseBody String getPledgeLocations(
			@RequestParam String campaign,
			@RequestParam String latlng,
			@RequestParam(value="callback",required=false) String callback,
			HttpServletResponse response) {

		String[] latlng2 = latlng.split(",");
		double lat = Double.parseDouble(latlng2[0].substring(1));
		double lng = Double.parseDouble(latlng2[1].substring(0,latlng2[1].length()-1));

		List<List<Double>> ret = campaignDAO.getPledgeHistoryLocations(50);

		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		try {
			json = mapper.writeValueAsString(ret);
		} catch (Exception e) {
			e.printStackTrace();
		}

		response.setContentType("application/javascript");

		if (callback!=null)
			return callback+"("+json+");";
		else
			return json;
	}
} // PledgesController
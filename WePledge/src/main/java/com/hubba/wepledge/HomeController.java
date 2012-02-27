package com.hubba.wepledge;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hubba.wepledge.hibernate.pojo.CampaignDAO;

@Controller
public class HomeController {
	@Autowired
	protected CampaignDAO campaignDAO;

	@RequestMapping ("/")
	public ModelAndView home() {
		ModelAndView mv = new ModelAndView("/WEB-INF/views/wepledge.jsp");

		
		mv.addObject("charities", campaignDAO.listActiveCampaigns());

		return mv;
	}
} // HomeController
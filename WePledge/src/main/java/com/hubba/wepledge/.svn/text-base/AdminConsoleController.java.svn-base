package com.hubba.wepledge;

import java.util.*;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;
import com.hubba.wepledge.hibernate.pojo.*;
import com.hubba.wepledge.view.*;

@Controller
public class AdminConsoleController {
	@Autowired
	protected UserManagementService userMgmt;

	@Autowired
	protected UserDAO userDAO;

	@Autowired
	protected CampaignDAO campaignDAO;


	@RequestMapping("/admin/")
	public ModelAndView adminRoot(HttpServletRequest request) {
		// if we're already logged in, go to users
		if (userMgmt.getCurrentUser()!=null)
			return new ModelAndView("forward:/admin/users");

		Boolean errors = (Boolean)request.getSession().getAttribute("loginErrors");
		if (errors!=null) request.getSession().removeAttribute("loginErrors");
		ModelAndView mv = new ModelAndView("/WEB-INF/views/admin/login.jsp");
		mv.addObject("errors", errors);
		return mv;
	}

	@RequestMapping(value="/admin/login", method=RequestMethod.POST)
	public String adminLogin(HttpServletRequest request, @RequestParam String username, @RequestParam String password) {
		boolean success = userMgmt.loginUser(username, password);

		if (!success) request.getSession().setAttribute("loginErrors", Boolean.TRUE);
		return "redirect:/admin/";
	}

	@RequestMapping(value="/admin/logout", method=RequestMethod.GET)
	public String adminLogout(HttpServletRequest request) {
		userMgmt.logoutCurrentUser();
		return "redirect:/admin/";
	}

	@RequestMapping("/admin/users")
	public ModelAndView adminUsers() {
		ModelAndView mv = new ModelAndView("/WEB-INF/views/admin/adminUsers.jsp");

		mv.addObject("currentUser", userMgmt.getCurrentUser());

		List<User> users = userDAO.listUsers();

		List<UserStruct> ret = new ArrayList<UserStruct>(users.size());
		for (User user : users) {
			ret.add(new UserStruct(user));
		}

		mv.addObject("addUserErrors", UserManagementService.getCurrentSession().getAttribute("addUserErrors"));
		System.out.println("GOT: "+UserManagementService.getCurrentSession().getAttribute("addUserErrors"));
		UserManagementService.getCurrentSession().removeAttribute("addUserErrors");
		mv.addObject("users", ret);
		return mv;
	}

	@RequestMapping(value="/admin/addUser", method=RequestMethod.POST)
	public String addUser (
			@RequestParam(value="email", required=false) String email,
			@RequestParam(value="password", required=false) String password,
			@RequestParam(value="confirmpassword", required=false) String confirmpassword) {

		EnumSet<AddUserErrors> errors = EnumSet.noneOf(AddUserErrors.class);

		// validation
		if (email==null || email.isEmpty())
			errors.add(AddUserErrors.BLANK_EMAIL);

		if (password==null || password.isEmpty())
			errors.add(AddUserErrors.BLANK_PASSWORD);

		if (errors.isEmpty() && (confirmpassword==null || !confirmpassword.equals(password)))
			errors.add(AddUserErrors.NONMATCHING_PASSWORDS);

		if (userDAO.getUserByEmail(email)!=null) {
			errors.add(AddUserErrors.EMAIL_IN_USE);
		}

		if (!errors.isEmpty()) {
			UserManagementService.getCurrentSession().setAttribute("addUserErrors", errors);
		} else {
			UserManagementService.getCurrentSession().removeAttribute("addUserErrors");
			User user = new User();
			user.setEmail(email);
			user.setPassword(password);
			userDAO.saveUser(user);
		}

		return "redirect:/admin/users";
	}

	@RequestMapping(value="/admin/deleteUser", method=RequestMethod.POST)
	public String deleteUser(@RequestParam("userId")int userId) {
		User user = userDAO.getUserById(userId);
		if (user==null) {
			System.out.println("deleteUser: no user with that ID");
		} else {
			userDAO.deleteUser(user);
		}
		return "redirect:/admin/users";
	}



	@RequestMapping("/admin/campaigns")
	public ModelAndView adminCampaigns() {
		ModelAndView mv = new ModelAndView("/WEB-INF/views/admin/adminCampaigns.jsp");

		mv.addObject("currentUser", userMgmt.getCurrentUser());

		List<Campaign> campaigns = campaignDAO.listCampaigns();

		List<CampaignStruct> ret = new ArrayList<CampaignStruct>(campaigns.size());
		for (Campaign campaign : campaigns) {
			ret.add(new CampaignStruct(campaign));
		}

		mv.addObject("addCampaignErrors", UserManagementService.getCurrentSession().getAttribute("addCampaignErrors"));
		UserManagementService.getCurrentSession().removeAttribute("addCampaignErrors");
		mv.addObject("campaigns", ret);
		return mv;
	}

	@RequestMapping(value="/admin/addCampaign", method=RequestMethod.POST)
	public String addCampaign(
			@RequestParam(value="name", required=false) String name,
			@RequestParam(value="description", required=false) String description,
			@RequestParam(value="url", required=false) String url) {

		EnumSet<AddCampaignErrors> errors = EnumSet.noneOf(AddCampaignErrors.class);

		if (name==null || name.isEmpty())
			errors.add(AddCampaignErrors.BLANK_NAME);

		if (description==null || description.isEmpty())
			errors.add(AddCampaignErrors.BLANK_DESCRIPTION);

		if (url==null || url.isEmpty())
			errors.add(AddCampaignErrors.BLANK_URL);
		else if (!url.startsWith("http://"))
			errors.add(AddCampaignErrors.INVALID_URL);

		if (!errors.isEmpty()) {
			UserManagementService.getCurrentSession().setAttribute("addCampaignErrors", errors);
		} else {
			UserManagementService.getCurrentSession().removeAttribute("addCampaignErrors");
			Campaign campaign = new Campaign();
			campaign.setName(name);
			campaign.setDescription(description);
			campaign.setDonation_url(url);
			campaign.setActive(false);
			campaignDAO.saveCampaign(campaign);
		}

		return "redirect:/admin/campaigns";
	}

	@RequestMapping(value="/admin/deleteCampaign", method=RequestMethod.POST)
	public String deleteCampaign (@RequestParam("id")long id) {

		Campaign campaign = campaignDAO.getCampaignById(id);

		if (campaign!=null) campaignDAO.deleteCampaign(campaign);

		return "redirect:/admin/campaigns";
	}

	@RequestMapping(value="/admin/activateCampaign", method=RequestMethod.POST)
	public String activateCampaign (@RequestParam("id")long id) {

		Campaign campaign = campaignDAO.getCampaignById(id);

		if (campaign!=null) {
			campaign.setActive(true);
			campaignDAO.saveCampaign(campaign);
		}

		return "redirect:/admin/campaigns";
	}

	@RequestMapping(value="/admin/deactivateCampaign", method=RequestMethod.POST)
	public String deactivateCampaign (@RequestParam("id")long id) {

		Campaign campaign = campaignDAO.getCampaignById(id);

		if (campaign!=null) {
			campaign.setActive(false);
			campaignDAO.saveCampaign(campaign);
		}

		return "redirect:/admin/campaigns";
	}

} // AdminConsoleController
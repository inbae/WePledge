package com.hubba.wepledge;

import java.io.IOException;
import java.util.*;
import javax.servlet.http.*;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.hubba.wepledge.hibernate.pojo.Campaign;
import com.hubba.wepledge.hibernate.pojo.CampaignDAO;

@Controller
public class DashboardController {

	@Autowired
	protected CampaignDAO campaignDAO;

	// charity_name -> list of pledges
	public static HashMap<String,List<Pledge>> receivedObjects = new HashMap<String,List<Pledge>>();

	public static class Pledge {
		public String campaign;
		public double lat;
		public double lng;
		public double amount;
		public long time;

		@Override
		public String toString() {
			return "campaign="+campaign+" latlng="+lat+","+lng+" amount="+amount+" time="+time;
		}
	}

	@RequestMapping (value="/dashboard/api/pledge/push", method=RequestMethod.GET)
	public @ResponseBody String pledge_push (
			@RequestParam String campaign,
			@RequestParam String latlng,
			@RequestParam double amount,
			@RequestParam long time,
			@RequestParam String callback,
			HttpServletRequest request, HttpServletResponse response) {
		Pledge data = new Pledge();
		data.campaign = campaign;
		String[] latlng2 = latlng.split(",");
		data.lat = Double.parseDouble(latlng2[0].substring(1));
		data.lng = Double.parseDouble(latlng2[1].substring(0,latlng2[1].length()-1));
		data.amount = amount;
		data.time = time;

		List<Pledge> received = receivedObjects.get(campaign);

		if (received==null) {
			received = new LinkedList<Pledge>();
			receivedObjects.put(campaign, received);
		}

		received.add(data);

		response.addHeader("Access-Control-Allow-Origin", "*");
		response.addHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
		response.addHeader("Access-Control-Allow-Headers", "X-Requested-With");

		return callback+"();";
	}

	@RequestMapping (value="/dashboard/api/pledge/get", method=RequestMethod.OPTIONS)
	public void pledge_getTotal(HttpServletResponse response) {
		response.addHeader("Access-Control-Allow-Origin", "*");
		response.addHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
		response.addHeader("Access-Control-Allow-Headers", "X-Requested-With");
	}
			
	@RequestMapping (value="/dashboard/api/pledge/get", method=RequestMethod.GET)
	public @ResponseBody String pledge_getTotal(
			@RequestParam(required=false) String campaign,
			@RequestParam String callback,
			HttpServletResponse response) {

		int total = 0;
		for (List<Pledge> received : receivedObjects.values()) {
			total+=received.size();
		}

		return callback+"("+Integer.toString(total)+");";
		//return Double.toString(total);
	}

	@RequestMapping (value="/dashboard/api/pledge/locations", method=RequestMethod.GET)
	public @ResponseBody String pledge_getLocations(
			@RequestParam String campaign,
			@RequestParam String latlng,
			@RequestParam String callback,
			HttpServletResponse response) {

		String[] latlng2 = latlng.split(",");
		double lat = Double.parseDouble(latlng2[0].substring(1));
		double lng = Double.parseDouble(latlng2[1].substring(0,latlng2[1].length()-1));
		
		List<Pledge> received = receivedObjects.get(campaign);

		List<List<String>> ret = new LinkedList<List<String>>();

		//if (received==null) return ret;

		if (received!=null) {
			for (Pledge pledge : received) {
				LinkedList<String> pledgeRet = new LinkedList<String>();
				pledgeRet.add(Double.toString(pledge.lat));
				pledgeRet.add(Double.toString(pledge.lng));
				ret.add(pledgeRet);
				if (ret.size()>50) break;
			}
		}

		ObjectMapper mapper = new ObjectMapper();
		String json = null;
		try {
			json = mapper.writeValueAsString(ret);
		} catch (Exception e) {
			e.printStackTrace();
		}

		response.setContentType("application/javascript");
		return callback+"("+json+");";
/*
		response.addHeader("Access-Control-Allow-Origin", "*");
		response.addHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
		response.addHeader("Access-Control-Allow-Headers", "X-Requested-With");
*/
//		return ret;
	}

	@RequestMapping(value="/dashboard/api/pledge/charities", method={RequestMethod.GET, RequestMethod.OPTIONS})
	public @ResponseBody List<Campaign> getCharities(HttpServletResponse response) {

		response.addHeader("Access-Control-Allow-Origin", "*");
		response.addHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
		response.addHeader("Access-Control-Allow-Headers", "X-Requested-With");

		return campaignDAO.listCampaigns();
		//return charities;
	}
}
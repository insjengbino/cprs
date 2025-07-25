<%@ page language="java" import="org.json.*" %>
<%@include file="/WEB-INF/jsp/classes/BrokerClassJSP.jsp" %>
<%!
//======================================================================
// Author: Toqaful
// 09/19/2022
//======================================================================

public class BrokerControllerJSP 
{
	public String viewOneProfile(String id) throws Exception
	{
		BrokerClassJSP broker_class = new BrokerClassJSP();
		String data = broker_class.readOneProfile(id);
		
		return data;
	}
	
	public String viewMajorStockHolderByProfileId(String profile_id) throws Exception
	{
		BrokerClassJSP broker_class = new BrokerClassJSP();
		String data = broker_class.readMajorStockHolderByProfileId(profile_id);
		
		return data;
	}
	
	public String viewMajorClientByProfileId(String profile_id) throws Exception
	{
		BrokerClassJSP broker_class = new BrokerClassJSP();
		String data = broker_class.readMajorClientByProfileId(profile_id);
		
		return data;
	}
}
%>
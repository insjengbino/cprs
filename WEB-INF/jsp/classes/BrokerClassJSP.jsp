<%@ page language="java" import="org.json.*" %>
<%@include file="/WEB-INF/jsp/config/DatabaseJSP.jsp" %>
<%@include file="/WEB-INF/jsp/models/MDB_PROFILE_JSP.jsp" %>
<%@include file="/WEB-INF/jsp/models/MDB_MAJOR_STOCK_HOLDER_JSP.jsp" %>
<%@include file="/WEB-INF/jsp/models/MDB_MAJOR_CLIENT_JSP.jsp" %>
<%!
//======================================================================
// Author: Toqaful
// 09/19/2022
//======================================================================

public class BrokerClassJSP 
{	
	public MDB_PROFILE_JSP mdb_profile;
	public MDB_MAJOR_STOCK_HOLDER_JSP mdb_major_stock_holder;
	public MDB_MAJOR_CLIENT_JSP mdb_major_client;
	
	public BrokerClassJSP()
	{
		
	}
	
	public String readOneProfile(String id) throws Exception
	{
		this.mdb_profile   = new MDB_PROFILE_JSP();
		JSONArray profile_ = this.mdb_profile.findOneById(id);
		String    data     = profile_.get(0).toString();
		
		return data;
	}
	
	public String readMajorStockHolderByProfileId(String profile_id) throws Exception
	{
		this.mdb_major_stock_holder   = new MDB_MAJOR_STOCK_HOLDER_JSP();
		JSONArray major_stock_holder_ = this.mdb_major_stock_holder.findByProfileId(profile_id);
		String    data                = major_stock_holder_.toString();
		
		return data;
	}
	
	public String readMajorClientByProfileId(String profile_id) throws Exception
	{
		this.mdb_major_client   = new MDB_MAJOR_CLIENT_JSP();
		JSONArray major_client_ = this.mdb_major_client.findByProfileId(profile_id);
		String    data          = major_client_.toString();
		
		return data;
	}
}
%>
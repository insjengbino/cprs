<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="org.json.*" %>
<%!
//======================================================================
// Author: Toqaful
// 09/19/2022
//======================================================================

public class MDB_PROFILE_JSP
{
	public DatabaseJSP db; 
	
	public MDB_PROFILE_JSP() throws SQLException
	{
		this.db = new DatabaseJSP();
	}
	
	public JSONArray findOneById(String id) throws Exception
	{
		String sql = "SELECT * FROM profile where id = '"+ id +"'";
		
		Statement statement = this.db.createStatement();
		ResultSet result    = statement.executeQuery(sql);
		JSONArray data      = db.resultV2(result);
		
		return data;
	}
	
	public void begin() throws SQLException
	{
		this.db.transactionBegin();
	}
	
	public void commit() throws SQLException
	{
		this.db.transactionCommit();
	}
	
	public void rollback() throws SQLException
	{
		this.db.transactionRollback();
	}
}
%>
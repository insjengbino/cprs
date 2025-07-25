<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="org.json.*" %>
<%@ page language="java" import="net.iharder.*" %>
<%!
//======================================================================
// Author: Toqaful
// 09/19/2022
//======================================================================

public class DatabaseJSP 
{	
	public String hostname;
	public String user;
	public String password;
	public String database;
	public String url;
	
	public Connection conn;
	public Statement statement;
	
	public DatabaseJSP() throws SQLException
	{
		// demo
		this.hostname = "localhost";
		
		// production
		// this.hostname = "localhost";
		
		this.user     = "postgres";
		this.password = "anat0my";
		this.database = "profiles";
		this.url      = "jdbc:postgresql://"+ this.hostname +"/"+ this.database;
		
		// initialize database connection
		this.dbConnect();
	}
	
	// database connection
	public Connection dbConnect() throws SQLException
	{
		return this.conn = DriverManager.getConnection(this.url, this.user, this.password);
	}
	
	// create statement
	public Statement createStatement() throws SQLException
	{
		return this.statement = this.conn.createStatement();	
	}
	
	// transaction begin
	public void transactionBegin() throws SQLException
	{
		this.conn.setAutoCommit(false);
	}
	
	// transaction commit
	public void transactionCommit() throws SQLException
	{
		this.conn.commit();
	}
	
	// transaction roll back
	public void transactionRollback() throws SQLException
	{
		this.conn.rollback();
	}
	
	// result
	public JSONArray result(ResultSet result) throws Exception 
	{
	    JSONArray json_array = new JSONArray();
	 
	    while(result.next()) 
	    {
	    	int        columns = result.getMetaData().getColumnCount();
	        JSONObject obj     = new JSONObject();
	 
	        for (int i = 0; i < columns; i++)
	        {
				obj.put(result.getMetaData().getColumnLabel(i + 1), result.getObject(i + 1));
	        }
	        
	        json_array.put(obj);
	    }
		
	    return json_array;
	}
	
	// one result with bytea
	public JSONArray resultV2(ResultSet result) throws Exception 
	{
	    JSONArray json_array = new JSONArray();
	 
	    while(result.next()) 
	    {
	    	int        columns = result.getMetaData().getColumnCount();
	        JSONObject obj     = new JSONObject();
	 
	        for (int i = 0; i < columns; i++)
	        {	
				if (result.getMetaData().getColumnLabel(i + 1).equals("picture"))
				{
					obj.put(result.getMetaData().getColumnLabel(i + 1), "data:image/jpeg;base64," + Base64.encodeBytes(result.getBytes(i + 1)));
				}
				else if (result.getMetaData().getColumnLabel(i + 1).equals("signature"))
				{
					obj.put(result.getMetaData().getColumnLabel(i + 1), "data:image/jpeg;base64," + Base64.encodeBytes(result.getBytes(i + 1)));
				}
				else
				{
					obj.put(result.getMetaData().getColumnLabel(i + 1), result.getObject(i + 1));
				}
	        }
	        
	        json_array.put(obj);
	    }
	    
	    return json_array;
	}
	
	public String escape(String str)
	{
		return str.replaceAll("'", "''");
	}
}
%>


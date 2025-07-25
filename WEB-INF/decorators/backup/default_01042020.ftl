<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<#macro tab name label action>
	<li id="${name}"
	<#if (page.properties['meta.tab'])?if_exists = name>
		class="activelink"		
	</#if>
	><a href="${base}/${action}">${label}</a></li>
</#macro>  
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">				
		${head}		
    	<style>			
			a#logout{text-decoration:none;color: #FFC;font-weight:bold;}
			a#myprofile{text-decoration:none;color: #FFC;font-weight:bold;}
		</style>		
		<link rel="stylesheet" type="text/css" href="${base}/styles/default.css"/>		
    </head>
    <body>    
        <div id="container">
            <div id="content">
            <h2>${title}</h2>	
                ${body}               
            </div>									          
            <div id="header">
            	<div id="logo">
            	</div>     
				
				<div id="menu">
					<ul id="tabnav">
				    	<@tab name="profiles" label="Profiles" action="listProfiles.action"/>	
					</ul>       
				</div>
            </div>			
           
            <div id="footer">   
                <p>             
					<a href="http://www.intercommerce.com.ph">InterCommerce Network Services</a> &copy; 2008&nbsp;
				</p>	
            </div>
            
			<div id="login">	
				<@s.url id="homeURL" action="homepage">
					<@s.param name="id"  value="id"/>
				</@s.url>	
				<a href="http://www.intercommerce.com.ph" onClick="return confirm('Are you sure you want to Logout?')">[Logout]</a>						
				<@s.a href="${homeURL}">[Home] , </@s.a>  		
				<p>Client Profile Registration System</p>
			</div>
			
        </div>
    </body>
</html>
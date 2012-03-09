package de.tu.ilmenau.parser;

public class Event {
	private String operation;
	private String user;
	private String query;
	private String queryMeta;
	private String databaseServer;
	private float queryTime;
	private float lockTime;
	private int rowsSent;
	private int rowsExamined;
	private long timeStamp;
	private long timeDiff;


	public String getOperation() {
		return operation;
	}
	
	public void setOperation(String operation) {
		this.operation = operation;
	}
	
	public String getUser() {
		return user;
	}
	
	public void setUser(String user) {
		this.user = user;
	}
	
	public String getQuery() {
		return query;
	}
	
	public void setQuery(String query) {
		this.query = query;
	}
	
	public String getQueryMeta() {
		return queryMeta;
	}
	
	public void setQueryMeta(String queryMeta) {
		this.queryMeta = queryMeta;
	}
	
	public String getDatabaseServer() {
		return databaseServer;
	}
	
	public void setDatabaseServer(String databaseServer) {
		this.databaseServer = databaseServer;
	}
	
	public float getQueryTime() {
		return queryTime;
	}
	
	public void setQueryTime(float queryTime) {
		this.queryTime = queryTime;
	}
	
	public float getLockTime() {
		return lockTime;
	}
	
	public void setLockTime(float lockTime) {
		this.lockTime = lockTime;
	}
	
	public int getRowsSent() {
		return rowsSent;
	}
	
	
	public void setRowsSent(int rowsSent) {
		this.rowsSent = rowsSent;
	}
	
	public int getRowsExamined() {
		return rowsExamined;
	}
	
	public void setRowsExamined(int rowsExamined) {
		this.rowsExamined = rowsExamined;
	}
	
	public long getTimeStamp() {
		return timeStamp;
	}
	
	public void setTimeStamp(long timeStamp) {
		this.timeStamp = timeStamp;
	}
	
	public long getTimeDiff() {
		return timeDiff;
	}
	
	public void setTimeDiff(long timeDiff) {
		this.timeDiff = timeDiff;
	}
	
	public  String toString() {
		return ""+user+"|"+databaseServer+",|"+timeStamp+"|"+operation+"|"+queryTime+"|"+lockTime+"|"+rowsSent+"|"+rowsExamined+"|"+query+"|"+timeDiff+"|"+queryMeta+";";
	}
	
}

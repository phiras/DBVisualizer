package de.tu.ilmenau.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;

public class DBConnectionManager {
	 private String userName = Config.getDBUsername();
	 private String password = Config.getDBPassword();
	 private String url      = Config.getDBUrl();
	 
     private Connection conn = null;
     
     public DBConnectionManager(){
         try {
			 Class.forName ("com.mysql.jdbc.Driver").newInstance();
			 setConnection(DriverManager.getConnection (url, userName, password)); 
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
     }

	public void setConnection(Connection _conn) {
		this.conn = _conn;
	}

	public Connection getConnection() {
		return conn;
	}
	
	public void insertCustomer(int _gsmNo) {
		try {
			Statement s = conn.createStatement();
			s.executeUpdate  (
		               "INSERT INTO customer (gsm_no)"
		               + " VALUES" +"("+_gsmNo+")");
			s.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insertSMS(int _customerId, int _hour, int _minute) {
		try {
			Statement s = conn.createStatement();
			s.executeUpdate  (
		               "INSERT INTO sms (customer_id, hour, minute)"
		               + " VALUES" +"("+_customerId+","+_hour+","+_minute+")");
			s.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insertGPRS(int _customerId, int _hour, int _minute, int _size) {
		try {
			Statement s = conn.createStatement();
			s.executeUpdate  (
		               "INSERT INTO gprs (customer_id, hour, minute, size)"
		               + " VALUES" +"("+_customerId+","+_hour+","+_minute+","+_size+")");
			s.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insertCall(int _customerId, int _hour, int _minute, int _duration) {
		try {
			Statement s = conn.createStatement();
			s.executeUpdate  (
		               "INSERT INTO calls (customer_id, hour, minute, duration)"
		               + " VALUES" +"("+_customerId+","+_hour+","+_minute+","+_duration+")");
			s.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public LinkedList<Integer> getCurrentCustomer() {
		LinkedList<Integer> currentCustomer = new LinkedList<Integer>();
		try {
			   Statement s = conn.createStatement ();
			   s.executeQuery ("SELECT id FROM customer");
			   ResultSet rs = s.getResultSet ();
			   while (rs.next ())
			   {
			       int customerId = rs.getInt("id");
			       currentCustomer.add(new Integer(customerId));
			   }
			   rs.close ();
			   s.close ();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return currentCustomer;
	}
	
	public void updateCustomer(int _customerid, int _newGsmNo){
		try {
			Statement s = conn.createStatement();
		    s.executeUpdate("update customer set gsm_no ="+ _newGsmNo +" where id ='"+ _customerid+"'");
			s.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteCustomerHistory(int _customerid){
		try {
			Statement s = conn.createStatement();
		    //s.executeUpdate("delete from customer where id ="+ _customerid);
		    s.executeUpdate("delete from sms where customer_id ="+ _customerid);
		    s.executeUpdate("delete from gprs where customer_id ="+ _customerid);
		    s.executeUpdate("delete from calls where customer_id ="+ _customerid);
			s.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public void selectCustomerData(int _customerId, String _tableName){
		try {
			   Statement s = conn.createStatement ();
			   s.executeQuery ("SELECT * FROM "+ _tableName);
			   s.close ();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}

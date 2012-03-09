package de.tu.ilmenau.utility;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;


/**
 * The Class Config provides direct access to the basic application's configuration params.
 */

public class Config {
	/** The props. */
	private static Properties props = new Properties();
	
	static{
		FileInputStream fis;
		try {
			fis = new FileInputStream("config.properties");
			props.load(fis);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static String get(String _key){
		return props.getProperty(_key);
	}
	
	// MySQL database Configuration
	
	public static String getDBUsername(){
		return props.getProperty("db_usrname");
	}
	
	public static String getDBPassword(){
		return props.getProperty("db_password");
	}
	
	public static String getDBUrl(){
		return props.getProperty("db_url");
	}
	
	// Random Query Generator Parser 	
	
	public static int getOperationCounts(){
		return Integer.parseInt(props.getProperty("operations_count"));
	}
	
	public static int getSleepTimeBetweenOperations(){
		return Integer.parseInt(props.getProperty("sleep_between_operation"));
	}
	
	// Parser Configuration
	
	public static String getInputLogFile(){
		return props.getProperty("input_log_file");
	}
	
	public static String getOutputCSVFile(){
		return props.getProperty("output_csv_file");
	}
}

package de.tu.ilmenau.parser;

import java.io.IOException;
import java.util.LinkedList;
import java.util.Scanner;
import java.util.StringTokenizer;

public class MySQLLogParser extends LogParser{
	
  private static long prevTimeStamp = 0;
	
  public MySQLLogParser(String inputFile, String outputFile) {
		super(inputFile, outputFile);
	}
  
  private boolean isNeededLogPart(LinkedList<String> logPart) {
	  // based on manual observation in log file, the selection of the needed parts of the log should have five lines
	  // and the last raw should begin with one operation i.e. insert, select, update, delete
	  if (logPart == null)
		  return false;
	  
	  //if (logPart.size() !=4)
		//  return false;
	  
	  if (! (logPart.get(3).toLowerCase().startsWith(Operations.SELECT) && logPart.get(3).toLowerCase().contains("from") ) &&
			  !logPart.get(3).toLowerCase().startsWith(Operations.INSERT) &&
			  !logPart.get(3).toLowerCase().startsWith(Operations.DELETE) &&
			  !logPart.get(3).toLowerCase().startsWith(Operations.UPDATE))
		  return false;
	  
	  return true;
  }
  
  private void processOperation(LinkedList<String> logPart){
	  if (isNeededLogPart(logPart)) {
		  System.out.println("===========================");
		 for (int i=0; i<logPart.size(); i++){
			 System.out.println(logPart.get(i));
		 }
		 
		 Event event = new Event();
		 StringTokenizer st = null;
		 
		 // Extract the user and database server
		 String line1 = logPart.get(0);
		 st = new StringTokenizer(line1);
		 st.nextElement();
		 st.nextElement();
		 event.setUser(st.nextElement().toString());
		 st.nextElement();
		 st.nextElement();
		 event.setDatabaseServer(st.nextElement().toString());
		 
		 // Extract queryTime, lockTime, rowsSent, and rowsExamined
		 String line2 = logPart.get(1);
		 st = new StringTokenizer(line2);
		 st.nextElement();
		 st.nextElement();
		 event.setQueryTime(Float.parseFloat(st.nextElement().toString()));
		 st.nextElement();
		 event.setLockTime(Float.parseFloat(st.nextElement().toString()));
		 st.nextElement();
		 event.setRowsSent(Integer.parseInt(st.nextElement().toString()));
		 st.nextElement();
		 event.setRowsExamined(Integer.parseInt(st.nextElement().toString()));
		 
		 // Extract timestamp
		 String line3 = logPart.get(2);
		 st = new StringTokenizer(line3,"=");
		 st.nextElement();
		 String temp = st.nextElement().toString();
		 long timeStamp = Long.parseLong(temp.substring(0,temp.length()-1)); 
		 event.setTimeStamp(timeStamp);
		 event.setTimeDiff(timeStamp - prevTimeStamp);
		 System.out.println(prevTimeStamp);
		 prevTimeStamp  = timeStamp;
		 
		 // Extract database query
		 String line4 = logPart.get(3);
		 event.setQuery(line4.substring(0, line4.length()-1));
		 st = new StringTokenizer(line4);
		 event.setOperation(st.nextElement().toString());
		 
		 // Extract some other information from the database query itself. 
		 // 1- Table name
		 // 2- TODO ...
		 event.setQueryMeta(getQueryProperties(event, line4));
		 
		 
		 // Store the Event
		 try {
			outputFile.append(event.toString());
			outputFile.append('\n');
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 System.out.println(event.toString());
	  }
  }

  private String getQueryProperties(Event event, String query) {
	  String operation   = event.getOperation();
	  StringTokenizer st = null; 
	  if (operation.toLowerCase().equals(Operations.DELETE)) {
		  st = new StringTokenizer(query);
		  st.nextElement();
		  st.nextElement();
		  return st.nextElement().toString();
	  } else if (operation.toLowerCase().equals(Operations.INSERT)) {
		  st = new StringTokenizer(query);
		  st.nextElement();
		  st.nextElement();
		  return st.nextElement().toString();
	  } else if (operation.toLowerCase().equals(Operations.UPDATE)) {
		  st = new StringTokenizer(query);
		  st.nextElement();
		  return st.nextElement().toString();
	  } else if (operation.toLowerCase().equals(Operations.SELECT)) {
		  int indexOfFrom = query.toLowerCase().indexOf("from");
		  st = new StringTokenizer(query.substring(indexOfFrom, query.length()-1));
		  st.nextElement();
		  return st.nextElement().toString();
	  }
	  return null;
  }
  
  protected void processLogFile(Scanner scanner){
	  // Skip the file header
	  String headerLine = null;
	  while (scanner.hasNext()) {
		  headerLine = scanner.nextLine();
		  if (headerLine.startsWith("# User@Host:")) 
			  break;
	  }
	  
	  // Process actual log file data
	  LinkedList<String> logPart = null;
	  String line = headerLine;

	  while (scanner.hasNext()) {
		  if (line.startsWith("# User@Host:")) {
			  processOperation(logPart);
			  logPart = new LinkedList<String>();
			  logPart.add(line); 
		  }
		  else 
			  logPart.add(line);
		  
		  line = scanner.nextLine();
	  }
	  
	  logPart.add(line);  
	  processOperation(logPart);
	  
	  try {
		outputFile.flush();
		  outputFile.close();
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		}
	}
} 

package de.tu.ilmenau.queryGenerator;

import java.util.LinkedList;

import de.tu.ilmenau.utility.Config;
import de.tu.ilmenau.utility.DBConnectionManager;

public class RandomQueryGenerator {
	private DBConnectionManager dbConnectionManager;
	private CurrentCustomer currentCustomerThread;
	private int operationsCount = Config.getOperationCounts();
	private int SleepBetweenOperation = Config.getSleepTimeBetweenOperations(); //ms
	
	public RandomQueryGenerator(){
		dbConnectionManager   = new DBConnectionManager();
		currentCustomerThread = new CurrentCustomer(dbConnectionManager);
		currentCustomerThread.start();
	}

	
	private void insertInitailCustomer() {
		int initialCustomerInsert = 5;
		int min = 176000000;
		int max = 177000000;
		for (int i = 0; i < initialCustomerInsert; i++) {
			int randNum = min + (int) (Math.random() * ((max - min) + 1));
			dbConnectionManager.insertCustomer(randNum);
		}
		
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	private void randomInsert(int _customerId) {
		String table = getTableRandomly();
		int minute = 1 + (int) (Math.random() * ((59 - 1) + 1));
		int hour = 0 + (int) (Math.random() * ((23 - 0) + 1));
		int duration = 1 + (int) (Math.random() * ((30 - 1) + 1));
		int size = duration;

		if (table.equals(Tables.CALLS_TAB))
			dbConnectionManager.insertCall(_customerId, hour, minute, duration);
		else if (table.equals(Tables.SMS_TAB))
			dbConnectionManager.insertSMS(_customerId, hour, minute);
		else if (table.equals(Tables.GPRS_TAB))
			dbConnectionManager.insertGPRS(_customerId, hour, minute, size);
		else if (table.equals(Tables.CUSTOMER_TAB)) {
			int gsmNo = 176000000 + (int) (Math.random() * ((177000000 - 176000000) + 1));
			dbConnectionManager.insertCustomer(gsmNo);
		}
	}

	private void randomDelete(int _customerId) {
		dbConnectionManager.deleteCustomerHistory(_customerId);
	}

	private void randomSimpleSelect(int _customerId) {
		String table = getTableRandomly();
		dbConnectionManager.selectCustomerData(_customerId, table);
	}

	private void randomUpdate(int _customerId) {
		int newGsmNo = 176000000 + (int) (Math.random() * ((177000000 - 176000000) + 1));
		dbConnectionManager.updateCustomer(_customerId, newGsmNo);
	}

	private String getTableRandomly() {
		int min = 10;
		int max = 40;
		int randNum = min + (int) (Math.random() * ((max - min) + 1));
		if (randNum <= 15)
			return Tables.GPRS_TAB;
		else if (randNum > 15 && randNum <= 20)
			return Tables.SMS_TAB;
		else if (randNum > 20 && randNum <= 24)
			return Tables.CUSTOMER_TAB;
		else
			return Tables.CALLS_TAB;
	}

	private String getOperationRandomly() {
		int min = 10;
		int max = 40;
		int randNum = min + (int) (Math.random() * ((max - min) + 1));
		//return Operations.INSERT;
		if (randNum <= 15)
			return Operations.SIMPLE_SELECT;
		else if (randNum > 15 && randNum <= 20)
			return Operations.DELETE;
		else if (randNum > 20 && randNum <= 24)
			return Operations.UPDATE;
		else
			return Operations.INSERT;
	}

	public void generateRandomQuery() {
		
		insertInitailCustomer();
		
		for (int i = 0; i < operationsCount; i++) {
			LinkedList<Integer> currentCustomer = new LinkedList<Integer>();
			currentCustomer = currentCustomerThread.getCurrentCustomer();
			int currentCustomerCount = currentCustomer.size();
			int customerIdIndex = 1 + (int) (Math.random() * ((currentCustomerCount - 1 - 1) + 1));
			int customerId = currentCustomer.get(customerIdIndex);

			String operation = getOperationRandomly();
			if (operation.equals(Operations.INSERT))
				randomInsert(customerId);
			else if (operation.equals(Operations.DELETE))
				randomDelete(customerId);
			else if (operation.equals(Operations.UPDATE))
				randomUpdate(customerId);
			else if (operation.equals(Operations.SIMPLE_SELECT))
				randomSimpleSelect(customerId);
			try {
				Thread.sleep(SleepBetweenOperation);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		currentCustomerThread.setThreadDone(true);
	}
}

class CurrentCustomer extends Thread {
	private LinkedList<Integer> currentCustomer = new LinkedList<Integer>();
	private DBConnectionManager dbConnectionManager;
	private boolean threadDone = false;

	public CurrentCustomer(DBConnectionManager _dbConnectionManager) {
		this.dbConnectionManager = _dbConnectionManager;
		this.threadDone = false;
	}
	

	public void setThreadDone(boolean _threadDone) {
		this.threadDone = _threadDone;
	}

	public boolean getThreadDone() {
		return threadDone;
	}

	public LinkedList<Integer> getCurrentCustomer() {
		return this.currentCustomer;
	}

	public void run() {
		while (!threadDone) {
			this.currentCustomer = dbConnectionManager.getCurrentCustomer();
			try {
				sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}
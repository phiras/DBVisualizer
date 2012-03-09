package de.tu.ilmenau.parser;

import java.io.FileNotFoundException;

import de.tu.ilmenau.utility.Config;

public class Main {
	public static void main (String[] args){
		LogParser parser = new MySQLLogParser(Config.getInputLogFile(), Config.getOutputCSVFile());
		try {
			parser.initializeLogFileProcessing();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Parsing is finished");
	}
}

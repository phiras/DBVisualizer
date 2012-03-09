package de.tu.ilmenau.parser;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;

abstract public class LogParser {
	
	protected File inputFile;
	protected FileWriter outputFile;
	
	protected LogParser(String inputLogFileDir, String outputCSVFileDir){
		inputFile = new File(inputLogFileDir);
	    try {
	    	outputFile= new FileWriter(outputCSVFileDir);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	protected final void initializeLogFileProcessing() throws FileNotFoundException {
		// Note that FileReader is used, not File, since File is not Closeable
		Scanner scanner = new Scanner(new FileReader(inputFile));
		try {
			// first use a Scanner to get each line
			while (scanner.hasNextLine()) {
				processLogFile(scanner);
			}
		} finally {
			// ensure the underlying stream is always closed
			// this only has any effect if the item passed to the Scanner
			// constructor implements Closeable (which it does in this case).
			scanner.close();
		}
	}
	
	protected abstract void processLogFile(Scanner scanner);
}

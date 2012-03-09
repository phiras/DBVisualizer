package de.tu.ilmenau.queryGenerator;

public class Main {
	public static void main(String[] args) {
		System.out.println("Generating is beginning");
		RandomQueryGenerator randomQueryGenerator = new RandomQueryGenerator();
		randomQueryGenerator.generateRandomQuery();
		System.out.println("Generating is finished");
	}
}

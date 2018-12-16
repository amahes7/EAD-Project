package f18g312;

import java.util.regex.Pattern;

public class abc {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String regex = "(.)*(\\d)(.)*";      
		Pattern pattern = Pattern.compile(regex);
		String msg = "What is the square of 10?";
		boolean containsNumber = pattern.matcher(msg).matches();
		System.out.println(containsNumber);
	}

}

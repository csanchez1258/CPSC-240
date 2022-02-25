#include <iostream>

extern "C" bool verifyFloat(char []);

bool verifyFloat(char w[]) {
	
	bool result       = true; 
	int  index        = 0;
	bool decimalFound = false;


	//lets check if the first index has a -, or a + sign if so then accept value
	if(w[0]=='-'|| w[0=='+']) index = 1;

	while(!(w[index] == '\0') && result) {
		//there is a decimal point within the input so accept that as well but only accept this once
		if(w[index] == '.' && !decimalFound) decimalFound = true;

		else result = result && isdigit(w[index]);

		index++;
	}
	return result && decimalFound; //if there was more than one . found then it should be false
}

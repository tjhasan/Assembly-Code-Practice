using namespace std;
#include <iostream>
#include <fstream>
#include <string>

int main() {
	cout << "Enter a String: \n";
	string input;
	cin >> input;
	
	cout << "Enter a char to search: \n";
	char searching;
	cin >> searching;
	
	int n = 0;
	
	for(int i = 0; i < input.length(); i++)
	{
		if(input[i] == searching)
		{
			n++;
		}
	}
	
	cout << "Character " << searching << " occurs in the string " << input << " " << n << " times \n";
}
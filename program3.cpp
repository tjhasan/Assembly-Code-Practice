using namespace std;
#include <iostream>
#include <fstream>
#include <string>

int main() {
	string toChange;
	char toFind;
	char toRep;
	
	cout << "Input string to change: \n";
	cin >> toChange;
	
	cout << "Input char to replace: \n";
	cin >> toFind;
	
	cout << "Input char to replace with: \n";
	cin >> toRep;
	
	string og = toChange;
	
	for(int i = 0; i < toChange.length(); i++)
	{
		if(toChange[i] == toFind)
		{
			toChange[i] = toRep;
		}
	}
	
	cout << "Original string: " << og << endl;
	cout << "Substitution: " << toFind << " --> " << toRep << endl;
	cout << "Result string: " << toChange << endl;
}
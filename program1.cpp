using namespace std;
#include <iostream>
#include <fstream>

int main() {
	cout << "Enter number of ints: ";
	int n;
	cin >> n;
	cout << endl;
	
	int intArr[n];
	for(int i = 0; i < n; i++)
	{
		cout << "Enter a number: ";
		cin >> intArr[i];
		cout << endl;
	}
	
	int sum = 0;
	int max = intArr[0];
	int min = intArr[0];
	
	for(int i = 0; i < n; i++)
	{
		sum += intArr[i];
	}
	
	for(int i = 0; i < n; i++)
	{
		if(max < intArr[i])
		{
			max = intArr[i];
		}
	}
	
	for(int i = 0; i < n; i++)
	{
		if(min > intArr[i])
		{
			min = intArr[i];
		}
	}
	
	cout << "The sum of the " << n << " integers is " << sum << endl;
	cout << "The maximum value is " << max << endl;
	cout << "The minimum value is " << min << endl;
}
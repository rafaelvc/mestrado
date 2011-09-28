#include <stdlib.h>
#include <string>
#include <iostream>
using namespace std;

int main()
{
   string str;
   char a1 = '1', a2 = '.', a3='1', a4 = '2', a5='3';
   str.push_back(a1);
   str.push_back(a2);
   str.push_back(a3);
   str.push_back(a4);
   str.push_back(a5);
   cout << atof ( str.c_str() ) + 1.0 << endl;

}

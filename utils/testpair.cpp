#include <string>
using std::string;
#include <iostream>
using std::cout;
#include <utility>
using std::pair;
using std::make_pair;
#include <vector>
using std::vector;
#include <algorithm>

 
int main () {

    pair<double,double> tuple = make_pair( 1.0, 2.0 );

    vector< pair<double, double> > * vect = new vector< pair<double, double> >; 
    
    vect->push_back ( make_pair( 1.0, 2.4 ) );
    vect->push_back ( make_pair( 1.0, 2.0 ) );
    vect->push_back ( make_pair( -1.0, 3.0 ) );
    vect->push_back ( make_pair( 2.0, 2.0 ) );
    vect->push_back ( make_pair( 10.0, 2.0 ) );
    vect->push_back ( make_pair( 3.0, 2.0 ) );
    vect->push_back ( make_pair( 1.0, 5.0 ) );

    sort( vect->begin(), vect->end() );
    
    vector< pair<double, double> >::iterator it_vect = vect->begin();
    for(;it_vect != vect->end(); ++it_vect) 
	cout << (*it_vect).first <<  "," << (*it_vect).second << std::endl;
	

    for (int i = 0; i < vect->size(); i++) 
//	cout << (vect->begin()+i).first <<  "," << (vect->begin()+i).second << std::endl;

//    cout << "tuple.first: " << tuple.first
//		           << ", tuple.second: " << tuple.second << '\n';
	     
      return 0;
}

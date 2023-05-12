/*********************************************
 * OPL 22.1.1.0 Model
 * Author: mpio
 * Creation Date: Mar 2, 2023 at 5:28:04 PM
 *********************************************/
int months = 6;
int oils = 5;

float price[i in 1..oils, j in 1..months] = ...;
float T[i in 1..oils] = ... ;

dvar float a[i in 1..months];
dvar float x[i in 1..oils, j in 1..months];
dvar float y[i in 1..oils, j in 1..months];
dvar float z[i in 1..oils, j in 0..months];
dvar boolean b[i in 1..oils, j in 1..months];

maximize
  sum(i in 1..months) a[i]*150 -
  sum(i in 1..oils, j in 1..months) x[i,j] * price[i,j] -
  sum(i in 1..oils, j in 1..months) z[i,j] * 5
;

subject to{
  forall(j in 1..months)
    zmiennaA:
    	a[j] == sum(i in 1..oils) y[i,j];
    
  forall(j in 1..months)
    MaksymalnaIloscOlejuRoslinnegoNaMiesiac:
		sum(i in 1..2) y[i,j] <= 200;
		
  forall(j in 1..months)
	MaksymalnaIloscOlejuNormalnegoNaMiesiac:
		sum(i in 3..5) y[i,j] <= 250;
		
  forall(j in 1..months)
    MaksymalnaTwardosc:
    	sum(i in 1..oils) y[i,j] * T[i] <= 6 * a[j];
    	
  forall(j in 1..months)
    MinimalnaTwardosc:
    	sum(i in 1..oils) y[i,j] * T[i] >= 3 * a[j];
    	
  forall(i in 1..oils)
    StanPoczatkowy:
    	z[i,0] == 500;
    	
  forall(i in 1..oils)
    StanKoncowy:
    	z[i,6] == 500;
    	
  forall(i in 1..oils, j in 1..months)
    relacje:
    	z[i, j-1] +
    	x[i, j] 
    		==
    	y[i,j] +
    	z[i,j];
    	
  forall(i in 1..oils, j in 0..months)
    MaksymalnePojemnosciMagazynow:
 		z[i,j] <= 1000;
 		
  forall(j in 1..months)
    Maks3Oleje:
    	sum(i in 1..oils)b[i,j] <= 3;
    	
  forall(i in 1..oils, j in 1..months)
    Min20Ton:
    	y[i,j] >= 20 * b[i,j];
 		
  forall(i in 1..oils, j in 1..months)
    zmiennaBinarna:
    	y[i,j] <= 200 * b[i,j];	
    	
  forall(i in 3..oils, j in 1..months)
    zmiennaBinarna2:
    	y[i,j] <= 250 * b[i,j];	
    	
  forall(j in 1..months)
    JesliVEG1toOIL3:
    	b[1,j] - b[5,j] <= 0;
    	
  forall(j in 1..months)
    JesliVEG2toOIL3:
    	b[2,j] - b[5,j] <= 0;
 
  forall(j in 1..months, i in 1..oils)
  	nieujemneX:
  		x[i,j] >= 0;
  		
  forall(j in 1..months, i in 1..oils)
  	nieujemneY:
  		y[i,j] >= 0;
  		
  forall(j in 0..months, i in 1..oils)
  	nieujemneZ:
  		z[i,j] >= 0;
}


//execute{
//writeln(M);
//writeln(p);
//writeln(e);
//writeln(c);
//writeln(s);
//writeln(x);
//}	
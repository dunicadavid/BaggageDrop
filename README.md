# BaggageDrop
This is a Verilog program which implements a module for a helicopter to help the pilot to deploy the baggage in time. The module is create using 3 other modules: sensors_input (which interprets the data from the 4 sensors and calculates the height to the ground), square_root (calculates the square root of a binary num using Cordic algorithm 
-> the helicopter needs to go to the ground in a range of time t, t=sqrt(height)/2), display_and_drop (check if the aria and time of drop is good and shows on a 4 element 7seq display the result).

[RO]

Sensor_Input:
	
	reg[10:0] medie;             - retine valoarea mediei calculata in acest modul
	reg[8:0] sensor1_shifted;    -  \
	reg[8:0] sensor2_shifted;    -   \ retin valoarea sensorilor cu un bit shiftat la stanga pentru a face loc zecimalelor. (vezi liniile 42-45)
	reg[8:0] sensor3_shifted;    -   /
	reg[8:0] sensor4_shifted;    -  /
	
	liniile 48-54 : calculeaza media respectand conventia din cerinta (daca vreun senzor indica 0 atunci senzorul cu aceasi paritate este anulat).
	liniile 57-59 : se verifica daca valoarea mediei trebuie incrementata (adica daca are dupa virgula cel putin 5 <=> medie[0] == 1).
	linia      62 : se transfera valoarea mediei (partea naturala [8:1]) in out(height).

Display_and_Drop:
	in blocul always se verifica inputurile si se transmit mai departe valorile pentru 7seg reprezentate pe 7 biti:
	
	liniile 32-38 : pentru drop_en == 0 => cold 
	liniile 32-38 : pentru drop_en == 1 && t_lim >= t_act => drop 
	liniile 32-38 : pentru drop_en == 1 && t_lim < t_act => hot 

Square_Root:
  in blocul always am calculat radacina patrata a inputului pe 8 biti cu metoda CORDIC, recomandata in cadrul laboratorului.
descriere algoritm: se utilizeaza o baza reprezentata de mine pe 16 biti (dublu fata de intrare). Regula de formare a bazei este de a avea bitul cel
mai din stanga 1, iar apoi baza sa fie plina de 0. Apoi facem o structura repetitiva cu un numar egal de iteratii cate are baza (in cazul meu 16). In aceasta
structura repetitiva adun la y (variabila in care calculez radicalul) baza. Dupa acest calcul verific daca noul y^2 > in(inputul); in caz afirmativ scad 
din y baza, deoarece depaseste valoarea cautata. Apoi shiftez bitul de 1 din baza la dreapta (prin impartirea la 2). Dupa executarea acestei structuri repetitive
valoarea radicalului se va forma in variabila y, care o voi transfera in out.

	reg [15:0] base;            - retine baza care se shifteaza la dreapta dupa fiecare iteratie.
	reg [15:0] y;               - se va calcula radicalul, initializare cu 0
	reg [31:0] x;		    - copie a inputului , necesara pentru iful din structura repetitiva (y * y este reprezentata pe 32 de biti in timp ce inputul este reprezentat pe 8).

	linia      31 : baza ia valoarea pe 16 biti : 1 bitul 15 si 0 in rest
	liniile 32-33 : transfer valoarea din in(input) pe ultimii biti din x [31:24], pentru ca iful sa fie efectuat corect
	liniile 36-42 : se executa structura repetitiva de 16 ori (nr de biti din base).
		linia 37      : se incrementeaza in y valoarea baseului;
		liniile 38-40 : daca valoarea y*y depaseste x atunci baseul se scade din y (deoarece radicalul ar deveni mai mare decat cel cautat).
		linia 41 : baseul se shifteaza la dreapta cu 1.
	linia      43 : in out se introduce valoarea calculata a radicalului in y, cu conditia ca se shifteaza 4 biti la dreapta {out[11:0] = y[15:4]}, deoarece s-a observat
			la testare ca valoarea in y iese corecta dar este cu 4 biti mai la stanga fara de rezultatul dorit.

Baggage_drop:
  Contine cele 3 module descrise mai sus unite dupa schema din cerinta temei.

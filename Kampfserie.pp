(*Windows Free Pascal is developed by dr J.Szymanda under the GPL License*)
(*************************************************************************)
PROGRAM bosskampf;
USES crt;
VAR Bossleben : INTEGER;
    Spielerleben,MaxLeben : INTEGER;
    Heiltraenke : INTEGER;
    Angriffsstaerke : INTEGER;
    Erfahrungspunkte : INTEGER;
    bubblenumber : INTEGER;
    bubblehight : INTEGER;
    sp1,sp2,sp3 : INTEGER;
    mp2,mp3 : INTEGER;
    atpx,gtpx,atpy,gtpy : INTEGER;
    option : INTEGER;

PROCEDURE skelett;

 BEGIN
  GOTOXY(gtpx,gtpy);
  WRITELN('Du wirst von einem Skelett angegriffen');
  GOTOXY(mp2,11);
  WRITELN('/ `O´  ');
  GOTOXY(mp3,12);
  WRITELN(' |-(@)\ ');
  GOTOXY(mp2,13);
  WRITELN('\ / \ ');
 END;
 
PROCEDURE Spieler;

 BEGIN
  GOTOXY(sp1,10);
  WRITELN(' _ ');
  GOTOXY(sp2,11);
  WRITELN(' /O\_/ ');
  GOTOXY(sp3,12);
  WRITELN(' /(@)  ');
  GOTOXY(sp2,13);
  WRITELN(' / \ ');
 END;
 
PROCEDURE clrspieler;
 BEGIN
  GOTOXY(sp1,10);
  WRITELN('   ');
  GOTOXY(sp2,11);
  WRITELN('       ');
  GOTOXY(sp3,12);
  WRITELN('       ');
  GOTOXY(sp2,13);
  WRITELN('     ');
 END;
 
PROCEDURE clrskelett;
 BEGIN
  GOTOXY(mp2,11);
  WRITELN('       ');
  GOTOXY(mp3,12);
  WRITELN('        ');
  GOTOXY(mp2,13);
  WRITELN('      ');
 END;
 
PROCEDURE menue;
 BEGIN
  GOTOXY(1,19);
  WRITELN(' ______________________________________________________________________________ ');
  GOTOXY(1,20);
  WRITE('|');
  GOTOXY(30,20);
  WRITE('Du hast ');
  WRITE( Spielerleben );
  WRITE(' Leben');
  GOTOXY(80,20);
  WRITE('|');
  GOTOXY(1,21);
  WRITE('|');
  GOTOXY(30,21);
  WRITE('Du hast ');
  WRITE(Heiltraenke);
  WRITE(' Tränke');
  GOTOXY(80,21);
  WRITE('|');
  GOTOXY(1,22);
  WRITE('|');
  GOTOXY(20,22);
  WRITELN ('Möchtest du angreifen ? (1)');
  GOTOXY(1,23);
  GOTOXY(80,22);
  WRITE('|');
  GOTOXY(1,23);
  WRITE('|');
  GOTOXY(20,23);
  WRITELN ('Möchtest du einen Heiltrank verwenden ? (2)');
  GOTOXY(80,23);
  WRITE('|'); 
  GOTOXY(80,24);
  WRITE('|');
  GOTOXY(1,24);
  WRITE('|');
  GOTOXY(2,24);
  WRITELN('______________________________________________________________________________');  
 END;
 
PROCEDURE Spieleranimation;
 BEGIN
  clrscr;
  GOTOXY (atpx,atpy);
  WRITELN('Du greifst an!');
  skelett;
  spieler;
  WHILE sp1 < 46 DO 
   BEGIN 
    DELAY(30);
    clrspieler;
    sp1 := sp1 + 2;
    sp2 := sp2 + 2;
    sp3 := sp3 + 2;
    spieler;
   END;
  DELAY(150);
  GOTOXY (sp2,11);
  WRITELN(' /O\___ ');
  DELAY(150);
  GOTOXY(sp2,11);
  WRITELN(' /O\_  ');
  GOTOXY(sp3,12);
  WRITELN(' /(@) \');
  DELAY(100);
  spieler;
  clrskelett;
  DELAY(100);
  skelett;
  DELAY(100);
  clrskelett;
  DELAY(100);
  skelett;
  DELAY(100);
  clrskelett;
  DELAY(100);
  skelett;
  DELAY(100);
  WHILE sp1 > 26 DO
   BEGIN
    clrspieler;
    sp1 := sp1 - 5;
    sp2 := sp2 - 5;
    sp3 := sp3 - 5;
    spieler;
    DELAY(100);
   END;
 END;  
 
PROCEDURE skelettanimation;
VAR arrowpos : INTEGER;
 BEGIN
  skelett;
  spieler;
  GOTOXY(atpx,atpy);
  WRITELN('Du wirst angegriffen');
  arrowpos := mp3 - 1;
  WHILE arrowpos > 28 DO
   BEGIN
    GOTOXY(arrowpos,12);
    WRITELN('- ');
    arrowpos := arrowpos - 1;
    DELAY(30);
    GOTOXY(1,1);
   END;
  clrspieler;
  DELAY(100);
  spieler;
  DELAY(100);
  clrspieler;
  DELAY(100);
  spieler;
  DELAY(100);
  clrspieler;
  DELAY(100);
  spieler;
 END;  
 
PROCEDURE Heilungsanimation;
 BEGIN;    
 CLRSCR;
 RANDOMIZE;
 WHILE bubblenumber < 30 DO
  BEGIN;
   GOTOXY(random(80),random(24));
   WRITE('@');
   INC(bubblenumber);
  END;    
 WHILE bubblehight < 24 DO
  BEGIN
   DELAY(100);
   GOTOXY(1,1);
   DELLINE;
   INC(bubblehight);   
  END;
 GOTOXY(32,11);
 WRITELN('Du wurdest geheilt!');
 READLN;
 menue;
 bubblenumber := 1;
 bubblehight := 1;
END;
    
 
PROCEDURE spielerzug;
 VAR operation : INTEGER;
 BEGIN 
  skelett;
  spieler;
  menue;
  GOTOXY(1,1);
  READLN(operation);
  IF operation = 1 THEN
   BEGIN
    spieleranimation;
    Bossleben := Bossleben - Angriffsstaerke;
   END;
   
  IF (operation = 2) AND (heiltraenke > 0) THEN
   BEGIN
    heilungsanimation;
    Spielerleben := Spielerleben + 5;
    Heiltraenke := Heiltraenke - 1;
   END;
   
  IF heiltraenke < 1 THEN
   BEGIN
    GOTOXY(45,14);
    WRITELN('du hast keine Heiltränke mehr');
    READLN;
   END;
  clrscr;
  
 END;
 
PROCEDURE Gegnerzug;
 BEGIN
  skelettanimation;
  Spielerleben := Spielerleben - 2;
 END;

PROCEDURE Kampf;
VAR rexp,ratk,rhp : INTEGER;  
 BEGIN
  atpx := 35;
  atpy := 9;
  gtpx := atpx - 10;
  gtpy := atpy - 1;
  
 
  mp2 := 55;
  mp3 := 54;
 
  sp1 := 26;
  sp2 := 25;
  sp3 := 24;
 
  bubblenumber := 1;
  bubblehight := 1;
 
  Bossleben := 10;
  
  Randomize;
  WHILE (Bossleben > 0) AND (Spielerleben > 0) DO
   BEGIN
    Spielerzug;
    Gegnerzug;
   END;
  IF Bossleben < 1 THEN
   BEGIN
    CLRSCR;
    GOTOXY(30,11);
    WRITELN ('Der Gegner wurde Besiegt');
    rexp := random(70);
    Erfahrungspunkte := Erfahrungspunkte + rexp;
    GOTOXY(25,13);
    WRITE('Du hast ');
    WRITE(rexp);
    WRITE(' Erfahrungspunkte erhalten');
    READLN;
    CLRSCR;
   END;
  
  IF Spielerleben < 1 THEN
   BEGIN
    CLRSCR;
    GOTOXY(32,11);
    WRITELN('Du wurdest besiegt');
    READLN;
   END;
   
  IF Erfahrungspunkte > 100 THEN
   BEGIN
    CLRSCR;
    Erfahrungspunkte := Erfahrungspunkte - 100;
    ratk := random(1);
    rhp := random(3);
    GOTOXY(40,11);
    WRITELN('LEVEL UP');
    IF ratk > 0 THEN
     BEGIN
      GOTOXY(30,12);
      WRITELN('+1 Angriffsschaden');
      Angriffsstaerke := Angriffsstaerke + ratk;
     END;
    IF rhp > 0 THEN
     BEGIN
      GOTOXY(30,13);
      WRITE('+');
      WRITE(rhp);
      WRITE('Lebenspunkte');
     END;
    READLN;
    CLRSCR; 
   END;
 END;
 
BEGIN
 Spielerleben := 10;
 Angriffsstaerke := 1;
 atpx := 35;
 atpy := 9;
 gtpx := atpx - 10;
 gtpy := atpy - 1;
 Heiltraenke := 5;
 Erfahrungspunkte := 0; 
 WHILE true DO
  BEGIN
   GOTOXY(gtpx,gtpy);
   WRITELN('Möchtest du einen Kampf anfangen ?');
   GOTOXY(atpx,atpy);
   WRITELN('Ja(1) oder Nein(2)');
   READLN(option);
   GOTOXY(1,1);
   IF (option = 1) AND (Spielerleben > 0) THEN
    BEGIN
     GOTOXY(atpx,atpy);
     DELLINE;
     Kampf;
    END;
  END;
END. 
  
 
 

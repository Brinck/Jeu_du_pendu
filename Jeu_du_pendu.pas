program Jeu_du_pendu (input,output);

uses crt;

//Creation du mot cach‚
procedure CreatMotCache (var Mot:string;var LongMot:integer);
        begin
        writeln('Veuillez entrer un mot a deviner');
        REPEAT
                readln(Mot);//Entree du Mot
        UNTIL (length(Mot)>=1);
        LongMot:=length(Mot); //On y stocke la longueur
        end;

//Affichage des lettres cach‚es
procedure AffNbLettres (var LongMot:integer);
        var
                i:integer;

        begin
        GoToXY(40,2);
        write('! MOT A TROUVER !');
        //Positionnement des tirets
        FOR i:=40 TO LongMot+39 DO
                begin
                GoToXY(i,3);
                write('-');
                end;
        end;

//Choix de lettre
procedure ChoixLettre (var Mot:string;var LongMot:integer;var choix:char);
        begin
        REPEAT
                GoToXY(1,3);
                write('Veuillez entrer une lettre : ');
                readln(choix);
        UNTIL (length(choix)=1);
        end;

//Affichage de la potence
procedure Potence (var Erreur:integer);
        var
                i:integer;

        begin
        //Pied potence
        IF Erreur=1 THEN
                begin
                FOR i:=1 TO 3 DO
                        begin
                        GoToXY(i,11);
                        write('_');
                        end;
                end;

        //Barre verticale
        IF Erreur=2 THEN
                begin
                FOR i:=5 TO 11 DO
                        begin
                        GoToXY(2,i);
                        write('|');
                        end;
                end;

        //Barre horizontale
        IF Erreur=3 THEN
                begin
                FOR i:=1 TO 7 DO
                        begin
                        GoToXY(i,5);
                        write('_');
                        end;
                end;

        //Corde
        IF Erreur=4 THEN
                begin
                GoToXY(6,6);
                write('|');
                end;

        //Tˆte
        IF Erreur=5 THEN
                begin
                GoToXY(6,7);
                write('0');
                end;

        //Corps
        IF Erreur=6 THEN
                begin
                GoToXY(6,8);
                write('|');
                end;

        //Bras gauche
        IF Erreur=7 THEN
                begin
                GoToXY(5,8);
                write('/');
                end;

        //Bras droit
        IF Erreur=8 THEN
                begin
                GoToXY(7,8);
                write('\');
                end;

        //Jambe gauche
        IF Erreur=9 THEN
                begin
                GoToXY(5,9);
                write('/');
                end;

        //Jambe droite
        IF Erreur=10 THEN
                begin
                GoToXY(7,9);
                write('\');
                GoToXY(12,8);
                write('PERDU, APPUYEZ SUR ENTRER');
                readln;
                end;
        end;

//Tour de jeu
procedure TourDeJeu (var Mot,verif:string; var LongMot,Trouve,Erreur,compteur:integer; var choix:char);
        var
                i:integer;

        begin
        clrscr;
        //Initialisation
        Trouve:=0;

        //Boucle de jeu
        REPEAT
                //Choix des lettres
                ChoixLettre(Mot,LongMot,choix);

                compteur:=0; //initialisation du compteur d occurences
                FOR i:=1 TO LongMot DO
                        begin
                        verif:=upcase(copy(Mot,i,1)); //Variable de verification de chaque lettres, comprenant la lettre transformee en majuscule pour la comparaison qui suit
                        IF (verif=upcase(choix)) THEN //Si les lettres correspondent, majuscules ou minuscules, alors...
                                begin
                                compteur:=compteur+1; //Incremente le compteur d occurences
                                GoToXY(i+39,3);//Aller sur les emplacement de lettres vides
                                write(upcase(choix));//On remplace le vide par la lettre en majuscule
                                end;
                        end;

                Trouve:=Trouve+compteur; //On ajoute le nombre d occurences au nombre de lettres deja trouvees

                //Verification du compteur pour determiner si la lettre est presente ou non dans le mot
                IF compteur=0 THEN
                        begin
                        Erreur:=Erreur+1; //Incremente le compteur d erreur
                        end;

                //Potence
                Potence(Erreur);
        UNTIL (Erreur=10) OR (Trouve=LongMot); //Jusqu'a ce que le pendu soit dessine ou que le mot soit trouve

        IF Trouve=LongMot THEN
                begin
                GoToXY(12,8);
                write('GAGNE, APPUYEZ SUR ENTRER');
                end;
        end;

//Programme principal
var
        Mot:string; //Mot choisi
        LongMot:integer; //Longueur du mot choisi
        choix:char; //Choix de la lettre du joueur
        compteur:integer; //Compteur d occurences
        Trouve:integer; //Nombre de lettres trouvees
        verif:string; //Variable contenant la lettre qu on verifie
        Erreur:integer; //Compteur d erreur permettant d afficher la potence

BEGIN
        clrscr;

        //Creation du mot cache
        CreatMotCache(Mot,LongMot);

        //Affichage des lettres cach‚es
        AffNbLettres(LongMot);

        //Tour de jeu
        TourDeJeu(Mot,verif,LongMot,Erreur,Trouve,compteur,choix);

        readln;
END.

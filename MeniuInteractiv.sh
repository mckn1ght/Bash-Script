#!/bin/bash
 
echo " Introduceti username-ul: "

valid=true
while [[ $valid ]]
do
	read a
	if [[ $a  == `cat /etc/passwd | cut -d ':' -f1 | grep $a` ]]
       		then
		echo "Bun venit, $a!"
	        break;

	else 
	echo " User invalid, reincercati "
	fi
done

while [[ $valid ]]
do
	echo $'\n'
	echo "Alegeti o optiune"
	echo "0.Exit"
	echo "1.Directorul personal al lui $a"
	echo "2.Procesele lui $a"
	echo "3.Fisierele lui $a"
	echo "4.Pentru toti userii did sistem afisati  UID:GID"
	echo "5.Afisati intrarile cu UID diferit de GID:UID:GID"
	echo "6.Printare romb"
	echo "7.Afisare Informatii de Sistem"
	echo "8.Afisare spatiu utilizat pe disk"
	echo "9.Afisare spatiu utilizat de $a"
	echo "10.Cautarea unui utilizator in sistem"
	echo "11.Ghiceste numarul!"	
	read alegere

case $alegere in 
	0) break;;
	
	1) echo "  Afisez directorul personal al lui $a " ;echo $'\n'
		c1=`cat /etc/passwd | grep $a | cut -d ':' -f6`
		echo "$c1"
		echo $'\n';;

	2) echo " Afisez Procesele pornite de $a ";echo $'\n'
		c2=`ps -u $a`
		echo"$c2"
		echo $'\n';;

	3) echo " Afisez fisierele lui $a " 
		echo $'\n'
		c4=`ls /home/$a`
		echo "$c4"
	        echo $'\n';;

	4) echo " UID:GID pentru toti userii: " ;echo $'\n'
		echo " ` cat /etc/passwd | cut  -d ':' -f1,3-4`" 
		echo $'\n';;
	
	5) echo " Toti userii din sistem cu UID diferit de GID:UID:GID "
	    cat /etc/passwd | cut -d ':' -f3,4 > temp.file
		while read 
		do 
			c7=`printf "%s"$REPLY | cut -d ':' -f1`
			c8=`printf "%s"$REPLY | cut -d ':' -f2`
			if [[ $c7 != $c8 ]]
			  then echo "$c7:$c8"
			fi
		done < temp.file;;

	6) MAX_NO=0
		echo  "Enter a number between 5 and 9: " 
		read MAX_NO	
		if ! [ $MAX_NO -ge 5 -a $MAX_NO -le 9 ];then
        		echo " Number must be within 5 and 9 "
        		exit 1
		fi
		clear
		for ((  i=1; i<=MAX_NO; i++))
			do
        		for (( s=MAX_NO; s>=1; s-- ))
        			do
               			 echo -n " " 
        			done
        		for (( j=1; j<=i; j++ ))
        			do
               			 echo -n "."
        			done
       		        echo ""
			done

		##########SECOND_STAGE##########


		for (( i=MAX_NO; i>=1; i-- ))
			do
 	        	for (( s=i; s<=MAX_NO; s++ ))
        	      	    do
        	     	    echo -n " "
         	     	    done
			 for (( j=1; j<=i; j++ ))
 			    do
 	                    echo -n "."
	 		    done
 	         	echo ""
 			done;;
	
	7) echo "Afisare informatii de sistem"
		echo "$HOSTNAME";;
	
	8) echo "Afisare spatiu utilizat pe disk(TOTAL)"
 		c8=`df -h`
		echo "$c8";;
		
	9) echo " Home utilisation ($a)"
       		 c9=`du -sh $HOME`
		 echo "$c9";;
  
	10) echo "Cautarea unui utilizator in sistem"
            echo "Introduceti user-ul cautat: "
   	    read utilizator
           if [[ $utilizator  == `cat /etc/passwd | cut -d ':' -f1 | grep $utilizator` ]]
	   then 
		echo "Utilizatorul $utilizator exista in sistem"
     	   else 
   		echo "Utilizatorul $utilizator nu exista in sistem"
           fi;;

   	11) count=0 #contor
	    echo "ai 3 incercari sa ghicesti numarul secret(care este de la 1 la 10)"
	    while [ $count -lt  3 ];
	     do
        	v=$(((RANDOM % 10 ) + 1 )) # vrem sa vedem continutul variabilei v / random da nr de la 1 la 32536 
        	echo -n "Alege un numar: " 
        	read b;
        	if [ $b == $v ]; then 
                echo "Ai ghicit numarul $v"; break
        	else echo "$b nu este nr corect"
        	fi
	        count=$[ $count+1 ]
       	     done;;

  esac 
done


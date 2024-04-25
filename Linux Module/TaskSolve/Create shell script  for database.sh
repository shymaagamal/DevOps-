#!/bin/bash
>>database.txt
echo  -e "press i to add new contact"\
"\npress v to view all contacts"\
"\npress s to search for record"\
"\npress e to delete all contacts"\
"\npress d to delete one contact"\
"\npress q to exist"

read userInput
while [ $userInput != q ]
do 

	if [ $userInput = i ]
	then
		read -p "Enter first name: "  fname
		read -p "Enter last name: "  lname
		read -p "Enter email: "  email
		read -p "Enter phone numer: "  phoneNum

		echo -e "$fname"\
		"\n$lname"\
		"\n$email"\
		"\n$phoneNum "\
		"\n-----------------------------------------------">> database.txt 
		read -p "if you want to return to main menu press m or q to exit: " userInput
			 

 
elif [ $userInput = v ]
then
	if [ ! -s database.txt ]; 
	then
    		echo "Database contains no contacts"
	else
    		cat database.txt
	fi
	read -p "if you want to return to main menu press m or q to exit: " userInput


elif [ $userInput = s ]
then
	if [ ! -s database.txt ];
        then
                echo "The database does not contain any contacts to search for"
        else
		read -p "Enter anything related to the record: " search
		awk -v pattern="$search" 'BEGIN { RS = "\n-----------------------------------------------\n" } $0 ~ pattern { print $0 RS }' database.txt
	
    		record_count=$(awk -v pattern="$search" 'BEGIN { RS = "\n-----------------------------------------------\n" } $0 ~ pattern { count++ } END { print count }' database.txt)
		if [ $record_count -gt 1 ]
		then

			echo "More than one record found. Please try to enter a more specific search term."
		fi
	fi
	read -p "if you want to return to main menu press m or q to exit: " userInput


elif [ $userInput = e ]
then
	echo -n > database.txt
	read -p "if you want to return to main menu press m or q to exit: " userInput


elif [ $userInput = d ]
then
	if [ ! -s database.txt ];
        then
		 echo "The database does not contain any contacts to delete"
	else 

	        read -p "Enter anything related to the record: " search
       	
 		record_count=$(awk -v pattern="$search" 'BEGIN { RS = "\n-----------------------------------------------\n" } $0 ~ pattern { count++ } END { print count }' database.txt)
                
		if [ $record_count -gt 1 ]
                then

                        echo "More than one record found. Please try to enter a more specific search term as Email or Phone Number"
		else
                	output=$(awk -v pattern="$search" 'BEGIN { RS = "\n-----------------------------------------------\n" } !($0 ~ pattern) { print $0 RS }' database.txt)
			echo "$output" > database.txt
		fi


	fi	
	
	
	read -p "if you want to return to main menu press m or q to exit: " userInput

elif [ $userInput = m ] 
then
	
	echo  -e "press i to add new contact"\
	"\npress v to view all contacts"\
	"\npress s to search for record"\
	"\npress e to delete all contacts"\
	"\npress d to delete one contact"\
	"\npress q to exist"

	read userInput
else 
	echo "Please enter one of the characters from the menu."
	read userInput
fi


done

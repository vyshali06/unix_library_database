DELETION OF ACCOUNT clear
echo -n Enter usn:
read usn
num=`grep -i $usn student|wc -l`
while [ $num -lt 1 ]
do
  if [ $num -lt 1 ]
  then
	echo INVALID USN
         echo Enter USN or 1 to exit
	 read usn
	 if [ $usn -eq 1 ]
         then
		exit
	fi
  fi
done
 num1=`grep -i $usn borrow|wc -l`
 while [ $num1 -gt 0 ]
 do
	echo The following books need to be returned before account deletion
	grep $usn borrow
        echo To return books now press 1
	read n
	if [ $n -ne 1 ]
	then 
        	exit
	else
		sh return $usn
		num1=`grep -i $usn borrow|wc -l`
	fi
 done
 grep -iv $usn student>st1
 mv st1 student
 tput setf 03
 echo Account deleted!
 tput setf 07 
 

 





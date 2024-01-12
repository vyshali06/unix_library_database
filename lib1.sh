RETURN AND BORROWING OF BOOKS
clear
echo -n Enter USN:
read usn
num=`grep -ic $usn student`
if [ $num -eq 0 -o $num -gt 1 ]
then
   echo You have entered the Wrong no.
   echo PRESS Y to Renter
   echo PRESS ANY OTHER KEY TO EXIT
   read op
   if [ "$op" = "Y" -o "$op" = "y" ]
   then
      sh new
   else
     exit
   fi
fi
ex=1
while [ $ex -eq 1 ]
do
tput setf 3
echo Enter 1 to borrow book
echo Enter 2 to return book
echo Enter 3 to change USN
echo Enter 4 to list the books borrowed
echo Enter any other no to exit
echo Enter 0 to return to menu
tput setf 7
read ch
echo $ch>r
n=`grep -i "[A-Z]" r|wc -l`
while [ $n -ne 0 ]
do
echo You have entered a wrong option,Please Enter again!
echo Enter 1 to borrow book
echo Enter 2 to return book
echo Enter 3 to change USN
echo Press any other number to EXIT
read ch
echo $ch>r
n=`grep -i "[A-Z]" r|wc -l`
done
case $ch in
0)exit;;
1)max=`grep -i $usn student|cut -d":" -f4`
 echo -n  Enter the sem whose books you want to borrow:
 read sem
 echo $sem>r
 n=`grep -i "[A-Z]" r|wc -l`
 while [ $n -ne 0 ]
 do
 echo You have entered a wrong input
 echo -n Enter the sem whose books you want to borrow
 read sem
 echo $sem>r
 n=`grep -i "[A-Z]" r|wc -l`
 done
 if [ $sem -eq 0 ]
  then 
   echo Previous Menu
   else
 while [ $sem -lt 3 -o $sem -gt 4 ]
 do
  echo The books for the semester entered is not avialable
  echo Enter sem
  read sem
done
 tput setf 1
 echo ACCESS NO:TITLE:AUTHOR:PUBLISHER
 tput setf 7
 grep ^[$sem] data1>red
 grep -iv 0$ red|cut -d":" -f1-4
 echo -n Enter access no:
 read an
 if [ $an -eq 0 ]
   then
    echo Previous Menu
   else
 num=`grep $an data1|wc -l`
 while [ $num -eq 0 -o $num -gt 1 ]
 do
   echo You have Entered the wrong access no. Please RENTER
   read an
   num=`grep $an data1|wc -l`
 done
 n=`grep $usn borrow|grep $an|wc -l`
 if [ $n -gt 0 ]
 then
   echo BOOK ALREADY BORROWED!
 else
 num=`cat data1|grep $an|cut -d":" -f6`
 if [ $num -eq 0 ]
 then
   echo Book not available
 else if [ $max -eq 0 ]
    then
     echo You have  reached the maximum limit
 else
  grep -v $an data1>t
  c1=`grep $an data1|cut -d":" -f1`
  c2=`grep $an data1|cut -d":" -f2`
  c3=`grep $an data1|cut -d":" -f3`
  c4=`grep $an data1|cut -d":" -f4`
  c5=`grep $an data1|cut -d":" -f5`
  num1=`expr $num - 1`
  echo $c1:$c2:$c3:$c4:$c5:$num1>>t
  sort -n t>data1
   grep -v $usn student>t
  c1=`grep $usn student|cut -d":" -f1`
  c2=`grep $usn student|cut -d":" -f2`
  c3=`grep $usn student|cut -d":" -f3`
  new_max=`expr $max - 1`
  d=`date "+%d"`
  m=`date "+%m"`
  y=`date "+%y"`
  newd=`expr $d + 7`
  maxd=`cal|wc -w`
  maxdays=`expr $maxd - 09`
  if [ $newd -gt $maxdays ]
   then
      newd=`expr $newd - $maxdays`
      m=`expr $m + 1`
      if [ $m -gt 12 ]
        then
          m=1
          y=`expr $y + 1`
      fi
  fi
  echo The book has to be returned on $newd/$m/$y
  echo $c1:$c2:$c3:$new_max>>t
  mv t student
  echo $usn:$an:$newd/$m/$y>>borrow
fi
fi
fi
fi
fi;;
2)n=`grep -c $usn borrow`
 if [ $n -eq 0 ]
   then
      echo You have not borrowed any books!
   else
   head -1 borrow
   grep $usn borrow
   echo Enter the access no of the book being returned
   read ac
   if [ $ac -eq 0 ]
   then
   echo Previous menu
   else
   num=`grep $ac borrow|wc -l`
   while [ $num -eq 0 ]
   do
   echo You have Entered the wrong access no. Please RENTER
   read ac
   num=`grep $ac borrow|wc -l`
   done
    grep -v $ac data1>t
    c1=`grep $ac data1|cut -d":" -f1`
    c2=`grep $ac data1|cut -d":" -f2`
    c3=`grep $ac data1|cut -d":" -f3`
    c4=`grep $ac data1|cut -d":" -f4`
    c5=`grep $ac data1|cut -d":" -f5`
    c6=`grep $ac data1|cut -d":" -f6`
    c6=`expr $c6 + 1`
    echo $c1:$c2:$c3:$c4:$c5:$c6>>t
    sort -n t>data1
    grep -v $usn student>t
    c1=`grep $usn student|cut -d":" -f1`
    c2=`grep $usn student|cut -d":" -f2`
    c3=`grep $usn student|cut -d":" -f3`
    c4=`grep $usn student|cut -d":" -f4`
    c4=`expr $c4 + 1`    
   echo $c1:$c2:$c3:$c4>>t
    mv t student
   d=`grep $ac borrow|cut -d":" -f3|cut -d"/" -f1`
   m=`grep $ac borrow|cut -d":" -f3|cut -d"/" -f2`
   y=`grep $ac borrow|cut -d":" -f3|cut -d"/" -f3`
   grep -v $ac borrow>t
   mv t borrow
   d1=`date "+%d"`
   m1=`date "+%m"`
   y1=`date "+%y"`
   if [ $y -eq $y1 ]
    then
       if [ $m1 -lt $m ]
        then
          echo NO FINE!
       else if [ $m1 -eq $m ]
         then
            if [ $d1 -le $d ]
             then
               echo NO FINE
            else
               fine=`expr $d1 - $d`
               echo $fine
            fi
           else
           total=`cal|wc -w`
           max=`expr $total - 9`
           fine=`expr $max - $d`
           m=`expr $m + 1`
           while [ $m -ne $m1 ]
             do
               wdays=`cal $m $y|wc -w`
               days=`expr $wdays - 9`
               fine=`expr $fine + $days`
               m=`expr $m + 1`
             done
             fine=`expr $fine + $d1`
           echo Your fine is $fine
       fi
      fi
    else
        total=`cal $m $y|wc -w`
        max=`expr $total - 9`
        fine=`expr $max -  $d`
        m=`expr $m + 1`
        while [ $y -lt $y1 ]
             do
               total=`cal $m $y|wc -w`
               maxd=`expr $total - 9`
               fine=`expr $fine + $maxd`
               m=`expr $m + 1`
               if [ $m -gt 12 ]
               then
                 m=1
                 y=`expr $y + 1`
               fi
             done
           while [ $m -lt $m1 ]
             do
               wdays=`cal $m $y|wc -w`
               days=`expr $wdays - 9`
               fine=`expr $fine + $days`
               m=`expr $m + 1`
             done
           fine=`expr $fine + $d1`
          echo Your fine is $fine
fi
fi
fi;;
3) sh new;;
4)n=`grep $usn borrow|wc -l`
  if [ $n -eq 0 ]
  then
    tput setf 1
    echo NO BOOKS BORROWED
    tput setf 7
   else
     head -1 borrow
    grep $usn borrow
   fi;;
*)ex=5
esac
done





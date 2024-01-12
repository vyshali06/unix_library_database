
ADDITION OF ACCOUNT 
clear
echo "PLEASE ENTER THE FOLLOWING DETAILS INORDER TO CREATE AN ACCOUNT:"
num1=0
num2=0
num3=0
num7=0
echo  -n PLEASE ENTER YOUR USN:
while [ $num1 -eq 0 -o $num2 -eq 0 -o $num3 -eq 0 ]
do
read usn
n=`grep -i $usn student|wc -l`
if [ $n -ge 1 ]
then
        echo USN already exists
        exit
fi
echo $usn>u1
num1=`grep -i [1][C][R]* u1|wc -l`
num2=`cut -c 8-10 u1`
echo $num2>n1
num7=`grep -i  [A-Z][A-Z][A-Z] n1|wc -l` 
if [ $num7 -eq 1 ]
then
  sh add1
  exit
fi
if [ $num2 -ge 150 ]
then
 num2=0
else
 num2=1
fi
num3=`cut -c 6-7 u1`
if [ "$num3" = "CS" -o "$num3" = "TE" -o "$num3" = "EC" -o "$num" = "IS" -o "$num3" = "EE" -o "$num3" = "ME" -o "$num3" = "CV" -o "$num3" = "cs" -o "$num3" = "te" -o "$num3" = "ec" -o "$num" = "is" -o "$num3" = "ee" -o "$num3" = "me" -o "$num3" = "cv" ]
then
 num3=1
else
 num3=0
fi
if [ $num1 -eq 0 -o $num2 -eq 0 -o $num3 -eq 0 ]
then
 echo "INVALID USN RE-ENTER!"
fi
done 
echo "ENTER YOU NAME:"
read name
echo "ENTER YOUR SEMESTER:"
read sem
if [ $sem -gt 8 -o $sem -lt 1 ]
then 
 echo "INVALID! ENTER A VALID SEMESTER"
fi 
num=5
echo $usn:$name:$sem:$num>>student
rm u1
tput setf 03
echo ACCOUNT CREATED!
tput setf 07

		


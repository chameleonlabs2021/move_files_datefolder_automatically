#!/bin/sh

fil1=listfile.txt
curr_year=$1
check_year()
{
if [[ $1 =~ ^[0-9]{4}$ ]];   then
echo $1
return $1
else
return 1
fi
}

#list all the files 
find . -type f -ls > $fil1


while read -r line;
do
echo "line: $line"
sleep 1
   year=`echo "$line" |awk -F ' ' '{print $10}'`
   file=`echo "$line" |awk '{out=""; for(i=11;i<=NF;i++){out=out" "$i}; print out}'` 
   echo "year : $year"
   chk=`check_year "$year"`
echo "year: $year" 
echo "check: $chk" 
sleep 1
echo "file: $file"
    if [[ ${chk} == $year ]]
    then 
    echo "creating the folder ${year}"
    mkdir ${year}
    echo "moving files to the folder ${year}"
    # echo "mv $file ../sorted_photos/$year/ " >> $move
    mv -f $file ${year}/
    else
    echo "moving files to the folder 2022"
    # echo "mv $file ../sorted_photos/2022/ " >> 2022.txt
    echo "creating the folder ${curr_year}"
    mkdir ${curr_year}
    mv -f $file $curr_year/
    fi
done < ${fil1}
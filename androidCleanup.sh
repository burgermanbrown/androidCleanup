#!/bin/bash

#User enters list of unwanted packages delimited by spaces, string is then passed to an array
read -p "enter list of packages seprated by spaces: " input ;
pkgListUsr=($input) ;

#For loop that iterates through each item in the array and checks it against the package list on the android device and creates an array of the confirmed packages
pkgRmv=( $(
for a in "${pkgListUsr[@]}"
   do adb shell cmd package list packages | sed "s/package://" | grep $a ;
done
) )

#Return list of confirmed packages
echo "The following packages have been confirmed as installed: " ;
sleep 3;
for b in "${pkgRmv[@]}"
   do echo $b ;
   sleep 0.5 ;
done

#User opts to disable or uninstall packages
read -p "Would you like to disable or uninstall these packages? [disable/uninstall]: " choice ;
if [ "$choice" == "disable" ]
then
   for c in "${pkgRmv[@]}"
      do adb shell pm disable-user --user 0 $c ;
   done
fi
if [ "$choice" == "uninstall" ]
then
   for d in "${pkgRmv[@]}" ;
      do adb shell pm uninstall -k --user 0 $d ;
   done
fi
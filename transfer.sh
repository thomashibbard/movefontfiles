#! /bin/bash

#2015.03.04 by thomas hibbard
#in response to:
	#/*OBFUSCATED*/
		#Write Command Line Script for Moving FOF2 Files to the Font Server
	#/*OBFUSCATED*/
		#Write Command Line Script for Moving FOF1 Files to the Local Drive


#set default directories for each file transfer type
#the user will have an opportunity to specify a 
#if he or she would like to export files from another
#source, however the folders that are being imported to
#are hard coded

defaultExportDirectory2721="/Users/$LOGNAME/alecto/Final/fof"
importDirectory2721="/mnt/CT-2721_dev/"

defaultExportDirectory2342="/Users/$LOGNAME/alecto/Final/"
#importDirectory2342="/Volumes/local/fonts/bitmapFonts/2"
importDirectory2342="/Volumes/local/ct-2342_testing"


cat << _EOF_
Press [1] to transfer FontsOfFury 2 files to the font server
Press [2] to transfer FontsOfFury 1 files to the Local drive
_EOF_

read -n 1 option                                                             
echo                                              

if [ $option -eq 1 ]
then
	
	importDirectory=$importDirectory2721

	#inform user default directory that will be used
	echo "Default directory from which to export will be $defaultExportDirectory2721."
	read -p "is this good for you? (y/n) " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]
		
	then
	    
		#declare directory as $default
		exportDirectory=$defaultExportDirectory2721

	else

		#prompt of for input
		#inform them they can drag a directory into terminal window
		#declare input as directory
		echo "Manually enter directory or drag from Finder window, then press [ENTER]:"
		read exportDirectory;

	fi

	#create mount
	echo
	echo "Mounting import directory. You may be prompted for your password."
	#sleep to give time to read about being prompted by password
	sleep 2

	sudo mkdir /mnt
	sudo mount -t nfs -o intr,tcp,nolock,vers=3 #OBFUSCATED# /mnt;
	echo "Import mount created"
	echo

else

	#check if user is connected to local drive
	echo "Checking connection to /*OBFUSCATED*/
	echo
	sleep 1
	localMount="/Volumes/local/fof"
	if [ -d "$localMount" ]; 
	then 
		echo
		echo "You are connected to /*OBFUSCATED*/."
		echo
	else 
		echo
		echo "You appear not to be connected to opslocal/local. Please connect."
		read -p "Please connect and press y when complete." -n 1 -r

		if [[ $REPLY =~ ^[^Yy]$ ]]
		then
			echo
			"You have chosen not to proceed. Execution terminated."
			exit
		else
			sleep 1
			echo
			echo "Proceeding..."
			echo
		fi	
	fi



	importDirectory=$importDirectory2342

	#inform user default directory that will be used
	echo "Default directory from which to export will be $defaultExportDirectory2342."
	read -p "is this good for you? (y/n) " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]
		
	then
	    
		#declare directory as $default
		exportDirectory=$defaultExportDirectory2342

	else

		#prompt of for input
		#inform them they can drag a directory into terminal window
		#declare input as directory
		echo "Manually enter directory or drag from Finder window, then press [ENTER]:"
		read exportDirectory;

	fi

	#exportDirectory=$defaultExportDirectory2342

fi



#start debug
echo
echo "Directory from which files will be exported is $exportDirectory."
echo "Directory into which files will be imported is $importDirectory."
echo 
read -p "does all this seem good for you? (y/n) " -n 1 -r
echo
#end debug



echo

if [[ $REPLY =~ ^[Yy]$ ]]
	
then
	
	echo "moving ..."


else

	echo "Execution terminated" && exit 1

fi

echo

if cp -rv $exportDirectory $importDirectory

then
	echo
	echo "Transfer complete. Have a nice day."
	echo
else 
	echo
	echo "ERROR."
	echo
fi










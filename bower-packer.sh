#!/bin/sh

if [ "$#" -eq "0" -o "$1" == "--build" -o "$1" == "-b" ]
then
	if [ -f bower.json ]
	then
		name=$(grep name bower.json | cut -d ":" -f2 | tr -d \"," ")
		#creates the tar file after creating relevant files
		temp_folder_name=$(date | tr -d " :")
		mkdir -p ../$temp_folder_name/$name
		cp -rf * ../$temp_folder_name/$name
		cd ../$temp_folder_name
		rm -rf $name/*.sh $name/*.git
		tar -zcvf $name.tar.gz "$name"
		cd -
		mv ../$temp_folder_name/$name.tar.gz .
		rm -rf ../$temp_folder_name
		printf "$name.tgz has been created!\n"
	else
		echo "bower.json doesn't exist in build source!"
	fi
elif [ "$1" == "--clean" -o "$1" == "-c" ]
then
	if [ -f bower.json ]
	then
		name=$(grep name bower.json | cut -d ":" -f2 | tr -d \"," ")
		if [ -f $name.tar.gz ]
		then
			rm -rf $name.tar.gz
			if [ "$?" -eq 0 ]
			then
				echo "$name.tar.gz has been removed"
			else
				echo "Some error occured while attempting to delete $name.tar.gz"
			fi
		else
			echo "$name.tar.gz doesn't exist in this directory!"
		fi
	else
		echo "bower.json doesn't exist in build source!"
	fi
elif [ "$1" == "--help" ]
then
        printf "Usage: bash bower-packer.sh [option]\n"
        printf "Possible options:\n"
        printf " --build \tIt builds the package this is the default option\n"
        printf "\t\tAlternatively -b can be used\n"

        printf " --clean \tIt cleans the latest tar file that was built using this packer\n"
        printf "\t\tAlternatively -c can be used\n"
else
	printf "Usage: bash bowerm-packer.sh [option]\n"
	printf "Possible options:\n"
	printf " --build \tIt builds the package this is the default option\n"
	printf "\t\tAlternatively -b can be used\n"

	printf " --clean \tItcleans the latest tar file that was built using this packer\n"
        printf "\t\tAlternatively -c can be used\n"
fi

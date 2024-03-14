#!/bin/bash

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo -e "\e[1;31mThis comamnd must be run as root\e[0m"
    exit 1
fi

#reboot the system after updating the GRUB
reboot_system()
{	
	echo   -e "\e[36mGRUB has been successfully updated. Do you need to reboot(y/n):\e[O"
	read option;
	if [[ $option == y ]]
	then
		reboot

	else
		echo -e "\e[35mOK BOSS, Reboot manually"
	fi
}


# Check if an argument is provided then enter to next condition 
if [[ $# == 1 ]]
then 
	#If 1 mean increase the brightness.
	if [[ "$1" == 1 ]]
	then
		# changes made in the grub config file.
		grub_file="/etc/default/grub"

		line_number=10 # GRUB_CMDLINE_LINUX_DEFAULT="QUIET SPLASH"
		line_number1=11 #GRUB_CMDLINE_LINUX="amdgpu.backlight=100"
		# Function to update GRUB
		add_slash(){
			sed -i "${line_number}s/^/#/" "$grub_file"
			sed -i "${line_number1}s/^#//" "$grub_file"	
		}
		add_slash # calling the funcation 
		sudo update-grub # updating the grub.
		reboot_system

	# If 0 means decrease the brightness.
	elif [[ "$1" == 0 ]]
	then
		# echo "in o part"
		grub_file="/etc/default/grub"

		line_number=11
		line_number1=10
		# Function to update GRUB
		add_slash(){
			sed -i "${line_number}s/^/#/" "$grub_file"
			sed -i "${line_number1}s/^#//" "$grub_file"
		}
		

		add_slash # calling the function
		sudo update-grub #updating the grub
		reboot_system


	else
		echo -e "\e[33mEnter either (1/0)"
	fi
	
	

else
	# if no arguments are given print the error
	echo -e "\e[31mYou need to enter arguments (0/1)!"
fi



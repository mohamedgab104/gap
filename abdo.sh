#!/bin/bash

# Function to display menu using whiptail
main_menu() {
    whiptail --title "Main Menu" --menu "Choose an option" 20 75 13 \
    "1- Add User" "Add a user to the system." \
    "2- Modify User" "Modify an existing user" \
    "3- Delete User" "Delete an existing user" \
    "4- List Users" "List all users on the system" \
    "5- Add Group" "Add a user group to the system" \
    "6- Modify Group" "Modify a group" \
    "7- Delete Group" "Delete an existing group" \
    "8- List Groups" "List all groups on the system" \
    "9- Disable User" "Lock the user account" \
    "10- Enable User" "Unlock the user account" \
    "11- Change Password" "Change password of the user" \
    "0- About" "Information about this script" \
    "00- Exit" "Exit" 3>&1 1>&2 2>&3
}

while true; do
    choice=$(main_menu)

    case "$choice" in
        "1- Add User")
            username=$(whiptail --inputbox "Enter username to add:" 10 45 --title "Add User" 3>&1 1>&2 2>&3)
            sudo useradd "$username"
	    whiptail --title "Add User"  --msgbox "User ($username) successfully added" 10 45
            ;;
        "2- Modify User")
            username=$(whiptail --inputbox "Enter username to modify:" 10 45 --title "Modify User" 3>&1 1>&2 2>&3)
            new_username=$(whiptail --inputbox "Enter the new username:" 10 45 --title "Modify User" 3>&1 1>&2 2>&3)
            sudo usermod -l "$new_username" "$username"
            ;;
        "3- Delete User")
            username=$(whiptail --inputbox "Enter username to delete:" 10 45 --title "Delete User" 3>&1 1>&2 2>&3)
            sudo userdel -r "$username"
            whiptail --title "Delete User"  --msgbox "User ($username) successfully Deleted" 10 45
            ;;
        "4- List Users")
            users=$(cut -d: -f1 /etc/passwd)
            whiptail --msgbox "$users" 42 35 --title "List Users"
            ;;
        "5- Add Group")
            groupname=$(whiptail --inputbox "Enter group name to add:" 10 45 --title "Add Group" 3>&1 1>&2 2>&3)
            sudo groupadd "$groupname"
            ;;
        "6- Modify Group")
            groupname=$(whiptail --inputbox "Enter group name to modify:" 10 45 --title "Modify Group" 3>&1 1>&2 2>&3)
            new_groupname=$(whiptail --inputbox "Enter the new group name:" 10 45 --title "Modify Group" 3>&1 1>&2 2>&3)
            sudo groupmod -n "$new_groupname" "$groupname"
            ;;
        "7- Delete Group")
            groupname=$(whiptail --inputbox "Enter group name to delete:" 10 45 --title "Delete Group" 3>&1 1>&2 2>&3)
            sudo groupdel "$groupname"
            ;;
        "8- List Groups")
            groups=$(cut -d: -f1 /etc/group)
            whiptail --msgbox "$groups" 20 60 --title "List Groups"
            ;;
        "9- Disable User")
            username=$(whiptail --inputbox "Enter username to disable:" 10 45 --title "Disable User" 3>&1 1>&2 2>&3)
            sudo usermod --lock "$username"
	    whiptail --title "Disable User"  --msgbox "User ($username) successfully Locked" 10 45
            ;;
        "10- Enable User")
            username=$(whiptail --inputbox "Enter username to enable:" 10 45 --title "Enable User" 3>&1 1>&2 2>&3)
            sudo usermod --unlock "$username"
      	    whiptail --title "Enable User"  --msgbox "User ($username) successfully Unlocked" 10 45
            ;;
        "11- Change Password")
            username=$(whiptail --inputbox "Enter username for password change:" 10 45 --title "Change Password" 3>&1 1>&2 2>&3)
            sudo passwd "$username"
	    whiptail --title "Change Password"  --msgbox "Done successfully" 10 45
            ;;
        "0- About")
            whiptail --msgbox "This program provides a menu-driven interface for managing users and groups on a Linux system..." 10 45 --title "About"
            ;;
        "00- Exit")
            break
            ;;
        *)
            whiptail --title "Error" --msgbox "Invalid option selected!" 10 45
            ;;
    esac
done

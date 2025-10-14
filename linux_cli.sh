#! /bin/bash


#echo "Pouzivam SHELL:"
#echo $SHELL

#echo "Aktualni uzivatel je:"
#whoami

#echo "Distribuce linuxu:"
#cat /etc/os-release

#echo "Evnironment variables v OS jsou:"
#printenv


LOG_MODE="stdout"
LOG_FILE="linux_cli.log"
 



log() {
	if [ "$LOG_MODE" = "file" ]; then
		echo "$1 $2" >> "$LOG_FILE"
	else
		echo "=== $1 $2 ==="
	fi
 } 

log_error() {
	if [ "$LOG_MODE" = "file" ]; then
		echo "$1" >> "$LOG_FILE"
	else
		echo "Error: $1" >&2
	fi       	
}

list_update() {
	echo "$1"
	apt list --upgradable
}

upgrade_package() {
	echo "$1"
	sudo apt upgrade 
}

show_help() {
	echo "You can use: ./linux_cli.sh [option]"
	echo ""
	echo "This help contains these options:"
	echo "-h, --help		Shows this help"
	echo "--create-link		Soft link creation"
	echo "etc"
}

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        show_help
        exit 0
fi

create_soft_link() {
	target_path="$(realpath "$0")"
	link_path="/bin/linux_cli"
	
	sudo ln -s "$target_path" "$link_path"
	echo "Soft link created: $link_path -> $target_path"
}

if [ "$1" = "--create-link" ]; then
	create_soft_link
	exit 0
fi


log "System" "OK" 
log_error "Need restart"
list_update "Packages for upgrade:"
upgrade_package "Ugrade package"

find_bee_files() {
	find / -type f -regextype posix-extended -regex ".*/.*b.*e.*e.*"
}

if [ "$1" = "--find-bee" ]; then
	find_bee_files
	exit 0
fi




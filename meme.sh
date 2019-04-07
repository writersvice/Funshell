#!/usr/bin/env bash
bg=""
filename=""
first=""
second=""

main(){
	if [[ "$bg" == "" ]]; then
		echo -n "Enter the name for the meme's background "
		read -r bg
	fi
	if [[ "$first" == "" ]]; then
		echo -n "Enter the first line: "
		read -r first
	fi
	if [[ "$second" == "" ]]; then
		echo -n "Enter the second line: "
		read -r second
	fi
	if [[ "$filename" == "" ]]; then
		echo -n "Enter the filename: "
		read -r filename
	fi
	wget -qO "$filename" "https://memegen.link/$bg/$first/$second.jpg" || return 1
	return 0
}

usage(){
	cat <<EOF
Meme
Description: A Meme Generator
Usage: meme.sh [-h] [{-m <background>}] [{-t <top_text>}] [{-b <bottom_text>}] [{-f <filename>}]
	-h Show this help
	-m Choose the meme
	-t Choose The top text
	-b Choose the bottom text
	-f Choose the filename
Examples:
	meme -h
	meme -m doge -t top -b bottom -f meme.png
EOF
}

while getopts ":hm:t:b:f:" opt; do
	case "$opt" in
	h)
		usage
		exit 0
		;;
	m)
		bg=$OPTARG
		;;
	t)
		first=$OPTARG
		;;
	b)
		second=$OPTARG
		;;
	f)
		filename=$OPTARG
		;;
	\?)
		echo "Invalid option: -$OPTARG" >&2
		exit 1
		;;
	:)
		echo "Option -$OPTARG requires an argument." >&2
		;;
	esac
done

main || exit 1
exit 0

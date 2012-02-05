#!/bin/bash

LOREM_PIXEL_URL='http://lorempixel.com'
WIDTH='800'
HEIGHT='600'
REPEAT='1'
DRY_RUN=false
VERBOSE='-nv'
CATEGORY='0'

URL=$LOREM_PIXEL_URL

IMAGE_NAME='image'

usage()
{
cat << EOF
usage: $0 options

This script run the test1 or test2 over a machine.

OPTIONS:
   -i      Show this message
   -w      Width of the image, if ommited the default value of $WIDTH is used
   -h      Height of the image, if ommited the default value of $HEIGHT is used
   -c      category of the image, categories are: abstract, animals, city, food, nightlife, fashion, people, nature, sports, technics, transport   
   -r      How many images do you need, aka how many times to repeat the process, default is $REPEAT
   -v 	   verbose mode
   -d 	   Dry run, testing purposes only   
EOF
}

while getopts “itgtdtvt:w:h:r:c:” OPTION
do
     case $OPTION in
         help)
             usage
             exit 1
             ;;
         w)
             WIDTH=$OPTARG
             ;;
         h)
             HEIGHT=$OPTARG
             ;;
         r)
             REPEAT=$OPTARG
             ;;
         c)
             CATEGORY=$OPTARG
             ;;                       
         g)
             URL=$LOREM_PIXEL_URL'/greyscale'
             IMAGE_NAME='image-greyscale'
             ;;  
         v)
             VERBOSE=''
             ;;              
         d)
             DRY_RUN=true
             ;;  
         ?)
             usage
             exit
             ;;
     esac
done


ITERATION='0'

while [ $ITERATION -lt $REPEAT ]
do
	WGET_URL="$URL/$WIDTH/$HEIGHT/$CATEGORY"

	WGET_IMAGE=$IMAGE_NAME

	if [[ CATEGORY != '0' ]];
		then
		WGET_IMAGE=$WGET_IMAGE'-'$CATEGORY
	fi

	WGET_IMAGE=$WGET_IMAGE'-'$WIDTH'-'$HEIGHT

	if [ $REPEAT -gt '1' ];
		then
		WGET_IMAGE=$WGET_IMAGE'-'$[$ITERATION+1]
	fi

		WGET_IMAGE=$WGET_IMAGE'.jpg'

	if [ $DRY_RUN == true ];
		then
		echo $WGET_URL' -> '$WGET_IMAGE
		else
		wget -O $WGET_IMAGE $WGET_URL $VERBOSE
	fi		
		
	ITERATION=$[$ITERATION+1]
done




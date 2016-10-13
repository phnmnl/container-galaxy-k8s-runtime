#!/bin/bash


# prompt for pass
IFS= read -s  -p 'Enter Password:' pwd
echo
IFS= read -s  -p 'Confirm Password:' pwd2

if [ "$pwd" == "$pwd2" ]
then
	PASS=`echo -n $pwd | base64`
        echo $PASS	
	sed s/\<pass\>/$PASS/ db_secret_template.yaml > db_secret.yaml
else
	echo "Passwords don't match"
	exit 1
fi

kubectl create -f db_secret.yaml

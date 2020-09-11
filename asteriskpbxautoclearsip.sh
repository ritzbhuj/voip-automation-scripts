#!/bin/bash
#Date:2020-09-11
#********************************
#Declarations
mikUsername="XXXXXXX" #->Mikrouterusername
mikPassword="XXXXXXX" #->Mikrouterpassword
regString="XXXXXXX" #e.g "200" your extension number
mikIP="192.xxx.xxx.xxx" # IP address of mik router

cstat=$(/usr/sbin/asterisk -rvx 'sip show peer ${regString}'|grep Status |awk '{print $3}')
#*********************************
case "${cstat}" in
        UNKNOWN)
		sshpass -p ${mikPassword} ssh -n -p 2222 ${mikUsername}@${mikPassword} system script run remsipcon
        echo "extension ${regString} is not registered, sending SIP clearance request to router";
        logger "extension ${regString} is not registered, sending SIP clearance request to router";
		sleep 300
        ;;
        *)
        echo "extension ${regString} is registered";
        logger "extension ${regString} is registered";
        ;;
esac


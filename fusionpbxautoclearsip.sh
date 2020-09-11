#!/bin/bash
#Date: 2020-09-07
#By: ritzbhuj
#Desc: Script to check extension registration status on fusion and remove stale sip connection off mikrotik router

#Declarations:#######
mikUsername="XXXXXXX" #->Mikrouterusername
mikPassword="XXXXXXX" #->Mikrouterpassword
regString="XXXXXXX" #e.g "105@yourpbx.yourdomain.co.za"
mikIP="192.xxx.xxx.xxx" # IP address of mik router
cstat=$(fs_cli -x "sofia status profile internal reg" | grep -A 5 ${regstring}| grep ^Status| sed 's/(/    /g'|awk '{print $2}')
#end-Declarations######

case "${cstat}" in
        Registered)
            echo "extension ${regString} is registered";
            logger "extension ${regString} is registered";
            sleep 300;
        ;;
        *)
            echo "extension ${regString} is not registered, sending SIP clearance request to router";
            logger "extension ${regString} is not registered, sending SIP clearance request to router";
            sshpass -p ${mikPassword} ssh -o StrictHostKeyChecking=no -n -p 2222 ${mikUsername}@${mikIP} system script run remsipcon;
            sleep 300;
        ;;
esac


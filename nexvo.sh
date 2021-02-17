#!/bin/bash
##############################################################
##                    COLORING YOUR SHELL                   ##
##############################################################
white="\033[1;37m"                                          ##
grey="\033[0;37m"                                           ##
purple="\033[0;35m"                                         ##
red="\e[91m"                                                ##
green="\e[92m"                                              ##
yellow="\e[93m"                                             ##
purple="\033[0;35m"                                         ##
cafe="\033[0;33m"                                           ##
fiuscha="\033[0;35m"                                        ##
blue="\033[1;34m"                                           ##
darkgrey="\e[100m"                                          ##
nc="\e[0m"                                                  ##
##############################################################

function options_nexmo() {
clear
cat << "EOF" 
    ██████   █████   █████████     ███████    ██████   █████ ███████████    ███████    █████      
    ░░██████ ░░███   ███░░░░░███  ███░░░░░███ ░░██████ ░░███ ░█░░░███░░░█  ███░░░░░███ ░░███       
    ░███░███ ░███  ███     ░░░  ███     ░░███ ░███░███ ░███ ░   ░███  ░  ███     ░░███ ░███       
    ░███░░███░███ ░███         ░███      ░███ ░███░░███░███     ░███    ░███      ░███ ░███       
    ░███ ░░██████ ░███    █████░███      ░███ ░███ ░░██████     ░███    ░███      ░███ ░███       
    ░███  ░░█████ ░░███  ░░███ ░░███     ███  ░███  ░░█████     ░███    ░░███     ███  ░███      █
    █████  ░░█████ ░░█████████  ░░░███████░   █████  ░░█████    █████    ░░░███████░   ███████████
    ░░░░░    ░░░░░   ░░░░░░░░░     ░░░░░░░    ░░░░░    ░░░░░    ░░░░░       ░░░░░░░    ░░░░░░░░░░░ 

                                [NEXMO SENDER - NGONTOL DEV 2021]
EOF
printf "    List : "
read leadslist
printf "    Letter : "
read letter_nexmo
printf "    Name : "
read fm_nexmo
threads="2"
## AKUN NEXMO ##
pk_nexmo="********"
sk_nexmo="********"

## BANNER ##
clear
cat << "EOF" 
    ██████   █████   █████████     ███████    ██████   █████ ███████████    ███████    █████      
    ░░██████ ░░███   ███░░░░░███  ███░░░░░███ ░░██████ ░░███ ░█░░░███░░░█  ███░░░░░███ ░░███       
    ░███░███ ░███  ███     ░░░  ███     ░░███ ░███░███ ░███ ░   ░███  ░  ███     ░░███ ░███       
    ░███░░███░███ ░███         ░███      ░███ ░███░░███░███     ░███    ░███      ░███ ░███       
    ░███ ░░██████ ░███    █████░███      ░███ ░███ ░░██████     ░███    ░███      ░███ ░███       
    ░███  ░░█████ ░░███  ░░███ ░░███     ███  ░███  ░░█████     ░███    ░░███     ███  ░███      █
    █████  ░░█████ ░░█████████  ░░░███████░   █████  ░░█████    █████    ░░░███████░   ███████████
    ░░░░░    ░░░░░   ░░░░░░░░░     ░░░░░░░    ░░░░░    ░░░░░    ░░░░░       ░░░░░░░    ░░░░░░░░░░░

                                [NEXMO SENDER - NGONTOL DEV 2021]
EOF
printf "\n    ==================================== $(date +"%H:%M:%S") ====================================\n"

function sendnexmo1() {
	sendnexmo="${1}"
    if [[ $(curl -s -X "POST" "https://rest.nexmo.com/sms/json" -d "from=$fm_nexmo" -d "text=$(cat $letter_nexmo)" -d "to=$sendnexmo" -d "api_key=$pk_nexmo" -d "api_secret=$sk_nexmo" | jq '.messages | .[].status' | tr -d '"') =~ "0" ]]; then
		printf "    [${yellow}$(date +"%H:%M:%S")${white}]-[${green}SUCCESS${white}]---->>[${purple}Balance ${white}: ${yellow}$(curl -s "https://rest.nexmo.com/account/get-balance?api_key=$pk_nexmo&api_secret=$sk_nexmo" | jq .value)${white}]---->>[Send to : ${green}$sendnexmo${white}]  \n"
	else
		printf "    [${yellow}$(date +"%H:%M:%S")${white}]-[${red}FAILED${white}]---->>[${purple}Error ${white}: ${red}$(curl -s -X "POST" "https://rest.nexmo.com/sms/json" -d "from=$fm_nexmo" -d "text=$(cat $letter_nexmo)" -d "to=$sendnexmo" -d "api_key=$pk_nexmo" -d "api_secret=$sk_nexmo" | jq '.messages | .[]."error-text"' | tr -d '"')${white}]---->>[Send to : ${red}$sendnexmo${white}]  \n"
	fi
	wait
}

for sendnexmo in $(cat $leadslist); do
    ((cthread=cthread%threads)); ((cthread++==0)) && wait
    sendnexmo1 "$sendnexmo" &
    wait
    exit
done
}
## PLIVO FUNCTION
function options_plivo() {
clear
cat << "EOF" 
    ██████   █████   █████████     ███████    ██████   █████ ███████████    ███████    █████      
    ░░██████ ░░███   ███░░░░░███  ███░░░░░███ ░░██████ ░░███ ░█░░░███░░░█  ███░░░░░███ ░░███       
    ░███░███ ░███  ███     ░░░  ███     ░░███ ░███░███ ░███ ░   ░███  ░  ███     ░░███ ░███       
    ░███░░███░███ ░███         ░███      ░███ ░███░░███░███     ░███    ░███      ░███ ░███       
    ░███ ░░██████ ░███    █████░███      ░███ ░███ ░░██████     ░███    ░███      ░███ ░███       
    ░███  ░░█████ ░░███  ░░███ ░░███     ███  ░███  ░░█████     ░███    ░░███     ███  ░███      █
    █████  ░░█████ ░░█████████  ░░░███████░   █████  ░░█████    █████    ░░░███████░   ███████████
    ░░░░░    ░░░░░   ░░░░░░░░░     ░░░░░░░    ░░░░░    ░░░░░    ░░░░░       ░░░░░░░    ░░░░░░░░░░░ 

                                [PLIVO SENDER - NGONTOL DEV 2021]
EOF
printf "    List : "
read leadslist
printf "    Letter : "
read letter_plivo
##printf "Name : "
##read fm_plivo
threads="2"
## AKUN plivo ##
pk_plivo="********"
sk_plivo="********"

## BANNER ##
clear
cat << "EOF" 
    ██████   █████   █████████     ███████    ██████   █████ ███████████    ███████    █████      
    ░░██████ ░░███   ███░░░░░███  ███░░░░░███ ░░██████ ░░███ ░█░░░███░░░█  ███░░░░░███ ░░███       
    ░███░███ ░███  ███     ░░░  ███     ░░███ ░███░███ ░███ ░   ░███  ░  ███     ░░███ ░███       
    ░███░░███░███ ░███         ░███      ░███ ░███░░███░███     ░███    ░███      ░███ ░███       
    ░███ ░░██████ ░███    █████░███      ░███ ░███ ░░██████     ░███    ░███      ░███ ░███       
    ░███  ░░█████ ░░███  ░░███ ░░███     ███  ░███  ░░█████     ░███    ░░███     ███  ░███      █
    █████  ░░█████ ░░█████████  ░░░███████░   █████  ░░█████    █████    ░░░███████░   ███████████
    ░░░░░    ░░░░░   ░░░░░░░░░     ░░░░░░░    ░░░░░    ░░░░░    ░░░░░       ░░░░░░░    ░░░░░░░░░░░

                                [PLIVO SENDER - NGONTOL DEV 2021]
EOF
printf "\n    ==================================== $(date +"%H:%M:%S") ====================================\n"

function sendplivo1() {
	sendplivo="${1}"
    if [[ $(curl -s --user "$pk_plivo:$sk_plivo" -H "Content-Type: application/json" -d "{\"src\":\"+14707584222\",\"dst\":\"$sendplivo\",\"text\":\"$(cat $letter_plivo)\",\"url\":\"http://webhook.site/c7a0b423-8d1f-46fe-9a81-1dfa8254bdaf\"}" "https://api.plivo.com/v1/Account/$pk_plivo/Message/" | jq '.message' | tr -d '"') =~ "message(s) queued" ]]; then
		printf "    [${yellow}$(date +"%H:%M:%S")${white}]-[${green}DONE${white}]---->>[${purple}Balance ${white}: ${yellow}$(curl -s --user MAMJYZN2ZMNGVKZGNJND:MmFlYmFiMTgzYTJkNjdhNDM4NTA1NzI2MTliZjFl "https://api.plivo.com/v1/Account/MAMJYZN2ZMNGVKZGNJND/" | jq ".cash_credits" | tr -d '"')${white}]---->>[Send to : ${green}$sendplivo${white}]  \n"
	else
		printf "    [${yellow}$(date +"%H:%M:%S")${white}]-[${red}FAIL${white}]---->>[${purple}Error ${white}: ${red}$(curl -s --user "$pk_plivo:$sk_plivo" -H "Content-Type: application/json" -d "{\"src\":\"+14707584222\",\"dst\":\"$sendplivo\",\"text\":\"$(cat $letter_plivo)\",\"url\":\"http://webhook.site/c7a0b423-8d1f-46fe-9a81-1dfa8254bdaf\"}" "https://api.plivo.com/v1/Account/$pk_plivo/Message/" | jq '.error' | tr -d '"')${white}]---->>[Send to : ${red}$sendplivo${white}]  \n"
	fi
	wait
}

for sendplivo in $(cat $leadslist); do
    ((cthread=cthread%threads)); ((cthread++==0)) && wait
    sendplivo1 "$sendplivo" &
    wait
done
}
clear
cat << "EOF" 
    ██████   █████   █████████     ███████    ██████   █████ ███████████    ███████    █████      
    ░░██████ ░░███   ███░░░░░███  ███░░░░░███ ░░██████ ░░███ ░█░░░███░░░█  ███░░░░░███ ░░███       
    ░███░███ ░███  ███     ░░░  ███     ░░███ ░███░███ ░███ ░   ░███  ░  ███     ░░███ ░███       
    ░███░░███░███ ░███         ░███      ░███ ░███░░███░███     ░███    ░███      ░███ ░███       
    ░███ ░░██████ ░███    █████░███      ░███ ░███ ░░██████     ░███    ░███      ░███ ░███       
    ░███  ░░█████ ░░███  ░░███ ░░███     ███  ░███  ░░█████     ░███    ░░███     ███  ░███      █
    █████  ░░█████ ░░█████████  ░░░███████░   █████  ░░█████    █████    ░░░███████░   ███████████
    ░░░░░    ░░░░░   ░░░░░░░░░     ░░░░░░░    ░░░░░    ░░░░░    ░░░░░       ░░░░░░░    ░░░░░░░░░░░ 

                                [NGONTOL SENDER - NGONTOL DEV 2021]
    ▸ [1] NEXMO SENDER
    ▸ [2] PLIVO SENDER

EOF
printf "    Option : "
read options_choose
if [[ $options_choose =~ "1" ]]; then
options_nexmo
elif [[ $options_choose =~ "2" ]]; then
options_plivo
else
printf "${red} WRONG INPUT ?\n"
exit
fi

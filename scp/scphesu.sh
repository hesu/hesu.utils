#!/bin/bash

scphesu()
{
  local fname=$1

  # get history
  h_dport=''
  h_did=''
  h_dip=''
  h_dpath=''
  
  ls ~/.utils/scphesu/history > /dev/null
  if [ $? -eq 0 ]; then
    local lastcmd=$(tail -n1 ~/.utils/scphesu/history)

    local pattern='-P([0-9]+) (.*) (.*)@(.*):(.*)'

    if [[ $lastcmd =~ $pattern ]]; then
#      echo "1="${BASH_REMATCH[1]}
#      echo "2="${BASH_REMATCH[2]}
#      echo "3="${BASH_REMATCH[3]}
#      echo "4="${BASH_REMATCH[4]}
#      echo "5="${BASH_REMATCH[5]}

      h_dport="${BASH_REMATCH[1]}"
      h_did="${BASH_REMATCH[3]}"
      h_dip="${BASH_REMATCH[4]}"
      h_dpath="${BASH_REMATCH[5]}"
    fi
  fi


    echo "Sending command : scp -P$h_dport $fname $h_did@$h_dip:$h_dpath"
    echo ""

    echo "[R]un or [Q]uit or [E]dit:"
    local tty_state=$(stty -g)
    stty raw
    local char=$(dd bs=1 count=1 2> /dev/null)
    stty "$tty_state"

    case "$char" in
      [rR])
      echo "yepp. try to send.."
      scp -P$h_dport $fname $h_did@$h_dip:$h_dpath
  
      if [ $? -eq 0 ]; then
      ## log scp history
      ### mkdir if not exist
      ls ~/.utils/scphesu/ > /dev/null
      if [ $? -ne 0 ]; then 
        mkdir -p ~/.utils/scphesu
      fi
      ### append log
      echo "scp -P907 $fname hesu@hesu:$dpath" >> ~/.utils/scphesu/history
      echo "Done."
      else
       echo "Failed."
      fi
      return
      ;;
    [eE])
      ### append log
      echo "input example=scp -P907 $fname hesu@hesu:$dpath"
      input=""
      echo -n "input:"
      read input
      ## log scp history
      ### mkdir if not exist
      ### append log
      if [ "$input" == "" ]; then
        echo "do nothing. bye."
      else
        ls ~/.utils/scphesu/ > /dev/null
        if [ $? -ne 0 ]; then 
          mkdir -p ~/.utils/scphesu
        fi
        echo "$input" >> ~/.utils/scphesu/history
        echo $input
        echo "edited. bye."
      fi
      return
      ;;
    [qQ])
      echo "bye."
      return
      ;;
    esac

  return
}


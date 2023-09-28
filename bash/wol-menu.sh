#!/bin/bash

#Device MACs
archive=24:5e:be:47:90:a6
mainframe=00:e0:4c:af:00:0d
div1=2c:f0:5d:40:3e:88
dugi=2c:f0:5d:40:3e:88


# submenu
submenu () {
  local PS3='Select the device to shutdown: '
  local options=("archive" "mainframe" "quit")
  local opt
  select opt in "${options[@]}"
  do
      case $opt in
          "archive")
            sshpass -p dada1 ssh root@archive 'shutdown -h now';
            echo "archive shutting down..."
              ;;
          "mainframe")
            sshpass -p dada1 ssh root@mainframe 'shutdown -h now';
            echo "mainframe shutting down..."
              ;;
          "quit")
              return
              ;;
          *) echo "Invalid option $REPLY";;
      esac
  done
}


PS3="Select the device to wake: "

select opt in archive mainframe div1 shutdown quit; do

 case $opt in
    archive)
    wol 24:5e:be:47:90:a6
      ;;
    mainframe)
    wol 00:e0:4c:af:00:0d
      ;;
    div1)
    wol 2c:f0:5d:40:3e:88
      ;;
    shutdown)
    submenu
      ;;
    quit)
      break
      ;;
    *) 
      echo "Invalid option $REPLY"
      ;;
esac
done



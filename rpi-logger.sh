<< --MULTIword-COMMENT--
RPI Logger v2.0

Program purpose: Bash script for automatic logging into RPI with SSH.

Requirements: 
Before first use make sure to have nmap, ssh, sshpass and net-tools installed .
For proper operation You MUST provide some data about your RPI.

Program execution steps:
  - check IP address of your computer (255.255.255.0 mask is assumed)
  - get network address from previously obtained IP address
  - scan network for a host with hostname given by the user
  - get IP address of RPI 
  - connect to RPI with sshpass over SSH

MIT License

Copyright (c) 2019 Krzysztof Stężała

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

--MULTIword-COMMENT--

#!/bin/bash

## Variables set by user
RPI_HOSTNAME="x"    # raspberry pi hostname, for Raspbian default is "raspberry", for Ubuntu is "ubuntu"
RPI_USER="x"        # user name on rpi, for Raspian default is "pi", for Ubuntu is "ubuntu"
RPI_PASSWORD="x"    # password for user account above, for Raspbian default is "raspberry", for Ubuntu is "ubuntu"
INTERFACE_NAME="x"  # name of the network interface i.e. eth0, wlan0, wlp2s0, ..., no default - have to check it yourself :(

PATH_TO_DATA="/usr/local/bin/.config.txt"

COUNTER=0
IFS=$'\n'
while read -r value
do
    if [ "$COUNTER" -eq "0" ];
        then
            RPI_PASSWORD=$value   
            echo "This is password: $RPI_PASSWORD $COUNTER"                
    elif [ "$COUNTER" -eq "1" ];
        then        
            RPI_USER=$value
            echo "This is username: $RPI_USER $COUNTER"
    elif [ "$COUNTER" -eq "2" ];
        then
            RPI_HOSTNAME=$value       
            echo "This is hostname: $RPI_HOSTNAME $COUNTER"
    elif [ "$COUNTER" -eq "3" ];
        then        
            INTERFACE_NAME=$value
            echo "This is interface: $INTERFACE_NAME $COUNTER" 
    fi
    ((COUNTER=COUNTER+1))
    
done < "$PATH_TO_DATA"

echo "checking ip for $INTERFACE_NAME"
#echo ifconfig $INTERFACE_NAME

# Checking IP address with ifconfig tool (from net-tools package)
IP_ADDRESS=$( 
            echo $(\
                    ifconfig $INTERFACE_NAME | \
                    grep \
                        --extended-regexp \
                        --ignore-case \
                        --only-matching \
                        '\b[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\b'\
                ) | \
            # cutting all matching fields to only relevant one
            cut -d' ' -f1 \
        )

#echo "This is interface $INTERFACE_NAME" 


# Extracting network address
NETWORK_ADDRESS=$(
            echo $IP_ADDRESS | \
            grep \
                --extended-regexp \
                --ignore-case \
                --only-matching \
                '\b[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\b'\
        )


RPI_NMAP=""
RPI_ADDRESS=""

# Scaning network for raspberry pi host
if RPI_NMAP=$(nmap -sn $NETWORK_ADDRESS.0/24 | grep $RPI_HOSTNAME); then
    # Extract ip address of RPI
    RPI_ADDRESS=$(  
                echo $RPI_NMAP | \
                grep \
                    --extended-regexp \
                    --ignore-case \
                    --only-matching \
                    '\b[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\b'\
            )

    # Connect to RPI
    sshpass -p $RPI_PASSWORD ssh -o StrictHostKeyChecking=no $RPI_USER@$RPI_ADDRESS
else
    # RPI not found
    echo "RPI with hostname '$RPI_HOSTNAME' was not found in your network ($NETWORK_ADDRESS.0/24)."
    echo "Make sure RPI is connect to your network and if credentials, defined in this script, are correct."
fi


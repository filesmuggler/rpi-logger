<< --MULTILINE-COMMENT--
RPI Logger Installer

Program purpose: Install RPI logger on your desktop.

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

--MULTILINE-COMMENT--

#!/bin/bash
echo "RPI Logger Installer."
echo "Copyright by Krzysztof Stężała 2019."
echo "---"

# check interface connected to the internet
INTERFACE_ARRAY=()
COUNTER=1
echo "You are connected to:"
for i in $(route | grep '^default' | grep -o '[^ ]*$')
do
    echo "[$COUNTER] $i"
    INTERFACE_ARRAY=("${INTERFACE_ARRAY[@]}" "$i")
    ((COUNTER=COUNTER+1))
done
echo "Choose which interface use. \
Mind that it should be the one with RPI connected."
read USER_CHOICE
INTERFACE_NAME=${INTERFACE_ARRAY[((USER_CHOICE=USER_CHOICE-1))]}
echo "You have chosen $INTERFACE_NAME"
echo ""
echo "Enter RPI hostname, username and password."
echo "Hostname:"
read RPI_HOSTNAME
echo "Username:"
read RPI_USERNAME
echo "Password:"
read RPI_PASSWORD

chmod +x rpi-logger.sh

rm .config.txt
touch .config.txt

chmod +x .config.txt

echo $RPI_PASSWORD >> .config.txt
echo $RPI_USERNAME >> .config.txt
echo $RPI_HOSTNAME >> .config.txt
echo $INTERFACE_NAME >> .config.txt

sudo cp -p rpi-logger.sh /usr/local/bin
sudo cp -p .config.txt /usr/local/bin

echo "Run ./rpi-logger.sh"


# ask for username, password, hostname of RPI
# create .rpi-config.txt with unencrypted data
#
# copy the .rpi-config.txt and rpi-logger.sh to /usr/local/bin/
# make rpi-logger.sh globally executable

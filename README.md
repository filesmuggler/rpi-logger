# RPI Logger
Script for automatic logging into RPI with SSH

## Requirements 
Before first use make sure to have nmap, ssh, sshpass and net-tools installed 
For proper operation You MUST provide some data about your RPI

## Algorithm
Progam execution steps:
  - check IP address of your computer (255.255.255.0 mask is assumed)
  - get network address from previously obtained IP address
  - scan network for a host with hostname given by the user
  - get IP address of RPI 
  - connect to RPI with sshpass over SSH

## Setup

1. Download repo
2. Make sure all tools are installed
3. Edit raspberry pi hostname, username, password and your network interface variables in the script
4. Run command 
'''
chmod +x rpi-logger.sh
'''
5. Run
'''
./rpi-logger.sh
'''

## Known issues

- The script is limited to networks with mask 255.255.255.0

## Screenshots

![RPI Logger Execution](http://www.github.com/filesmuggler/rpi-logger/screenshots/rpi-logger.png)

## Authors

* **Krzysztof Stężała** - *Initial work* - [Filesmuggler](https://github.com/filesmuggler)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to StackOverflow
* Stay hungry. Stay foolish.


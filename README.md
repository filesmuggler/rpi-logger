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

## Known issues

## Screenshots

## Authors

* **Krzysztof Stężała** - *Initial work* - [Filesmuggler](https://github.com/filesmuggler)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to StackOverflow
* Stay hungry. Stay foolish.


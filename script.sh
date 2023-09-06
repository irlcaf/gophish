#!/bin/bash
## Updatng the system
sudo apt update && sudo apt upgrade -y
sudo apt install unzip -y
#Changing directory to opt.
cd /opt

#Downloading latest gophish release. 
#Official release webpage at https://github.com/gophish/gophish/releases/
sudo wget https://github.com/gophish/gophish/releases/download/v0.12.1/gophish-v0.12.1-linux-64bit.zip

#Unzip the download
sudo unzip gophish-v0.12.1-linux-64bit.zip

#Add loopback configuration to config.json
sudo sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' config.json

#Assigning executable permissions and executing binary
sudo chmod +x ./gophish 
sudo ./gophish &

#Updating password file, when accessing using the default password it will ask for a password reset. Input your password through gophish authentication dashboard.
sudo apt install -y sqlite || sudo apt-get install -y sqlite3 libsqlite3-dev
sudo sqlite3 gophish.db 'update users set hash="$2a$10$IYkPp0.QsM81lYYPrQx6W.U6oQGw7wMpozrKhKAHUBVL4mkm/EvAS" where username="admin";'
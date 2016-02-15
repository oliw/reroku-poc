# README

## What is it?
This is a proof-of-concept project demonstrating a distilled implementation of a mini-Heroku running on a Raspberry Pi 2. It is *heavily* inspired by the great [Dokku](https://github.com/dokku/dokku) project.

Dokku does not run on the Pi because Dokku is built for a specific OS and processor architecture (Ubuntu 14 and x86). Reroku is designed to work with Raspbian and ARM.


## Installation

### Requirements

- Raspberry PI 2 running [Hypriot's OS w.Docker](http://blog.hypriot.com/getting-started-with-docker-and-mac-on-the-raspberry-pi/)

- Nginx

```
sudo apt-get update && apt-get install nginx
```

- SSHCommand

```
git clone https://github.com/oliw/sshcommand.git
git checkout oliverw/raspbian-support
cd sshcommand
sudo make install
```

### Install

```
sudo make install
sudo sshcommand create reroku `which reroku`
sudo usermod -aG docker reroku
```


### Uninstall
```
sudo make uninstall
```

## Usage
To allow your computer to deploy to reroku, you must first share your [public key](https://help.github.com/articles/generating-an-ssh-key/) with reroku

```
cat ~/.ssh/id_rsa.pub | ssh root@192.168.0.12 -- sudo sshcommand acl-add reroku <KEY>
```
Where `<KEY>` is the key associated with your public key in `id_rsa.pub` (usually an email address)


To deploy your APP to reroku:

```
cd <APP>
git remote add reroku reroku@<REROKU_URL>:<APP>
git push reroku master
open http://<APP>.<REROKU_URL>
```
The default `REROKU_URL` is `raspberrypi`. If your network's DNS does not have a record in place, a quick hack is to edit the /etc/hosts file on the computer trying to access reroku.

```
<RASPBERRY_PI_IP_ADDRESS> raspberrypi <APP>.raspberrypi
```

## Caveats

- Only python projects are currently supported
- Your python project should serve `0.0.0.0:80`
- Your project must include a Heroku-style Procfile with a web definition

## Future Features

- Environment Variables
- Logs
- App Management
- DNS
- Addons (e.g. Database)
- Other base images e.g. (java, ruby)
- Non-web dynos

## Contacts

- Feel free to file issues on this project's Github page though not this project is not actively worked on.
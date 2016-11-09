Silk-Seeder
==============

Silk-Seeder is a crawler for the Silk network, which exposes a list
of reliable nodes via a built-in DNS server.

Features:
* regularly revisits known nodes to check their availability
* bans nodes after enough failures, or bad behaviour
* accepts nodes down to v1.0.0.0 to request new IP addresses from,
  but only reports good post-v1.0.0.0 nodes.
* keeps statistics over (exponential) windows of 2 hours, 8 hours,
  1 day and 1 week, to base decisions on.
* very low memory (a few tens of megabytes) and cpu requirements.
* crawlers run in parallel (by default 24 threads simultaneously).

REQUIREMENTS
------------

$ sudo apt-get install build-essential libboost-all-dev libssl-dev php5-cli php5-curl

**Let's get started**

 1. Get your CF API Key (My Settings -> Account -> API Key -> View API Key)
 2. Download and start bitcoin-seeder

    git clone https://github.com/transfer-dev/bitcoin-seeder
    cd bitcoin-seeder
    make
    chmod +x dnsseed start
    ./dnsseed
    or 
    screen -S dnsseed /path/to/dnsseed
    to have a screen session, detach the screen session with CTRL+A+D

 3. Edit cf-php/cf.php file
    open cf.php in an editor of your choice
    and fill in 

    $domain ="domain.com";
    $name = "name"; //subdomain e.g. name.domain.com 
    $number_of_records = 10; //maximum n A records with $name... 
    $user = "emailofcloudflareaccount"; //user name
    $key = "yourapikey"; //key for cloudflare api found in account settings
    $seed_dump = "/path/to/dnsseed.dump"; //absolute path to dnsseed.dump in the bitcoin-seeder root directory 
    
accordingly. (The number_of_records in the table displayed above is "10" and I think that's a good number.)
4. Have a cronjob run cf-php regularly

    crontab -e
    1,7,14,20,25,33,37,43,49,55 * * * * cd /path/to/Silk-Seeder/cf-php && php cf.php



# How to use it?

## Install Docker Compose
Install Docker and Docker Compose
Install Docker without root
On Ubuntu
* Basic Docker Setup - https://docs.docker.com/engine/install/ubuntu/
* Post Installation Steps - https://docs.docker.com/engine/install/linux-postinstall/
## Checkout maldeps Repo and Try it
```bash
## Checkout the code 
git clone git@github.com:jchauhan/maldeps.git

## Start the docker instances
docker compose up -d

## Check if dockers are running. There should be 4 instances, pypicloud, redis, play and victim
docker compose ps 
```

## Exec to play instance for fun and profit

```bash
docker compose exec play bash
>> exit
```




## Open Pypi private repo

```
In a browser, open the link http:localhost:8080/, provide username: admin, password: admin

You will notice empty packages list right now
```

	

## Structure of maldeps
```bash
## Structure of maldeps repo
>> ls 
others <- add your own libraries here
samples <- samples of malicious packages, password protected

## Add any other library in others, similar to lxml
```

## Structure of Maldeps play instance important dirs
```bash
docker compose up -d --build play
>> ls /app/malcious 
others
samples  

>> ls /tmp/malicious/pypi/
1000+ samples of malicious packages, not protected from password, ready to use
```

## Build lxml library and publish to Pypicloud

```bash
## Exec to play instance for fun and profit


docker compose exec play bash
>> cd malicious/others/lxml/ 
>> python setup.py bdist_wheel upload -r pypicloud


Login to pypicloud on http://localhost:8080 in your browser
```

## Publish existing Malicious Packages to Pypicloud
```bash
## Exec to play instance for fun and profit

docker compose exec play bash
>> twine upload --repository-url http://pypicloud:8080/simple /tmp/malicious/pypi/2022-11-08-newurllib.zip


Login to pypicloud on http://localhost:8080 in your browser and search for the package
```

## Sample Malicious Libraries 

* /tmp/malicious/pypi/2023-03-16-sylexnaranjoo-v1.0.2.zip

```bash
mkdir /tmp/analysis
cd /tmp/analysis/
unzip /tmp/malicious/pypi/2023-03-16-sylexnaranjoo-v1.0.2.zip 
cd tmp/tmp.7324z1ul5P/2023-03-16-sylexnaranjoo-v1.0.2/sylexnaranjoo-1.0.2/
vim setup.py 

## notice the PostInstallationCommand

```


## Update maldeps for own your research

```bash
## Structure of maldeps repo
>> ls 
others <- add your own libraries here
samples <- samples of malicious packages, password protected

## Add any other library in others, similar to lxml

## Rebuild play instance

docker compose up -d --build play
```


Credit to https://github.com/DataDog/guarddog for Malicious Package Dataset


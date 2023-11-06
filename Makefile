# Define variables
CONTAINER_NAME_DAM = atrodam_dam
CONTAINER_NAME_CRM = espocrm_crm
CONTAINER_NAME_PIM = atropim_pim

# Targets
.PHONY: build run setup-composer setup-project run-services clean

crm: install-crm
dam: build-docker-dam run-dam preinstall-dam setup-composer-dam setup-project-dam run-services-dam add-cron-dam
pim: build-docker-pim run-pim preinstall-pim setup-composer-pim setup-project-pim run-services-pim add-cron-pim

install-crm:
	sudo rm -rf ./crm/app/*
	sudo mkdir -p ./crm/app && sudo chmod 0777 -R ./crm/app && cp ./crm/install.sh ./crm/app/
	sudo bash ./crm/app/install.sh --clean

build-docker-dam:
	docker-compose -f docker-compose-dam.yml down
	docker-compose -f docker-compose-dam.yml build

run-dam:
	docker-compose -f docker-compose-dam.yml up -d

install-dam:
	sudo rm -rf ./dam/app/*
	sudo mkdir -p ./dam/app && sudo chmod 0777 -R ./dam/app && cp ./dam/install.sh ./dam/app/
	sudo bash ./dam/app/install.sh --clean

run-services-dam:
	docker-compose -f docker-compose-dam.yml exec $(CONTAINER_NAME_DAM) bash -c "service php7.4-fpm start"
	docker-compose -f docker-compose-dam.yml exec $(CONTAINER_NAME_DAM) bash -c "service nginx start"
	docker-compose -f docker-compose-dam.yml exec $(CONTAINER_NAME_DAM) bash -c "chown -R www-data:www-data /var/www/html"

preinstall-dam:
	sudo apt-get install git
	sudo rm -rf ./dam/app && sudo mkdir ./dam/app && sudo chmod 0777 -R ./dam/app
	git clone https://github.com/atrocore/skeleton-dam-no-demo.git ./dam/app

setup-project-dam: run-dam
	docker-compose -f docker-compose-dam.yml exec $(CONTAINER_NAME_DAM) bash -c "cd /var/www/html/app && php composer.phar self-update && php composer.phar update"

setup-composer-dam: run-pim
	docker-compose -f docker-compose-dam.yml exec $(CONTAINER_NAME_DAM) bash -c "cd /tmp && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer"

add-cron-dam:
	docker-compose -f docker-compose-dam.yml exec $(CONTAINER_NAME_DAM) bash -c "echo '* * * * * /usr/bin/php /var/www/html/app/index.php cron' | crontab -"

build-docker-pim:
	docker-compose -f docker-compose-pim.yml down
	docker-compose -f docker-compose-pim.yml build

run-pim:
	docker-compose -f docker-compose-pim.yml up -d

run-services-pim:
	docker-compose -f docker-compose-pim.yml exec $(CONTAINER_NAME_PIM) bash -c "service php7.4-fpm start"
	docker-compose -f docker-compose-pim.yml exec $(CONTAINER_NAME_PIM) bash -c "service nginx start"
	docker-compose -f docker-compose-pim.yml exec $(CONTAINER_NAME_PIM) bash -c "chown -R www-data:www-data /var/www/html"

preinstall-pim:
	sudo apt-get install git
	sudo rm -rf ./pim/app && sudo mkdir ./pim/app && sudo chmod 0777 -R ./pim/app
	git clone https://github.com/atrocore/skeleton-pim-no-demo.git ./pim/app

setup-project-pim: run-pim
	docker-compose -f docker-compose-pim.yml exec $(CONTAINER_NAME_PIM) bash -c "cd /var/www/html/app && php composer.phar self-update && php composer.phar update"

# Install Composer
setup-composer-pim: run-pim
	docker-compose -f docker-compose-pim.yml exec $(CONTAINER_NAME_PIM) bash -c "cd /tmp && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer"

add-cron-pim:
	docker-compose -f docker-compose-pim.yml exec $(CONTAINER_NAME_PIM) bash -c "echo '* * * * * /usr/bin/php /var/www/html/app/index.php cron' | crontab -"


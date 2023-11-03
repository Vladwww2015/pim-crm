# Define variables
CONTAINER_NAME_CRM = espocrm_crm
CONTAINER_NAME_PIM = atropim_pim

# Targets
.PHONY: build run setup-composer setup-project run-services clean

crm: install-crm
pim: build-docker run preinstall-pim setup-composer-pim setup-project-pim run-services-pim

# Build the Docker image
build-docker:
	docker-compose down
	docker-compose build

run:
	docker-compose up -d

install-crm:
	sudo rm -rf ./crm/app/*
	sudo mkdir -p ./crm/app/installation && sudo chmod 0777 -R ./crm/app && cp ./crm/install.sh ./crm/app/installation/
	cd ./crm/app/installation/ && sudo bash ./crm/app/installation/install.sh --clean

run-services-pim:
	docker-compose exec $(CONTAINER_NAME_PIM) bash -c "service php7.4-fpm start"
	docker-compose exec $(CONTAINER_NAME_PIM) bash -c "service nginx start"
	docker-compose exec $(CONTAINER_NAME_PIM) bash -c "chown -R www-data:www-data /var/www/html"

preinstall-pim:
	sudo apt-get install git
	sudo rm -rf ./pim/app && sudo mkdir ./pim/app && sudo chmod 0777 -R ./pim/app
	git clone https://github.com/atrocore/skeleton-pim-no-demo.git ./pim/app

setup-project-pim: run
	docker-compose exec $(CONTAINER_NAME_PIM) bash -c "cd /var/www/html/app && php composer.phar self-update && php composer.phar update"

# Install Composer
setup-composer-pim: run
	docker-compose exec $(CONTAINER_NAME_PIM) bash -c "cd /tmp && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer"

add-cron-pim:
	docker-compose exec $(CONTAINER_NAME_PIM) bash -c "echo '* * * * * /usr/bin/php /var/www/html/app/index.php cron' | crontab -"


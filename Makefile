PROJECT_HOME=./target
BACKUP_DIR=${PROJECT_HOME}/backups
DATE=`date +"%Y%m%d"`

mica_home=${PROJECT_HOME}/mica_home
opal_home=${PROJECT_HOME}/opal_home
agate_home=${PROJECT_HOME}/agate_home

docker_compose_file=docker-compose.yml
network=canpath_default

MICA_SERVE=~/projects/mica2/mica-webapp/target/classes

help:
	@echo "make up"

template:
	cp -r mica_home/conf/* ${MICA_SERVE} && \
	cp -r static ${MICA_SERVE}	

install: install-mica install-agate

install-mica:
	mkdir -p $(mica_home)/conf/static
	cp -r static/* $(mica_home)/conf/static
	rm -rf $(mica_home)/conf/static/assets/css/agate-*
	cp -r mica_home/conf/* $(mica_home)/conf

install-agate:
	mkdir -p $(agate_home)/conf/static
	cp -r static/* $(agate_home)/conf/static
	rm -rf $(agate_home)/conf/static/assets/files
	rm -rf $(agate_home)/conf/static/assets/css/mica-*
	cp -r agate_home/conf/* $(agate_home)/conf

theme:
	rm -rf static/assets/theme
	mkdir -p static/assets/theme/plugins
	cp -r ../AdminLTE/dist static/assets/theme
	cp -r ../AdminLTE/plugins/bootstrap static/assets/theme/plugins/
	cp -r ../AdminLTE/plugins/chart.js/ static/assets/theme/plugins/
	cp -r ../AdminLTE/plugins/datatables static/assets/theme/plugins/
	cp -r ../AdminLTE/plugins/datatables-select static/assets/theme/plugins/
	cp -r ../AdminLTE/plugins/datatables-bs4/ static/assets/theme/plugins/
	cp -r ../AdminLTE/plugins/fontawesome-free/ static/assets/theme/plugins/
	cp -r ../AdminLTE/plugins/jquery static/assets/theme/plugins/
	cp -r ../AdminLTE/plugins/moment static/assets/theme/plugins/
	cp -r ../AdminLTE/plugins/select2 static/assets/theme/plugins/
	cp -r ../AdminLTE/plugins/select2-bootstrap4-theme static/assets/theme/plugins/
	cp -r ../AdminLTE/plugins/toastr static/assets/theme/plugins/

up:
	docker-compose -f $(docker_compose_file) up -d --remove-orphans

down:
	docker-compose -f $(docker_compose_file) down

stop:
	docker-compose -f $(docker_compose_file) stop

start:
	docker-compose -f $(docker_compose_file) start

restart:
	docker-compose -f $(docker_compose_file) restart

pull:
	docker-compose -f $(docker_compose_file) pull

logs:
	docker-compose -f $(docker_compose_file) logs -f

build:
	docker-compose -f $(docker_compose_file) build --no-cache

reset-taxo:
	mica rest -u $(username) -p $(password) -mk http://localhost:8082 -m DELETE /config/$(target)/taxonomy
	mica rest -u $(username) -p $(password) -mk http://localhost:8082 -m PUT /taxonomies/_index

backups: agate-backup mica-backup opal-backup mongo-backup

prepare-backup:
	rm -rf ${BACKUP_DIR}/${DATE}
	mkdir -p ${BACKUP_DIR}/${DATE}

agate-backup: prepare-backup
	mkdir -p ${BACKUP_DIR}/${DATE}/agate_home
	cp -r $(agate_home)/conf ${BACKUP_DIR}/${DATE}/agate_home/conf
	cp -r $(agate_home)/data ${BACKUP_DIR}/${DATE}/agate_home/data

mica-backup: prepare-backup
	mkdir -p ${BACKUP_DIR}/${DATE}/mica_home
	cp -r $(mica_home)/conf ${BACKUP_DIR}/${DATE}/mica_home/conf
	cp -r $(mica_home)/data ${BACKUP_DIR}/${DATE}/mica_home/data
	cp -r $(mica_home)/plugins ${BACKUP_DIR}/${DATE}/mica_home/plugins

opal-backup: prepare-backup
	mkdir -p ${BACKUP_DIR}/${DATE}/opal_home
	cp -r $(opal_home)/conf ${BACKUP_DIR}/${DATE}/opal_home/conf
	cp -r $(opal_home)/data ${BACKUP_DIR}/${DATE}/opal_home/data
	cp -r $(opal_home)/plugins ${BACKUP_DIR}/${DATE}/opal_home/plugins

mongo-backup: prepare-backup
	rm -rf /tmp/mongodump && \
	docker run -it --rm --network $(network) -v /tmp/mongodump:/tmp/dump mongo:4.2 bash -c 'mongodump -v --host mongo:27017 --out=/tmp/dump' && \
	mv /tmp/mongodump ${BACKUP_DIR}/${DATE}/mongo

restore: agate-restore mica-restore opal-restore mongo-restore

agate-restore:
	cp -r $(backup)/agate_home $(agate_home)

mica-restore:
	cp -r $(backup)/mica_home $(mica_home)

opal-restore:
	cp -r $(backup)/opal_home $(opal_home)

mongo-restore:
	docker run -it --rm --network $(network) -v $(backup)/mongo:/tmp/dump mongo bash -c 'mongorestore -v --host mongo:27017 /tmp/dump'

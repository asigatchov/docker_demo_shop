# docker_demo_shop

Статья оп запуска приложения с описанием http://сигачев.рф/posts/81

Для работы установите docker(https://docs.docker.com/engine/installation/linux/ubuntulinux/)  и docker-compose (https://docs.docker.com/compose/install/)

Клонируем репозитарий git clone https://github.com/asigatchov/docker_demo_shop.git /home/docker_demo_shop


Инициализируем и наполним базу товаров
docker-compose run shop.service.dev rake db:create db:migrate update_db_shop:import 


docker-compose run sphinx sh -c 'sleep 10 && indexer --all'

Запускам сервис 
docker-compose up 

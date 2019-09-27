docker-compose up -d
docker-compose exec web rails db:create
docker-compose exec web rails db:migrate
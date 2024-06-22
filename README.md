# Deployment

docker compose up -d web

docker compose up -d --force-recreate --build web

docker compose exec web sh
RAILS_ENV=production bundle exec rails db:migrate
cp -r ./public/* ./public_ext/


# Deployment

docker compose up -d web

docker compose up -d --force-recreate --build web

docker compose exec web sh
cp -r ./public/* ./public_ext/


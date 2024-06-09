FROM ruby:3.2.0-alpine
# Установка часового пояса
RUN apk add --update tzdata && \
    cp /usr/share/zoneinfo/Europe/London /etc/localtime && \
    echo "Europe/London" > /etc/timezone

# Установка в контейнер runtime-зависимостей приложения
RUN apk add --update --virtual runtime-deps nodejs libffi-dev readline sqlite xz-libs

# Соберем все во временной директории
WORKDIR /tmp
ADD Gemfile* ./

RUN apk add --virtual build-deps build-base openssl-dev libc-dev linux-headers libxml2-dev libxslt-dev readline-dev && \
    bundle install --jobs=2 && \
    apk del build-deps

# Копирование кода приложения в контейнер
ENV APP_HOME /srv/projects/holy-sink
COPY . $APP_HOME
WORKDIR $APP_HOME

RUN bundle exec rails assets:precompile

# Настройка переменных окружения для production
ENV PORT 3000
ENV RAILS_ENV=production \
    RACK_ENV=production

RUN mkdir -p ./tmp/pids
# Проброс порта 3000
EXPOSE 3000

# CMD ["sleep", "3600"]
# Запуск по умолчанию сервера puma
# CMD ["ls", "-la", "./tmp"]

CMD ["cp", "-r", "./public/*", "./public_ext/"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

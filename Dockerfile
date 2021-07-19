FROM ruby:2.7.0-alpine

RUN apk add --update --no-cache bash build-base tzdata sqlite-dev

WORKDIR /opt/app/

COPY Gemfile* /opt/app/

RUN bundle install

COPY . /opt/app/

ENV PATH=./bin:$PATH

RUN chmod +x ./entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["sh", "./entrypoint.sh"]

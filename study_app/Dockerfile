FROM elixir:1.9-slim

ENV MIX_ENV ${MIX_ENV:-dev}

RUN set -ex \
  && apt-get update \
  && apt-get install -y curl gnupg \
  && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install -y nodejs default-libmysqlclient-dev build-essential inotify-tools git \
  && npm install npm@latest -g

RUN mix local.hex --force \
  && mix local.rebar --force \
  && mix archive.install hex phx_new 1.4.9 --force

WORKDIR /app

COPY . /app/

RUN set -ex \
  && mix deps.get \
  && mix compile

# TODO: npm build
# WORKDIR /app/assets
# RUN npm install \
#   && npm run deploy

# WORKDIR /app

CMD ["mix", "phx.server"]

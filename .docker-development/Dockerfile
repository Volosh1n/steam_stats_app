ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-slim-buster

ARG PG_MAJOR
ARG BUNDLER_VERSION

RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    curl \
    less \
    git \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

# Needed for nodejs instalation
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo 'deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list

COPY ./Aptfile /tmp/Aptfile

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    cmake \
    pkg-config \
    libpq-dev \
    postgresql-client-$PG_MAJOR \
    $(cat /tmp/Aptfile | xargs) && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    truncate -s 0 /var/log/*log
RUN npm install -g yarn@1.22.4

# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

RUN gem update --system && \
    gem install bundler:$BUNDLER_VERSION

ENV APP_USER steam_stats_app
ENV APP_USER_HOME /home/$APP_USER
RUN useradd -m -d $APP_USER_HOME $APP_USER

USER $APP_USER

COPY ./.bashrc ./.irbrc ./.pryrc $APP_USER_HOME/
COPY ./.irb-history $APP_USER_HOME/app/log/

WORKDIR $APP_USER_HOME/app

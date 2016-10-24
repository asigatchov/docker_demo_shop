FROM phusion/passenger-ruby22
RUN apt-get update \
  && apt-get install  -y \
  build-essential \
  nodejs libxml2 \
  && apt-get upgrade -y -o Dpkg::Options::="--force-confold" \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && gem update bundler \
  && gem cleanup \
  && locale-gen ru_RU \
  && locale-gen ru_RU.UTF-8 \
  && localedef  -i ru_RU -f UTF-8 ru_RU.UTF-8

ENV LANG ru_RU.utf8

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5
COPY . ./
RUN rm -rf /app/public/assets/* && rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]


FROM ruby:2.5.1

ENV BUNDLER_VERSION=2.1.4

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for a JS runtime
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -qq -y build-essential nodejs yarn 
# for rmagick
RUN apt-get install -y imagemagick libmagickcore-dev libmagickwand-dev   

RUN gem install bundler -v 2.1.4

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle check || bundle install 

COPY package.json yarn.lock ./

RUN yarn install --check-files

COPY . ./ 

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
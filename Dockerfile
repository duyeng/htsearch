# Dockerfile.rails
FROM ruby:3.1.2 AS rails-toolbox

# Default directory
ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

# Install gems
WORKDIR $INSTALL_PATH
COPY . .
RUN gem install rails bundler
RUN bundle install

# Start server
CMD bundle exec unicorn -c config/unicorn.rb

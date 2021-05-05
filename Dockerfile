FROM ruby:2.7.2

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \        
                       nodejs \
                    #    sudo \
                    #    nginx && \
                    #    gem install bundler:2.0.1 \
   && rm -rf /var/lib/apt/lists/* 

# RUN mkdir -p tmp/sockets
# RUN groupadd nginx
# RUN useradd -g nginx nginx
# ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD . /app
RUN bundle install

EXPOSE 80

RUN chmod +x /app/entrypoint.sh

CMD ["/app/entrypoint.sh"]

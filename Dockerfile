FROM registry.gitlab.com/notch8/trinity-college-dublin/base:latest

ADD http://timejson.herokuapp.com build-time

COPY ops/webapp-ssl.conf /etc/nginx/sites-available/webapp-ssl.conf
COPY ops/webapp.conf /etc/nginx/sites-enabled/webapp.conf
COPY ops/env.conf /etc/nginx/main.d/env.conf

COPY  --chown=app . $APP_HOME

RUN /sbin/setuser app bash -l -c "set -x && \
    (bundle check || bundle install) && \
    bundle exec rake assets:precompile DB_ADAPTER=nulldb && \
    mv public/assets public/assets-new"

CMD ["/sbin/my_init"]

## Notes on docker setup
```bash
cp .env.example .env
dory up
sc up
sc be rails db:migrate db:seed
```

### Getting tests set up
```bash
sc sh -s mysql

mysql -p$MYSQL_ROOT_PASSWORD -e "create database test_hyrax; grant all privileges on *.* to 'hyrax'@'%'"
exit

sc be rake db:test:prepare
```

See https://docs.google.com/document/d/13Uq5pOQoH6RUahogYqDHIOyIVK8FcfLPNRxaKyN3lDY/edit?usp=sharing

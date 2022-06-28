# AWS Elasticbeansstalk PHP Symfony Example

This repository should help others how to deploy your Symfony application to AWS Elasticbeansstalk PHP instances.

## Requires

 - Elasticbeanstalk instance
 - DB Instance
 - Configured ENV Variables (configured via AWS UI)
   - `APP_ENV`
   - `DATABASE_URL`
   - `MESSENGER_TRANSPORT_DSN` (if messenger is used)
   - `MAILER_DSN` (if mailer is used)
 - Gitlab ENV Variables (if gitlab is used for deployment, configured via Gitlab UI)
    - `AWS_ACCESS_KEY_ID`
    - `AWS_SECRET_ACCESS_KEY`

## Features

 - composer optimization ([.ebextensions/composer.config](.ebextensions/composer.config))
 - cronjob configuration ([.ebextensions/cron-linux.config](.ebextensions/cron-linux.config))
 - doctrine migration configuration ([.ebextensions/migration.config](.ebextensions/migration.config))
 - php configuration ([.ebextensions/php.config](.ebextensions/php.config))
   - redis extension included 
 - publicdir configuration ([.ebextensions/php.config](.ebextensions/publicdir.config))
 - nginx vhost ([.ebextensions/php.config](.platform/nginx/conf.d/elasticbeanstalk/php.conf))
 - gitlab deployment ([.gitlab-ci.yml](.gitlab-ci.yml) / [.gitlab/create_aws_config.sh](.gitlab/create_aws_config.sh))

## Feedback welcome

You did struggle with something let me know. So we can here add more faqs to help others avoiding same problems.

## FAQ

### Deploy locally

You can deploy when you have eb installed (MacOS `brew install awsebcli`) via:

```bash
eb init "Your Application Name" --platform "PHP 8.0 running on 64bit Amazon Linux 2" --region=eu-central-1 --profile=eb-cli
eb deploy
```

### Debug Deploy errors

You can use following command to debug deploy errors:

```bash
eb logs
```

The full logs you can download via the AWS Website. In my case following logs did help

 - `eb-engine.log`
 - `cfn-init.log`
 - `cfn-init-cmd.log` (this log file helped me find illegal syntax in my `command` scripts)

### Forcing HTTPS

In the `.platform/nginx/conf.d/elasticbeanstalk/nginx.conf` it is possible to force https.
Via: 

```nginx
    fastcgi_param HTTPS on;
```

I could not get it work via x-forwarded-* headers as the were not send to my instance.

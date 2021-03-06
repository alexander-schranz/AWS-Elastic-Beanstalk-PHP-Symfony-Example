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
 - publicdir configuration ([.ebextensions/publicdir.config](.ebextensions/publicdir.config))
 - supervisor configuration ([.ebextensions/supervisor.config](.ebextensions/supervisor.config))
 - nginx vhost ([.platform/nginx/conf.d/elasticbeanstalk/php.conf](.platform/nginx/conf.d/elasticbeanstalk/php.conf))
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

I could not get it work via `x-forwarded-*` headers as the were not send to my instance.

### Cronjob only on one Instance

If your applicaton is running with multiple instances it is maybe important that your cronjobs
only run on one instance for this have a look at the following issue and example:

[https://github.com/alexander-schranz/AWS-Elastic-Beanstalk-PHP-Symfony-Example/issues/1](https://github.com/alexander-schranz/AWS-Elastic-Beanstalk-PHP-Symfony-Example/issues/1).

### Permission denied install_supervisor

If you have problem to deploy with supervisor and have following in your `cfn-init-cmd.log`:

```bash
/bin/sh: .ebextensions/supervisor/setup.sh: Permission denied
```

It could be an error with the `setup.sh` not being executable so make it executable via:

```bash
chmod +x .ebextensions/supervisor/setup.sh: 
```

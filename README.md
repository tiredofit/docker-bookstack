# hub.docker.com/r/tiredofit/bookstack

[![Build Status](https://img.shields.io/docker/build/tiredofit/bookstack.svg)](https://hub.docker.com/r/tiredofit/bookstack)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/bookstack.svg)](https://hub.docker.com/r/tiredofit/bookstack)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/bookstack.svg)](https://hub.docker.com/r/tiredofit/bookstack)
[![Docker Layers](https://images.microbadger.com/badges/image/tiredofit/bookstack.svg)](https://microbadger.com/images/tiredofit/bookstack)

## Introduction

This will build a container for [bookstack](https://bookstackapp.com/) - A Knowledge Base/Information Manager.

- Automatically installs and sets up installation upon first start

- This Container uses a [customized Alpine base](https://hub.docker.com/r/tiredofit/alpine) which includes [s6 overlay](https://github.com/just-containers/s6-overlay) enabled for PID 1 Init capabilities, [zabbix-agent](https://zabbix.org) for individual container monitoring, Cron also installed along with other tools (bash,curl, less, logrotate, nano, vim) for easier management. It also supports sending to external SMTP servers..

[Changelog](CHANGELOG.md)

## Authors

- [Dave Conroy](https://github.com/tiredofit)

## Table of Contents

- [Introduction](#introduction)
- [Authors](#authors)
- [Table of Contents](#table-of-contents)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Quick Start](#quick-start)
- [Configuration](#configuration)
  - [Data-Volumes](#data-volumes)
  - [Environment Variables](#environment-variables)
    - [Core Options](#core-options)
    - [Bookstack Options](#bookstack-options)
    - [Authentication Settings](#authentication-settings)
    - [Cache and Session Settings](#cache-and-session-settings)
    - [Mail Settings](#mail-settings)
    - [Storage Settings](#storage-settings)
    - [External Login Services](#external-login-services)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [References](#references)

## Prerequisites

This image assumes that you are using a reverse proxy such as
[jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) and optionally the [Let's Encrypt Proxy
Companion @
https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion)
in order to serve your pages. However, it will run just fine on it's own if you map appropriate ports. See the examples folder for a docker-compose.yml that does not rely on a reverse proxy.

You will also need an external MariaDB container

## Installation

Automated builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/bookstack) and is the recommended method of installation.

```bash
docker pull tiredofit/bookstack
```

### Quick Start

- The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

- Set various [environment variables](#environment-variables) to understand the capabilities of this image.
- Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
- Make [networking ports](#networking) available for public access if necessary

**The first boot can take from 2 minutes - 5 minutes depending on your CPU to setup the proper schemas.**

Login to the web server and enter in your admin email address, admin password and start configuring the system!

## Configuration

### Data-Volumes

The following directories are used for configuration and can be mapped for persistent storage.

| Directory                | Description                                                                                                                   |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------------- |
| `/www/logs`              | Nginx and PHP Log files                                                                                                       |
| `/assets/custom`         | (Optional) Copy source code over existing source code in /www/bookstack upon container start. Use exact file/folder structure |
| `/assets/custom-scripts` | (Optional) If you want to execute custom scripting, place scripts here with extension `.sh`                                   |
| `/assets/modules`        | (Optional) If you want to add additional modules outside of the source tree, add them here                                    |
| `/www/bookstack`         | (Optional) If you want to expose the bookstack sourcecode expose this volume                                                  |
| **OR**                   |                                                                                                                               |
| `/data`                  | Hold onto your persistent sessions and cache between container restarts                                                       |

### Environment Variables

Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine), and [Web Image](https://hub.docker.com/r/tiredofit/nginx), and [PHP Image](https://hub.docker.com/r/tiredofit/nginx-php-fpm) below is the complete list of available options that can be used to customize your installation.

#### Core Options

| Parameter     | Description                                                  | Default           |
| ------------- | ------------------------------------------------------------ | ----------------- |
| `ADMIN_NAME`  | Full name of Administrator Account                           | `BookStack Admin` |
| `ADMIN_PASS`  | Password of Administrator account                            | `password`        |
| `ADMIN_EMAIL` | Email address of Administrator Account                       | `admin@admin.com` |
| `DB_HOST`     | Host or container name of MariaDB Server e.g. `bookstack-db` |                   |
| `DB_NAME`     | MariaDB Database name e.g. `bookstack`                       |                   |
| `DB_PASS`     | MariaDB Password for above Database e.g. `password`          |                   |
| `DB_PORT`     | MariaDB Port                                                 | `3306`            |
| `DB_USER`     | MariaDB Username for above Database e.g. `bookstack`         |                   |
| `LANGUAGE`    | Language for Application                                     | `en`              |
| `SETUP_TYPE`  | `AUTO` generate configuration. `MANUAL` don't do anything    | `AUTO`            |
| `SITE_URL`    | The full URL that you are serving this application from      | `null`            |
| `TIMEZONE`    | Timezone - Use Unix Style                                    | `Etc/UTC`         |

- <https://www.bookstackapp.com/docs/admin/language-config>

#### Bookstack Options

| Parameter                    | Description                                             | Default |
| ---------------------------- | ------------------------------------------------------- | ------- |
| `ALLOW_CONTENT_SCRIPTS`      | Allow javascript within content                         | `false` |
| `ALLOW_ROBOTS`               | Allow robots to Index site                              | `false` |
| `API_DEFAULT_ITEM_COUNT`     | API Default Return Items Count                          | `100`   |
| `API_DEFAULT_MAX_ITEM_COUNT` | API Default Maximum Items Count                         | `500`   |
| `API_REQUESTS_PER_MIN`       | API Requests per minute limit                           | `180`   |
| `AVATAR_URL`                 | Set URL for external Avatar fetching                    |         |
| `DISABLE_EXTERNAL_SERVICES`  | Disable every external service                          | `false` |
| `DRAWIO_HOST`                | Full URL of DrawIO server if not wanting to use default |         |
| `ENABLE_DRAWIO`              | Enable DrawIO Functionality                             | `false` |
| `LANGUAGE_AUTO_DETECT`       | Detect Language via Browser                             | `false` |
| `QUEUE_CONNECTION`           | Queue Connection                                        | `sync`  |
| `REVISION_LIMIT`             | Default Revision Limit for pages                        | `50`    |
| `THEME`                      | Drop themes in /data/themes and set value here          | `false` |
| `VIEW_BOOKS`                 | View books in either `list` or `grid` format            | `list`  |
| `VIEW_SHELVES`               | View shelves in either `list` or `grid` format          | `grid`  |

#### Authentication Settings

| Parameter                     | Description                      | Default        |
| ----------------------------- | -------------------------------- | -------------- |
| `AUTHENTICATION_TYPE`         | `STANDARD`, `LDAP`, `SAML`       | `STANDARD`     |
| `LDAP_ATTRIBUTE_DISPLAY_NAME` | Display Name Attribute           | `cn`           |
| `LDAP_ATTRIBUTE_GROUP`        | Group Attribute                  | `memberOf`     |
| `LDAP_ATTRIBUTE_ID`           | Unique Identifier Attribute      | `uid`          |
| `LDAP_ATTRIBUTE_MAIL`         | Mail Attribute                   | `mail`         |
| `LDAP_BASE_DN`                | Base DN to search                |                |
| `LDAP_BIND_PASS`              | Bind password for authentication |                |
| `LDAP_BIND_USER`              | Bind User for authentication     |                |
| `LDAP_DUMP_USER_DETAILS`      | Used for Debugging               | `false`        |
| `LDAP_FILTER_USER`            | User Filter                      | `false`        |
| `LDAP_FOLLOW_REFERRALS`       | Follow LDAP Referrals            | `true`         |
| `LDAP_HOST`                   | LDAP Hostname                    |                |
| `LDAP_REMOVE_FROM_GROUPS`     | Remove user from Groups          | `false`        |
| `LDAP_TLS_INSECURE`           | Use TLS without verifying        | `false`        |
| `LDAP_USER_TO_GROUPS`         | Add user to Groups               | `false`        |
| `LDAP_VERSION`                | Version of LDAP                  | `3`            |
| `SAML2_IDP_ENTITYID`          | URL of SAML IDP entity           |                |
| `SAML2_IDP_SLO`               | SAML Single Log off URL          |                |
| `SAML2_IDP_SSO`               | SAML Single Sign on URL          |                |
| `SAML_ATTRIBUTE_DISPLAY_NAME` | SAML Display Name attribute      | `givenName|sn` |
| `SAML_ATTRIBUTE_GROUP`        | SAML Group attribute             | `groups`       |
| `SAML_ATTRIBUTE_MAIL`         | SAML Mail attribute              | `mail`         |
| `SAML_ATTRIBUTE_EXTERNAL_ID`  | SAML External ID attribute       | `uid`          |
| `SAML_AUTOLOAD_METADATA`      | Auto Load Metadata from SAML IDP | `true`         |
| `SAML_DUMP_USER_DETAILS`      | Used for debugging               | `false`        |
| `SAML_NAME`                   | SAML Public Service Name         | `SSO`          |
| `SAML_REMOVE_FROM_GROUPS`     | Remove user from Groups          | `false`        |
| `SAML_USER_TO_GROUPS`         | Add user to Groups               | `true`         |

- <https://www.bookstackapp.com/docs/admin/ldap-auth>
- <https://www.bookstackapp.com/docs/admin/saml2-auth>

#### Cache and Session Settings

| Parameter               | Description                                                                    | Default             |
| ----------------------- | ------------------------------------------------------------------------------ | ------------------- |
| `CACHE_DRIVER`          | Use what backend for cache `file` `database` `redis` `memcached`               | `file`              |
| `CACHE_PREFIX`          | Cache Prefix                                                                   | `bookstack`         |
| `SESSION_COOKIE_NAME`   | Cookie Name                                                                    | `bookstack_session` |
| `SESSION_DRIVER`        | Use what backend for sesssion management `file` `database` `redis` `memcached` | `FILE`              |
| `SESSION_LIFETIME`      | How long in minutes for Ssession                                               | `120`               |
| `SESSION_SECURE_COOKIE` | Deliver HTTPS cookie                                                           | `true`              |
| `MEMCACHED_HOST`        | Memcached Hostname                                                             |                     |
| `MEMCACHED_PORT`        | Memcached Port                                                                 | `11211`             |
| `MEMCACHED_WEIGHT`      | Memcached Weight                                                               | `100`               |
| `REDIS_DB`              | Redis DB                                                                       | `0`                 |
| `REDIS_PORT`            | Redis Port                                                                     | `6379`              |
| `REDIS_HOST`            | Redis Hostname                                                                 |                     |

- <https://www.bookstackapp.com/docs/admin/cache-session-config>

#### Mail Settings

| Parameter        | Description                             | Default                 |
| ---------------- | --------------------------------------- | ----------------------- |
| `MAIL_FROM_NAME` | Display name to be sent from Bookstack  | `BookStack`             |
| `MAIL_FROM`      | Email address to be sent from Bookstack | `bookstack@example.com` |
| `MAIL_TYPE`      | How to send mail - `SMTP`               | `SMTP`                  |
| `SMTP_HOST`      | Hostname of SMTP Server                 | `postfix-relay`         |
| `SMTP_PASS`      | SMTP Password                           | `null`                  |
| `SMTP_PORT`      | SMTP Port                               | `25`                    |
| `SMTP_TLS`       | Enable TLS for SMTP Connections         | `FALSE`                 |
| `SMTP_USER`      | SMTP Username                           | `null`                  |

- <https://www.bookstackapp.com/docs/admin/email-config>

#### Storage Settings

| Parameter                 | Description                                                              | Default        |
| ------------------------- | ------------------------------------------------------------------------ | -------------- |
| `STORAGE_TYPE`            | How to store files `local` `local_secure` `s3`                           | `local`        |
| `STORAGE_ATTACHMENT_TYPE` | Attachment storage type                                                  | `local_secure` |
| `STORAGE_IMAGE_TYPE`      | Image storage type                                                       | `local`        |
| `STORAGE_S3_BUCKET`       | S3 Bucket                                                                |                |
| `STORAGE_S3_KEY`          | S3 Key                                                                   |                |
| `STORAGE_S3_REGION`       | S3 Region                                                                |                |
| `STORAGE_S3_SECRET`       | S3 Key                                                                   |                |
| `STORAGE_URL`             | Set this if you are connecting to a compatible service like Minio/Wasabi |                |

- <https://www.bookstackapp.com/docs/admin/upload-config>

#### External Login Services

| Parameter                     | Description                     | Default |
| ----------------------------- | ------------------------------- | ------- |
| `ENABLE_LOGIN_AZURE`          | Enable Logging in from Azure    | `false` |
| `AZURE_APP_ID`                | Application ID                  |         |
| `AZURE_APP_SECRET`            | Application Secret              |         |
| `AZURE_AUTO_CONFIRM_EMAIL`    | Auto confirm email address      | `false` |
| `AZURE_AUTO_REGISTER`         | Auto register username          | `false` |
| `AZURE_TENANT`                | Tenant ID                       |         |
| `ENABLE_LOGIN_DISCORD`        | Enable Logging in from Discord  | `false` |
| `DISCORD_APP_ID`              | Application ID                  |         |
| `DISCORD_APP_SECRET`          | Application Secret              |         |
| `DISCORD_AUTO_CONFIRM_EMAIL`  | Auto confirm email address      | `false` |
| `DISCORD_AUTO_REGISTER`       | Auto register username          | `false` |
| `ENABLE_LOGIN_FACEBOOK`       | Enable Logging in from Facebook | `false` |
| `FACEBOOK_APP_ID`             | Application ID                  |         |
| `FACEBOOK_APP_SECRET`         | Application Secret              |         |
| `FACEBOOK_AUTO_CONFIRM_EMAIL` | Auto confirm email address      | `false` |
| `FACEBOOK_AUTO_REGISTER`      | Auto register username          | `false` |
| `ENABLE_LOGIN_GITHUB`         | Enable Logging in from Github   | `false` |
| `GITHUB_APP_ID`               | Application ID                  |         |
| `GITHUB_APP_SECRET`           | Application Secret              |         |
| `GITHUB_AUTO_CONFIRM_EMAIL`   | Auto confirm email address      | `false` |
| `GITHUB_AUTO_REGISTER`        | Auto register username          | `false` |
| `ENABLE_LOGIN_GITLAB`         | Enable Logging in from Gitlab   | `false` |
| `GITLAB_APP_ID`               | Application ID                  |         |
| `GITLAB_APP_SECRET`           | Application Secret              |         |
| `GITLAB_AUTO_CONFIRM_EMAIL`   | Auto confirm email address      | `false` |
| `GITLAB_AUTO_REGISTER`        | Auto register username          | `false` |
| `GITLAB_BASE_URI`             | Gitlab URI                      |         |
| `ENABLE_LOGIN_GOOGLE`         | Enable Logging in from Google   | `false` |
| `GOOGLE_APP_ID`               | Application ID                  |         |
| `GOOGLE_APP_SECRET`           | Application Secret              |         |
| `GOOGLE_AUTO_CONFIRM_EMAIL`   | Auto confirm email address      | `false` |
| `GOOGLE_AUTO_REGISTER`        | Auto register username          | `false` |
| `GOOGLE_SELECT_ACCOUNT`       | Select Google Account           |         |
| `ENABLE_LOGIN_OKTA`           | Enable Logging in from OKTA     | `false` |
| `OKTA_APP_ID`                 | Application ID                  |         |
| `OKTA_APP_SECRET`             | Application Secret              |         |
| `OKTA_AUTO_CONFIRM_EMAIL`     | Auto confirm email address      | `false` |
| `OKTA_AUTO_REGISTER`          | Auto register username          | `false` |
| `OKTA_BASE_URL`               | OKTA Base URI                   |         |
| `ENABLE_LOGIN_SLACK`          | Enable Logging in from Slack    | `false` |
| `SLACK_APP_ID`                | Application ID                  |         |
| `SLACK_APP_SECRET`            | Application Secret              |         |
| `SLACK_AUTO_CONFIRM_EMAIL`    | Auto confirm email address      | `false` |
| `SLACK_AUTO_REGISTER`         | Auto register username          | `false` |
| `ENABLE_LOGIN_TWITCH`         | Enable Logging in from Twitch   | `false` |
| `TWITCH_APP_ID`               | Application ID                  |         |
| `TWITCH_APP_SECRET`           | Application Secret              |         |
| `TWITCH_AUTO_CONFIRM_EMAIL`   | Auto confirm email address      | `false` |
| `TWITCH_AUTO_REGISTER`        | Auto register username          | `false` |
| `ENABLE_LOGIN_TWITTER`        | Enable Logging in from Twitter  | `false` |
| `TWITTER_APP_ID`              | Application ID                  |         |
| `TWITTER_APP_SECRET`          | Application Secret              |         |
| `TWITTER_AUTO_CONFIRM_EMAIL`  | Auto confirm email address      | `false` |
| `TWITTER_AUTO_REGISTER`       | Auto register username          | `false` |

- <https://www.bookstackapp.com/docs/admin/social-auth>

### Networking

The following ports are exposed.

| Port | Description |
| ---- | ----------- |
| `80` | HTTP        |

## Maintenance

### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is e.g. bookstack) bash
```

## References

- <https://www.bookstackapp.com/docs>

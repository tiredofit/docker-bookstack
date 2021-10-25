# github.com/tiredofit/docker-bookstack

[![GitHub release](https://img.shields.io/github/v/tag/tiredofit/docker-bookstack?style=flat-square)](https://github.com/tiredofit/docker-bookstack/releases/latest)
[![Build Status](https://img.shields.io/github/workflow/status/tiredofit/docker-bookstack/build?style=flat-square)](https://github.com/tiredofit/docker-bookstack/actions?query=workflow%3Abuild)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/bookstack.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/bookstack/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/bookstack.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/bookstack/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)

* * *

## About

This will build a Docker image for [Bookstack](https://bookstackapp.com/) - A Knowledge Base/Information Manager.

- Automatically installs and sets up installation upon first start

## Maintainer

- [Dave Conroy](https://github.com/tiredofit)

## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Table of Contents](#table-of-contents)
- [Prerequisites and Assumptions](#prerequisites-and-assumptions)
- [Installation](#installation)
  - [Build from Source](#build-from-source)
  - [Prebuilt Images](#prebuilt-images)
- [Configuration](#configuration)
  - [Quick Start](#quick-start)
  - [Persistent Storage](#persistent-storage)
  - [Environment Variables](#environment-variables)
    - [Base Images used](#base-images-used)
    - [Core Options](#core-options)
    - [Bookstack Options](#bookstack-options)
    - [Authentication Settings](#authentication-settings)
      - [LDAP Options](#ldap-options)
      - [SAML Options](#saml-options)
      - [OpenID Connect](#openid-connect)
    - [External Login Services](#external-login-services)
    - [Cache and Session Settings](#cache-and-session-settings)
    - [Mail Settings](#mail-settings)
    - [Storage Settings](#storage-settings)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [Support](#support)
  - [Usage](#usage)
  - [Bugfixes](#bugfixes)
  - [Feature Requests](#feature-requests)
  - [Updates](#updates)
- [License](#license)
- [References](#references)

## Prerequisites and Assumptions
*  Assumes you are using some sort of SSL terminating reverse proxy such as:
   *  [Traefik](https://github.com/tiredofit/docker-traefik)
   *  [Nginx](https://github.com/jc21/nginx-proxy-manager)
   *  [Caddy](https://github.com/caddyserver/caddy)
* Requires access to a MySQL/MariaDB Database server

## Installation

### Build from Source
Clone this repository and build the image with `docker build -t (imagename) .`

### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/bookstack) and is the recommended method of installation.

```bash
docker pull tiredofit/bookstack:(imagetag)
```

The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| Container OS | Tag       |
| ------------ | --------- |
| Alpine       | `:latest` |

## Configuration

### Quick Start

- The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

- Set various [environment variables](#environment-variables) to understand the capabilities of this image.
- Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
- Make [networking ports](#networking) available for public access if necessary

**The first boot can take from 2 minutes - 5 minutes depending on your CPU to setup the proper schemas.**

- Login to the web server and enter in your admin email address, admin password and start configuring the system!


### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory        | Description                                                                  |
| ---------------- | ---------------------------------------------------------------------------- |
| `/www/logs`      | Nginx and PHP Log files                                                      |
| `/www/bookstack` | (Optional) If you want to expose the bookstack sourcecode expose this volume |
| **OR**           |                                                                              |
| `/data`          | Hold onto your persistent sessions and cache between container restarts      |

### Environment Variables

#### Base Images used

This image relies on an [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) or [Debian Linux](https://hub.docker.com/r/tiredofit/debian) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`,`nano`,`vim`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                         | Description                            |
| ------------------------------------------------------------- | -------------------------------------- |
| [OS Base](https://github.com/tiredofit/docker-alpine/)        | Customized Image based on Alpine Linux |
| [Nginx](https://github.com/tiredofit/docker-nginx/)           | Nginx webserver                        |
| [PHP-FPM](https://github.com/tiredofit/docker-nginx-php-fpm/) | PHP Interpreter                        |
#### Core Options

| Parameter                  | Description                                                      | Default           |
| -------------------------- | ---------------------------------------------------------------- | ----------------- |
| `ADMIN_NAME`               | Full name of Administrator Account                               | `BookStack Admin` |
| `ADMIN_PASS`               | Password of Administrator account                                | `password`        |
| `ADMIN_EMAIL`              | Email address of Administrator Account                           | `admin@admin.com` |
| `DB_HOST`                  | Host or container name of MariaDB Server e.g. `bookstack-db`     |                   |
| `DB_NAME`                  | MariaDB Database name e.g. `bookstack`                           |                   |
| `DB_PASS`                  | MariaDB Password for above Database e.g. `password`              |                   |
| `DB_PORT`                  | MariaDB Port                                                     | `3306`            |
| `DB_USER`                  | MariaDB Username for above Database e.g. `bookstack`             |                   |
| `ENABLE_OPTMIZE_IMAGES`    | Enable automatic image optimizations using optipng and jpegoptim | `TRUE`            |
| `OPTIMIZE_IMAGES_BEGIN`    | When to start image optimization use military time HHMM          | `0300`            |
| `OPTIMIZE_IMAGES_INTERVAL` | How often to perform image optimization in minutes               | `1440`            |
| `LANGUAGE`                 | Language for Application                                         | `en`              |
| `SETUP_TYPE`               | `AUTO` generate configuration. `MANUAL` don't do anything        | `AUTO`            |
| `SITE_URL`                 | The full URL that you are serving this application from          | `null`            |
| `TIMEZONE`                 | Timezone - Use Unix Style                                        | `Etc/UTC`         |

- <https://www.bookstackapp.com/docs/admin/language-config>

#### Bookstack Options

| Parameter                    | Description                                                                                                         | Default              |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------- | -------------------- |
| `ALLOWED_IFRAME_HOSTS`       | Allow IFrame's from specific domains other than same domain serving from - Multiple can be used seperated by a line |                      |
| `ALLOW_CONTENT_SCRIPTS`      | Allow javascript within content                                                                                     | `false`              |
| `ALLOW_ROBOTS`               | Allow robots to Index site                                                                                          | `false`              |
| `API_DEFAULT_ITEM_COUNT`     | API Default Return Items Count                                                                                      | `100`                |
| `API_DEFAULT_MAX_ITEM_COUNT` | API Default Maximum Items Count                                                                                     | `500`                |
| `API_REQUESTS_PER_MIN`       | API Requests per minute limit                                                                                       | `180`                |
| `AVATAR_URL`                 | Set URL for external Avatar fetching                                                                                |                      |
| `DEFAULT_DARK_MODE`          | Use Dark mode by default                                                                                            | `false`              |
| `DISABLE_EXTERNAL_SERVICES`  | Disable every external service                                                                                      | `false`              |
| `DRAWIO_HOST`                | Full URL of DrawIO server if not wanting to use default                                                             |                      |
| `ENABLE_DRAWIO`              | Enable DrawIO Functionality                                                                                         | `false`              |
| `LOG_FILE`                   | Log File                                                                                                            | `bokstack`.log       |
| `LOG_PATH`                   | Log Path                                                                                                            | `/www/logs/bokstack` |
| `LANGUAGE_AUTO_DETECT`       | Detect Language via Browser                                                                                         | `false`              |
| `PDF_EXPORT`                 | Use `internal` domPDF functions or `external` wkhtmltopdf tool                                                      | `internal`           |
| `QUEUE_CONNECTION`           | Queue Connection                                                                                                    | `sync`               |
| `RECYCLE_BIN_LIFETIME`       | How Many days Recycle Bin should wait before auto deleting. `0` for no feature, `-1` for unlimited                  | `30`                 |
| `REVISION_LIMIT`             | Default Revision Limit for pages                                                                                    | `50`                 |
| `THEME`                      | Drop themes in /data/themes and set value here                                                                      | `false`              |
| `VIEW_BOOKS`                 | View books in either `list` or `grid` format                                                                        | `list`               |
| `VIEW_SHELVES`               | View shelves in either `list` or `grid` format                                                                      | `grid`               |

#### Authentication Settings

| Parameter             | Description                        | Default    |
| --------------------- | ---------------------------------- | ---------- |
| `AUTHENTICATION_TYPE` | `STANDARD`, `LDAP`, `OIDC`, `SAML` | `STANDARD` |

##### LDAP Options

| Parameter                     | Description                                             | Default                              |
| ----------------------------- | ------------------------------------------------------- | ------------------------------------ |
| `ENABLE_LDAP_USER_SYNC`       | Enable Scheduled Syncing of LDAP User list              | `TRUE`                               |
| `LDAP_ATTRIBUTE_DISPLAY_NAME` | Display Name Attribute                                  | `cn`                                 |
| `LDAP_ATTRIBUTE_GROUP`        | Group Attribute                                         | `memberOf`                           |
| `LDAP_ATTRIBUTE_ID`           | Unique Identifier Attribute                             | `uid`                                |
| `LDAP_ATTRIBUTE_MAIL`         | Mail Attribute                                          | `mail`                               |
| `LDAP_BASE_DN`                | Base DN to search                                       |                                      |
| `LDAP_BIND_PASS`              | Bind password for authentication                        |                                      |
| `LDAP_BIND_USER`              | Bind User for authentication                            |                                      |
| `LDAP_DUMP_USER_DETAILS`      | Used for Debugging                                      | `false`                              |
| `LDAP_FILTER_USER`            | User Filter                                             | `(&(${LDAP_ATTRIBUTE_ID}=\${user}))` |
| `LDAP_FILTER_SYNC`            | Filter for syncing users from LDAP                      | `false`                              |
| `LDAP_FOLLOW_REFERRALS`       | Follow LDAP Referrals                                   | `true`                               |
| `LDAP_HOST`                   | LDAP Hostname                                           |                                      |
| `LDAP_SYNC_BEGIN`             | When to start syncing in military time HHMM             | `+0` (immediate)                     |
| `LDAP_SYNC_EXCLUDE_EMAIL`     | Comma seperated values of emails to ignore when syncing |                                      |
| `LDAP_SYNC_INTERVAL`          | In minutes amount of time to reperform LDAP Sync        | `60`                                 |
| `LDAP_SYNC_RECURSIVE`         | Recursively search through LDAP Groups                  | `true`                               |
| `LDAP_REMOVE_FROM_GROUPS`     | Remove user from Groups                                 | `false`                              |
| `LDAP_TLS_INSECURE`           | Use TLS without verifying                               | `false`                              |
| `LDAP_USER_TO_GROUPS`         | Add user to Groups                                      | `false`                              |
| `LDAP_VERSION`                | Version of LDAP                                         | `3`                                  |

- <https://www.bookstackapp.com/docs/admin/ldap-auth>
##### SAML Options

| Parameter                     | Description                      | Default        |
| ----------------------------- | -------------------------------- | -------------- |
| `SAML_IDP_ENTITYID`           | URL of SAML IDP entity           |                |
| `SAML_IDP_SLO`                | SAML Single Log off URL          |                |
| `SAML_IDP_SSO`                | SAML Single Sign on URL          |                |
| `SAML_ATTRIBUTE_DISPLAY_NAME` | SAML Display Name attribute      | `givenName|sn` |
| `SAML_ATTRIBUTE_GROUP`        | SAML Group attribute             | `groups`       |
| `SAML_ATTRIBUTE_MAIL`         | SAML Mail attribute              | `mail`         |
| `SAML_ATTRIBUTE_EXTERNAL_ID`  | SAML External ID attribute       | `uid`          |
| `SAML_AUTOLOAD_METADATA`      | Auto Load Metadata from SAML IDP | `true`         |
| `SAML_DUMP_USER_DETAILS`      | Used for debugging               | `false`        |
| `SAML_NAME`                   | SAML Public Service Name         | `SSO`          |
| `SAML_REMOVE_FROM_GROUPS`     | Remove user from Groups          | `false`        |
| `SAML_USER_TO_GROUPS`         | Add user to Groups               | `true`         |
| `SAML_SP_X509`                | SAML SP Public Certificate       | ``             |
| `SAML_SP_X509_KEY`            | SAML SP Private Key              | ``             |


- <https://www.bookstackapp.com/docs/admin/saml2-auth>

##### OpenID Connect

| Parameter                  | Description                                                          | Default |
| -------------------------- | -------------------------------------------------------------------- | ------- |
| `OIDC_NAME`                | Name to appear on login screen                                       | `SSO`   |
| `OIDC_DISPLAY_NAME_CLAIMS` | Claims to use for users display name                                 | `name`  |
| `OIDC_CLIENT_ID`           | OIDC Client ID                                                       |         |
| `OIDC_CLIENT_SECRET`       | OIDC Client Secret                                                   |         |
| `OIDC_ISSUER`              | Issuer URL must start with https://                                  |         |
| `OIDC_ISSER_DISCOVER`      | Auto Discover endpoints from .well-known                             | `TRUE`  |
| `OIDC_PUBLIC_KEY`          | (if above false) File path to where Public Key of provicer is stored |         |
| `OIDC_AUTH_ENDPOINT`       | (if above false) Full URL to Authorize Endpoint                      |         |
| `OIDC_TOKEN_ENDPOINT`      | (if above false) FulL URL to Token Endpoint                          |         |
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

### Networking

The following ports are exposed.

| Port | Description |
| ---- | ----------- |
| `80` | HTTP        |

* * *
## Maintenance

### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

``bash
docker exec -it (whatever your container name is) bash
``
## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) personalized support.
### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) regarding development of features.

### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for up to date releases.

## License
MIT. See [LICENSE](LICENSE) for more details.

## References

- <https://www.bookstackapp.com/docs>

# nfrastack/container-bookstack

## About

This repository will build a conatiner image for running [BookStack](https://bookstack.net/) - A knowledge base/information manager.

## Maintainer

* [Nfrastack](https://www.nfrastack.com)

## Table of Contents

* [About](#about)
* [Maintainer](#maintainer)
* [Table of Contents](#table-of-contents)
* [Installation](#installation)
  * [Prebuilt Images](#prebuilt-images)
  * [Quick Start](#quick-start)
  * [Persistent Storage](#persistent-storage)
* [Configuration](#configuration)
  * [Environment Variables](#environment-variables)
    * [Base Images used](#base-images-used)
    * [Core Configuration](#core-configuration)
  * [Users and Groups](#users-and-groups)
  * [Networking](#networking)
* [Maintenance](#maintenance)
  * [Shell Access](#shell-access)
* [Support & Maintenance](#support--maintenance)
* [License](#license)
* [References](#references)

## Installation

### Prebuilt Images

Feature limited builds of the image are available on the [Github Container Registry](https://github.com/nfrastack/container-bookstack/pkgs/container/container-bookstack) and [Docker Hub](https://hub.docker.com/r/nfrastack/bookstack).

To unlock advanced features, one must provide a code to be able to change specific environment variables from defaults. Support the development to gain access to a code.

To get access to the image use your container orchestrator to pull from the following locations:

```
ghcr.io/nfrastack/container-bookstack:(image_tag)
docker.io/nfrastack/bookstack:(image_tag)
```

Image tag syntax is:

`<image>:<optional tag>-<optional phpversion>`

Example:

`docker.io/nfrastack/container-bookstack:latest` or

`ghcr.io/nfrastack/container-bookstack:1.0-php84`

* `latest` will be the most recent commit

* An optional `tag` may exist that matches the [CHANGELOG](CHANGELOG.md) - These are the safest


Have a look at the container registries and see what tags are available.

#### Multi-Architecture Support

Images are built for `amd64` by default, with optional support for `arm64` and other architectures.

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [compose.yml](examples/compose.yml) that can be modified for your use.

* Map [persistent storage](#persistent-storage) for access to configuration and data files for backup.
* Set various [environment variables](#environment-variables) to understand the capabilities of this image.

**The first boot can take from 2 minutes - 5 minutes depending on your CPU to setup the proper schemas.**

### Persistent Storage

The following directories/files should be mapped for persistent storage in order to utilize the container effectively.

| Directory        | Description                                                                  |
| ---------------- | ---------------------------------------------------------------------------- |
| `/logs`          | Nginx and PHP Log files                                                      |
| `/www/bookstack` | (Optional) If you want to expose the bookstack sourcecode expose this volume |
| **OR**           |                                                                              |
| `/data`          | Hold onto your persistent sessions and cache between container restarts      |


### Environment Variables

#### Base Images used

This image relies on a customized base image in order to work.
Be sure to view the following repositories to understand all the customizable options:

| Image                                                                 | Description         |
| --------------------------------------------------------------------- | ------------------- |
| [OS Base](https://github.com/nfrastack/container-base/)               | Base Image          |
| [Nginx](https://github.com/nfrastack/container-nginx/)                | Nginx Webserver     |
| [Nginx PHP-FPM](https://github.com/nfrastack/container-nginx-php-fpm) | PHP-FPM Interpreter |

Below is the complete list of available options that can be used to customize your installation.

* Variables showing an 'x' under the `Advanced` column can only be set if the containers advanced functionality is enabled.

#### Core Configuration

| Parameter                  | Description                                                      | Default           | `_FILE` |
| -------------------------- | ---------------------------------------------------------------- | ----------------- | ------- |
| `ADMIN_NAME`               | Full name of Administrator Account                               | `BookStack Admin` | x       |
| `ADMIN_PASS`               | Password of Administrator account                                | `password`        | x       |
| `ADMIN_EMAIL`              | Email address of Administrator Account                           | `admin@admin.com` | x       |
| `DB_HOST`                  | Host or container name of MariaDB Server e.g. `bookstack-db`     |                   | x       |
| `DB_NAME`                  | MariaDB Database name e.g. `bookstack`                           |                   | x       |
| `DB_PASS`                  | MariaDB Password for above Database e.g. `password`              |                   | x       |
| `DB_PORT`                  | MariaDB Port                                                     | `3306`            | x       |
| `DB_USER`                  | MariaDB Username for above Database e.g. `bookstack`             |                   | x       |
| `ENABLE_OPTMIZE_IMAGES`    | Enable automatic image optimizations using optipng and jpegoptim | `TRUE`            |         |
| `OPTIMIZE_IMAGES_BEGIN`    | When to start image optimization use military time HHMM          | `0300`            |         |
| `OPTIMIZE_IMAGES_INTERVAL` | How often to perform image optimization in minutes               | `1440`            |         |
| `LANGUAGE`                 | Language for Application                                         | `en`              |         |
| `SETUP_TYPE`               | `AUTO` generate configuration. `MANUAL` don't do anything        | `AUTO`            |         |
| `SITE_URL`                 | The full URL that you are serving this application from          | `null`            |         |
| `TIMEZONE`                 | Timezone - Use Unix Style                                        | `Etc/UTC`         |         |

* <https://www.bookstackapp.com/docs/admin/language-config>

#### Bookstack Options

| Parameter                    | Description                                                                                        | Default                          |
| ---------------------------- | -------------------------------------------------------------------------------------------------- | -------------------------------- |
| `ALLOWED_IFRAME_HOSTS`       | Allow serving Bookstack via an IFrame  - Multiple can be used seperated by a line                  |                                  |
| `ALLOWED_IFRAME_SOURCES`     | Allow IFrames from specific domains `*` for All                                                    | `https://*.draw.io`              |
|                              |                                                                                                    | `https://*.youtube.com`          |
|                              |                                                                                                    | `https://*.youtube-nocookie.com` |
|                              |                                                                                                    | `https://*.vimeo.com`            |
| `ALLOWED_SSR_HOSTS`          | Allowed Server Side Request List (Webhooks)                                                        | `*`                              |
| `ALLOW_CONTENT_SCRIPTS`      | Allow javascript within content                                                                    | `false`                          |
| `ALLOW_ROBOTS`               | Allow robots to Index site                                                                         | `false`                          |
| `API_DEFAULT_ITEM_COUNT`     | API Default Return Items Count                                                                     | `100`                            |
| `API_DEFAULT_MAX_ITEM_COUNT` | API Default Maximum Items Count                                                                    | `500`                            |
| `API_REQUESTS_PER_MIN`       | API Requests per minute limit                                                                      | `180`                            |
| `AVATAR_URL`                 | Set URL for external Avatar fetching                                                               |                                  |
| `DEFAULT_DARK_MODE`          | Use Dark mode by default                                                                           | `false`                          |
| `DISABLE_EXTERNAL_SERVICES`  | Disable every external service                                                                     | `false`                          |
| `DRAWIO_HOST`                | Full URL of DrawIO server if not wanting to use default                                            |                                  |
| `ENABLE_DRAWIO`              | Enable DrawIO Functionality                                                                        | `false`                          |
| `FILE_UPLOAD_MAX_SIZE`       | Max MB of files to upload into the system                                                          | `50`                             |
| `IP_ADDRESS_PRECISION`       | Alter precision of IP Addresses stored by bookstack `0` to `4`                                     | `4`                              |
| `LOG_FILE`                   | Log File                                                                                           | `bokstack.log`                   |
| `LOG_PATH`                   | Log Path                                                                                           | `/www/logs/bokstack`             |
| `LOG_FAILED_LOGIN_MESSAGE`   | Enable logging of fdailed email and password logins with given message                             | `false`                          |
| `LOG_FAILED_LOGIN_CHANNEL`   | Default log channel uses php_error_log function                                                    | `errorlog_plain_webserver`       |
| `LANGUAGE_AUTO_DETECT`       | Detect Language via Browser                                                                        | `false`                          |
| `QUEUE_CONNECTION`           | Queue Connection                                                                                   | `sync`                           |
| `RECYCLE_BIN_LIFETIME`       | How Many days Recycle Bin should wait before auto deleting. `0` for no feature, `-1` for unlimited | `30`                             |
| `REVISION_LIMIT`             | Default Revision Limit for pages                                                                   | `100`                            |
| `THEME`                      | Drop themes in /data/themes and set value here                                                     | `false`                          |
| `VIEW_BOOKS`                 | View books in either `list` or `grid` format                                                       | `list`                           |
| `VIEW_SHELVES`               | View shelves in either `list` or `grid` format                                                     | `grid`                           |

#### Authentication Settings

| Parameter             | Description                        | Default    |
| --------------------- | ---------------------------------- | ---------- |
| `AUTHENTICATION_TYPE` | `STANDARD`, `LDAP`, `OIDC`, `SAML` | `STANDARD` |

##### LDAP Options

| Parameter                     | Description                                             | Default                              | `_FILE` |
| ----------------------------- | ------------------------------------------------------- | ------------------------------------ | ------- |
| `ENABLE_LDAP_USER_SYNC`       | Enable Scheduled Syncing of LDAP User list              | `TRUE`                               |         |
| `LDAP_ATTRIBUTE_DISPLAY_NAME` | Display Name Attribute                                  | `cn`                                 |         |
| `LDAP_ATTRIBUTE_GROUP`        | Group Attribute                                         | `memberOf`                           |         |
| `LDAP_ATTRIBUTE_ID`           | Unique Identifier Attribute                             | `uid`                                |         |
| `LDAP_ATTRIBUTE_MAIL`         | Mail Attribute                                          | `mail`                               |         |
| `LDAP_THUMBNAIL_ATTRIBUTE`    | Thumb nail attribute                                    |                                      |         |
| `LDAP_BASE_DN`                | Base DN to search                                       |                                      | x       |
| `LDAP_BIND_PASS`              | Bind password for authentication                        |                                      | x       |
| `LDAP_BIND_USER`              | Bind User for authentication                            |                                      | x       |
| `LDAP_DUMP_USER_DETAILS`      | Used for Debugging                                      | `false`                              |         |
| `LDAP_FILTER_USER`            | User Filter                                             | `(&(${LDAP_ATTRIBUTE_ID}=\${user}))` |         |
| `LDAP_FILTER_SYNC`            | Filter for syncing users from LDAP                      | `false`                              |         |
| `LDAP_FOLLOW_REFERRALS`       | Follow LDAP Referrals                                   | `true`                               |         |
| `LDAP_HOST`                   | LDAP Hostname                                           |                                      | x       |
| `LDAP_SYNC_BEGIN`             | When to start syncing in military time HHMM             | `+0` (immediate)                     |         |
| `LDAP_SYNC_EXCLUDE_EMAIL`     | Comma seperated values of emails to ignore when syncing |                                      |         |
| `LDAP_SYNC_INTERVAL`          | In minutes amount of time to reperform LDAP Sync        | `60`                                 |         |
| `LDAP_SYNC_RECURSIVE`         | Recursively search through LDAP Groups                  | `true`                               |         |
| `LDAP_REMOVE_FROM_GROUPS`     | Remove user from Groups                                 | `false`                              |         |
| `LDAP_TLS_INSECURE`           | Use TLS without verifying                               | `false`                              |         |
| `LDAP_USER_TO_GROUPS`         | Add user to Groups                                      | `false`                              |         |
| `LDAP_VERSION`                | Version of LDAP                                         | `3`                                  |         |

* <https://www.bookstackapp.com/docs/admin/ldap-auth>

##### SAML Options

| Parameter                     | Description                      | Default        |
| ----------------------------- | -------------------------------- | -------------- |
| `SAML_IDP_ENTITYID`           | URL of SAML IDP entity           |                |
| `SAML_IDP_SLO`                | SAML Single Log off URL          |                |
| `SAML_IDP_SSO`                | SAML Single Sign on URL          |                |
| `SAML_ATTRIBUTE_DISPLAY_NAME` | SAML Display Name attribute      | `givenName sn` |
| `SAML_ATTRIBUTE_GROUP`        | SAML Group attribute             | `groups`       |
| `SAML_ATTRIBUTE_MAIL`         | SAML Mail attribute              | `mail`         |
| `SAML_ATTRIBUTE_EXTERNAL_ID`  | SAML External ID attribute       | `uid`          |
| `SAML_AUTOLOAD_METADATA`      | Auto Load Metadata from SAML IDP | `true`         |
| `SAML_DUMP_USER_DETAILS`      | Used for debugging               | `false`        |
| `SAML_NAME`                   | SAML Public Service Name         | `SSO`          |
| `SAML_REMOVE_FROM_GROUPS`     | Remove user from Groups          | `false`        |
| `SAML_USER_TO_GROUPS`         | Add user to Groups               | `true`         |
| `SAML2_IDP_AUTHNCONTEXT`      | AuthN Context                    | `true`         |
| `SAML_SP_X509`                | SAML SP Public Certificate       | ``             |
| `SAML_SP_X509_KEY`            | SAML SP Private Key              | ``             |

* <https://www.bookstackapp.com/docs/admin/saml2-auth>

##### OpenID Connect

| Parameter                  | Description                                                          | Default  | `_FILE` |
| -------------------------- | -------------------------------------------------------------------- | -------- | ------- |
| `OIDC_NAME`                | Name to appear on login screen                                       | `SSO`    |         |
| `OIDC_DISPLAY_NAME_CLAIMS` | Claims to use for users display name                                 | `name`   | x       |
| `OIDC_CLIENT_ID`           | OIDC Client ID                                                       |          | x       |
| `OIDC_CLIENT_SECRET`       | OIDC Client Secret                                                   |          | x       |
| `OIDC_ISSUER`              | Issuer URL must start with https://                                  |          | x       |
| `OIDC_ISSUER_DISCOVER`     | Auto Discover endpoints from .well-known                             | `TRUE`   |         |
| `OIDC_PUBLIC_KEY`          | (if above false) File path to where Public Key of provicer is stored |          | x       |
| `OIDC_AUTH_ENDPOINT`       | (if above false) Full URL to Authorize Endpoint                      |          | x       |
| `OIDC_TOKEN_ENDPOINT`      | (if above false) FulL URL to Token Endpoint                          |          | x       |
| `OIDC_ADDITIONAL_SCOPES`   | OIDC Additional Scopes                                               | `null`   |         |
| `OIDC_USER_TO_GROUPS`      | Add user to Groups                                                   | `false`  |         |
| `OIDC_ATTRIBUTE_GROUP`     | Groups Attribute passed from OIDC Server                             | `groups` |         |
| `OIDC_REMOVE_FROM_GROUPS`  | Remove user from groups                                              | `false`  |         |
|                            |
#### External Login Services

| Parameter                                               | Description                     | Default | `_FILE` |
| ------------------------------------------------------- | ------------------------------- | ------- | ------- |
| `ENABLE_LOGIN_AZURE`                                    | Enable Logging in from Azure    | `false` |         |
| `AZURE_APP_ID`                                          | Application ID                  |         | x       |
| `AZURE_APP_SECRET`                                      | Application Secret              |         | x       |
| `AZURE_AUTO_CONFIRM_EMAIL`                              | Auto confirm email address      | `false` |         |
| `AZURE_AUTO_REGISTER`                                   | Auto register username          | `false` | x       |
| `AZURE_TENANT`                                          | Tenant ID                       |         |         |
| `ENABLE_LOGIN_DISCORD`                                  | Enable Logging in from Discord  | `false` |         |
| `DISCORD_APP_ID`                                        | Application ID                  |         | x       |
| `DISCORD_APP_SECRET`                                    | Application Secret              |         | x       |
| `DISCORD_AUTO_CONFIRM_EMAIL`                            | Auto confirm email address      | `false` |         |
| `DISCORD_AUTO_REGISTER`                                 | Auto register username          | `false` |         |
| `ENABLE_LOGIN_FACEBOOK`                                 | Enable Logging in from Facebook | `false` |         |
| `FACEBOOK_APP_ID`                                       | Application ID                  |         | x       |
| `FACEBOOK_APP_SECRET`                                   | Application Secret              |         | x       |
| `FACEBOOK_AUTO_CONFIRM_EMAIL`                           | Auto confirm email address      | `false` |         |
| `FACEBOOK_AUTO_REGISTER`                                | Auto register username          | `false` |         |
| `ENABLE_LOGIN_GITHUB`                                   | Enable Logging in from Github   | `false` |         |
| `GITHUB_APP_ID`                                         | Application ID                  |         | x       |
| `GITHUB_APP_SECRET`                                     | Application Secret              |         | x       |
| `GITHUB_AUTO_CONFIRM_EMAIL`                             | Auto confirm email address      | `false` |         |
| `GITHUB_AUTO_REGISTER`                                  | Auto register username          | `false` |         |
| `ENABLE_LOGIN_GITLAB`                                   | Enable Logging in from Gitlab   | `false` |         |
| `GITLAB_APP_ID`                                         | Application ID                  |         | x       |
| `GITLAB_APP_SECRET`                                     | Application Secret              |         | x       |
| `GITLAB_AUTO_CONFIRM_EMAIL`                             | Auto confirm email address      | `false` |         |
| `GITLAB_AUTO_REGISTER`                                  | Auto register username          | `false` |         |
| `GITLAB_BASE_URI`                                       | Gitlab URI                      |         | x       |
| `ENABLE_LOGIN_GOOGLE`                                   | Enable Logging in from Google   | `false` |         |
| `GOOGLE_APP_ID`                                         | Application ID                  |         | x       |
| `GOOGLE_APP_SECRET`                                     | Application Secret              |         | x       |
| `GOOGLE_AUTO_CONFIRM_EMAIL`                             | Auto confirm email address      | `false` |         |
| `GOOGLE_AUTO_REGISTER`                                  | Auto register username          | `false` |         |
| `GOOGLE_SELECT_ACCOUNT`                                 | Select Google Account           |         | x       |
| `ENABLE_LOGIN_OKTA`                                     | Enable Logging in from OKTA     | `false` |         |
| `OKTA_APP_ID`                                           | Application ID                  |         | x       |
| `OKTA_APP_SECRET`                                       | Application Secret              |         | x       |
| `OKTA_AUTO_CONFIRM_EMAIL`                               | Auto confirm email address      | `false` |         |
| `OKTA_AUTO_REGISTER`                                    | Auto register username          | `false` |         |
| `OKTA_BASE_URL`                                         | OKTA Base URI                   |         | x       |
| `ENABLE_LOGIN_SLACK`                                    | Enable Logging in from Slack    | `false` |         |
| `SLACK_APP_ID`                                          | Application ID                  |         | x       |
| `SLACK_APP_SECRET`                                      | Application Secret              |         | x       |
| `SLACK_AUTO_CONFIRM_EMAIL`                              | Auto confirm email address      | `false` |         |
| `SLACK_AUTO_REGISTER`                                   | Auto register username          | `false` |         |
| `ENABLE_LOGIN_TWITCH`                                   | Enable Logging in from Twitch   | `false` |         |
| `TWITCH_APP_ID`                                         | Application ID                  |         | x       |
| `TWITCH_APP_SECRET`                                     | Application Secret              |         | x       |
| `TWITCH_AUTO_CONFIRM_EMAIL`                             | Auto confirm email address      | `false` |         |
| `TWITCH_AUTO_REGISTER`                                  | Auto register username          | `false` |         |
| `ENABLE_LOGIN_TWITTER`                                  | Enable Logging in from Twitter  | `false` |         |
| `TWITTER_APP_ID`                                        | Application ID                  |         | x       |
| `TWITTER_APP_SECRET`                                    | Application Secret              |         | x       |
| `TWITTER_AUTO_CONFIRM_EMAIL`                            | Auto confirm email address      | `false` |         |
| `TWITTER_AUTO_REGISTER`                                 | Auto register username          | `false` |         |
|                                                         |
| * <https://www.bookstackapp.com/docs/admin/social-auth> |


#### Cache and Session Settings

| Parameter               | Description                                                                    | Default             | `_FILE` |
| ----------------------- | ------------------------------------------------------------------------------ | ------------------- | ------- |
| `CACHE_DRIVER`          | Use what backend for cache `file` `database` `redis` `memcached`               | `file`              |         |
| `CACHE_PREFIX`          | Cache Prefix                                                                   | `bookstack`         |         |
| `SESSION_COOKIE_NAME`   | Cookie Name                                                                    | `bookstack_session` |         |
| `SESSION_DRIVER`        | Use what backend for sesssion management `file` `database` `redis` `memcached` | `FILE`              |         |
| `SESSION_LIFETIME`      | How long in minutes for Ssession                                               | `120`               |         |
| `SESSION_SECURE_COOKIE` | Deliver HTTPS cookie                                                           | `true`              |         |
| `MEMCACHED_HOST`        | Memcached Hostname                                                             |                     | x       |
| `MEMCACHED_PORT`        | Memcached Port                                                                 | `11211`             |         |
| `MEMCACHED_WEIGHT`      | Memcached Weight                                                               | `100`               |         |
| `REDIS_DB`              | Redis DB                                                                       | `0`                 | x       |
| `REDIS_PORT`            | Redis Port                                                                     | `6379`              | x       |
| `REDIS_HOST`            | Redis Hostname                                                                 |                     | x       |

* <https://www.bookstackapp.com/docs/admin/cache-session-config>

#### Mail Settings

| Parameter        | Description                             | Default                 | `_FILE` |
| ---------------- | --------------------------------------- | ----------------------- | ------- |
| `MAIL_FROM_NAME` | Display name to be sent from Bookstack  | `BookStack`             |         |
| `MAIL_FROM`      | Email address to be sent from Bookstack | `bookstack@example.com` |         |
| `MAIL_TYPE`      | How to send mail - `SMTP`               | `SMTP`                  |         |
| `SMTP_HOST`      | Hostname of SMTP Server                 | `postfix-relay`         | x       |
| `SMTP_PASS`      | SMTP Password                           | `null`                  | x       |
| `SMTP_PORT`      | SMTP Port                               | `25`                    | x       |
| `SMTP_TLS`       | Enable TLS for SMTP Connections         | `FALSE`                 |         |
| `SMTP_USER`      | SMTP Username                           | `null`                  | x       |

* <https://www.bookstackapp.com/docs/admin/email-config>

#### Storage Settings

| Parameter                 | Description                                                              | Default        | `FILE` |
| ------------------------- | ------------------------------------------------------------------------ | -------------- | ------ |
| `STORAGE_TYPE`            | How to store files `local` `local_secure` `s3`                           | `local`        |        |
| `STORAGE_ATTACHMENT_TYPE` | Attachment storage type                                                  | `local_secure` |        |
| `STORAGE_IMAGE_TYPE`      | Image storage type                                                       | `local`        |        |
| `STORAGE_S3_BUCKET`       | S3 Bucket                                                                |                | x      |
| `STORAGE_S3_KEY`          | S3 Key                                                                   |                | x      |
| `STORAGE_S3_REGION`       | S3 Region                                                                |                | x      |
| `STORAGE_S3_SECRET`       | S3 Key                                                                   |                | x      |
| `STORAGE_URL`             | Set this if you are connecting to a compatible service like Minio/Wasabi |                | x      |

* <https://www.bookstackapp.com/docs/admin/upload-config>

* * *

## Maintenance

### Shell Access

For debugging and maintenance, `bash` and `sh` are available in the container.

## Support & Maintenance

* For community help, tips, and community discussions, visit the [Discussions board](/discussions).
* For personalized support or a support agreement, see [Nfrastack Support](https://nfrastack.com/).
* To report bugs, submit a [Bug Report](issues/new). Usage questions will be closed as not-a-bug.
* Feature requests are welcome, but not guaranteed. For prioritized development, consider a support agreement.
* Updates are best-effort, with priority given to active production use and support agreements.

## References

* <https://www.bookstackapp.com/docs>

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


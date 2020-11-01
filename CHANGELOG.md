## 1.3.6 2020-10-31 <dave at tiredofit dot ca>

   ### Added
      - Bookstack 0.30.4


## 1.3.5 2020-10-20 <dave at tiredofit dot ca>

   ### Changed
      - Fix Exclude email once and for all


## 1.3.4 2020-10-20 <dave at tiredofit dot ca>

   ### Changed
      - Fix for LDAP_SYNC_EXCLUDE_EMAIL


## 1.3.3 2020-10-20 <dave at tiredofit dot ca>

   ### Added
      - Add custom script support for LDAP sync


## 1.3.2 2020-10-20 <dave at tiredofit dot ca>

   ### Added
      - Add LDAP_SYNC_BEGIN argument to schedule LDAP syncing to start


## 1.3.1 2020-10-20 <dave at tiredofit dot ca>

   ### Added
      - Add option to start optimizing images at specific time along with interval


## 1.3.0 2020-10-20 <dave at tiredofit dot ca>

   ### Added
      - Add automatic image optimization schedule via optipng and jpegoptim


## 1.2.3 2020-10-19 <dave at tiredofit dot ca>

   ### Added
      - Add excluding from LDAP Sync command


## 1.2.2 2020-10-18 <dave at tiredofit dot ca>

   ### Changed
      - Tweaks to LDAP Sync routine scheduler


## 1.2.1 2020-10-18 <dave at tiredofit dot ca>

   ### Added
      - Add MAP_THEMES environment variable to map it to /data for persistence


## 1.2.0 2020-10-18 <dave at tiredofit dot ca>

   ### Added
      - Redo LDAP Sync routines to have better scheduling support


## 1.1.10 2020-10-18 <dave at tiredofit dot ca>

   ### Changed
      - Fix for auto upgrade function
      - Fix for Cron LDAP Sync routines
      - Cleanup extra fi


## 1.1.9 2020-10-18 <dave at tiredofit dot ca>

   ### Added
      - Add initial LDAP synchronization routine on startup of container if Auth set to LDAP and Sync enabled


## 1.1.8 2020-10-18 <dave at tiredofit dot ca>

   ### Added
      - Add SSO support for out of tree modification


## 1.1.7 2020-10-13 <dave at tiredofit dot ca>

   ### Added
      - Bookstack v0.30.3


## 1.1.6 2020-09-30 <dave at tiredofit dot ca>

   ### Added
      - Bookstack v.30.2


## 1.1.5 2020-09-26 <dave at tiredofit dot ca>

   ### Added
      - Bookstack 0.30.1


## 1.1.4 2020-09-20 <dave at tiredofit dot ca>

   ### Added
      - Bookstack 0.30.0


## 1.1.3 2020-09-05 <dave at tiredofit dot ca>

   ### Changed
      - Stop looking for custom assets twice


## 1.1.2 2020-09-03 <dave at tiredofit dot ca>

   ### Added
      - Adjustment to Sync User Filter name in .env


## 1.1.1 2020-09-03 <dave at tiredofit dot ca>

   ### Changed
      - Fixes for LDAP support


## 1.1.0 2020-08-20 <dave at tiredofit dot ca>

   ### Added
      - Pull version from customizable GIT source and branch
      - Add routines to support upcoming LDAP_SYNC_USER functionality


## 1.0.2 2020-07-29 <dave at tiredofit dot ca>

   ### Added
      - Add `PDF_EXPORT` environment variable to switch between domPDF and wkhtmltoPDF
      - Added functionality to copy custom files from /assets/custom overtop of the nginx webroot on startup
      - Added functionality to execute custom scripts from /assets/custom-scripts/ to perform actions on container startup to extend image


## 1.0.1 2020-07-12 <dave at tiredofit dot ca>

   ### Added
      - Add logrotation for bookstack/laravel logs


## 1.0.0 2020-07-07 <dave at tiredofit dot ca>

   ### Added
      - Initial Release of Image
      - Bookstack 0.29.3
      - Custom Generating configuration on bootup
      - Admin User and Password Generation on first startup

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

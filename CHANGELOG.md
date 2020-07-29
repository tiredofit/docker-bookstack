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

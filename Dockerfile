FROM php:8.2-fpm

LABEL "language"="php"
LABEL "framework"="laravel"

ENV APP_ENV=production
ENV APP_DEBUG=false

WORKDIR /var/www

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    nginx \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . .

RUN composer install --no-dev --optimize-autoloader

RUN php artisan key:generate

RUN php artisan migrate --force

RUN cat <<'EOF' > /etc/nginx/sites-enabled/default
server {
    listen 8080;
    root /var/www/public;
    
    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";
    
    index index.php index.html;
    charset utf-8;
    
    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt { access_log off; log_not_found off; }
    
    error_page 404 /index.php;
    
    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT $realpath_root;
    }
    
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }
    
    error_log /dev/stderr;
    access_log /dev/stderr;
}
EOF

RUN chown -R www-data:www-data /var/www

EXPOSE 8080

CMD service php8.2-fpm start && nginx -g "daemon off;"


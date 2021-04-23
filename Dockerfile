FROM php:7.3-fpm

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
  git \
  procps \
  wget \
  git-core \
  build-essential \
  openssl \
  curl \
  default-mysql-client \
  libzip-dev \
  libssl-dev \
  libpng-dev \
  libonig-dev \
  libxml2-dev \
  libcurl3-dev \
  zip \
  unzip

# Download and execute node bash
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

# Install nodejs
RUN apt-get install -y nodejs

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install \
  pdo \
  mbstring \
  curl \
  exif \
  zip \
  pcntl \
  bcmath \
  gd \
  intl \
  mysqli \
  pdo_mysql \
  opcache \
  soap \
  xmlrpc

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

EXPOSE 9000

CMD ["php-fpm", "--nodaemonize"]
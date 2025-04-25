# Image de base officielle R
FROM r-base:latest

# Installation de packages système nécessaires
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Copier ton code dans le conteneur
COPY . /app
WORKDIR /app

# Installer des packages R depuis le CRAN
RUN Rscript -e "install.packages(c('tidyverse', 'data.table'), repos='https://cloud.r-project.org')"

# Commande par défaut
CMD ["Rscript", "main.R"]

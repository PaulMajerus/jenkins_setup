FROM jenkins/jenkins:latest

# Passer en root pour installer les dépendances
USER root

# Installer dépendances Linux nécessaires à R + renv
RUN apt-get update && apt-get install -y --no-install-recommends \
    dirmngr \
    gnupg \
    wget \
    ca-certificates \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libpq-dev \
    git

# Adds a source where R 4.4.0 is available
# we need R 4.4 for some packages
RUN echo "deb https://cloud.r-project.org/bin/linux/debian bookworm-cran40/" > /etc/apt/sources.list.d/cran.list\
    && apt-get update --allow-insecure-repositories || true \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
       r-base r-base-dev

# Installer renv et faire le consentement global
RUN Rscript -e "install.packages('renv', repos='https://cloud.r-project.org')" \
    && Rscript -e "renv::consent(provided=TRUE)"

# Revenir à l'utilisateur Jenkins
USER jenkins

# Exposer le port de Jenkins
EXPOSE 8080

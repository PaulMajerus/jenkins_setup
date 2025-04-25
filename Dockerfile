FROM jenkins/jenkins:latest

# Passer en root pour installer les dépendances
USER root

# Installer dépendances Linux nécessaires à R + renv
RUN apt-get update && apt-get install -y \
    r-base \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Installer renv et faire le consentement global
RUN Rscript -e "install.packages('renv', repos='https://cloud.r-project.org')" \
    && Rscript -e "renv::consent(provided=TRUE)"

# Revenir à l'utilisateur Jenkins
USER jenkins

# Exposer le port de Jenkins
EXPOSE 8080

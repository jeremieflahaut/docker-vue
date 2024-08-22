# Utiliser une image Node.js officielle comme base
FROM node:latest

# Argument pour ajuster l'UID de l'utilisateur 'node'
ARG USER_ID

# Mettre à jour l'UID de l'utilisateur 'node' et changer le propriétaire des répertoires
RUN usermod -u $USER_ID node && \
    mkdir -p /app && \
    chown -R node:node /home/node && \
    chown -R node:node /app

# Définir l'utilisateur 'node' comme utilisateur par défaut
USER node

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Exposer le port pour l'application Vue.js
EXPOSE 3000

# Commande pour installer les dépendances et démarrer l'application
CMD ["sh", "-c", "npm install && npm run dev"]

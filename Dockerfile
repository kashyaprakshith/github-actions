FROM node:14
 
WORKDIR /usr/src/app
 
COPY package.json ./package.json
COPY package-lock.json ./package-lock.json
RUN npm ci
 
COPY . .
 
EXPOSE 3000
 
CMD [ "npm", "run", "dev" ]
 
FROM development as dev-envs
RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends git
EOF
 
 
# install Docker tools (cli, buildx, compose)
COPY --from=gloursdocker/docker / /
CMD [ "npm", "run", "dev" ]

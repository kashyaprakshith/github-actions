# Stage 1: Development Environment
FROM node:14 as development

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies for development
RUN npm install

RUN npm ci

# Copy the rest of the application files
COPY . .

# Expose the port your Node.js app is listening on
EXPOSE 3000

# Start your Node.js application in development mode
CMD ["npm", "run", "dev"]



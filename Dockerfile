# Stage 1: Development Environment
FROM node:14 as development

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies for development
RUN npm install

# Copy the rest of the application files
COPY . .

# Expose the port your Node.js app is listening on
EXPOSE 3000

# Start your Node.js application in development mode
CMD ["npm", "run", "dev"]

# Stage 2: Production Environment
FROM node:14 as production

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies for production
RUN npm ci --only=production

# Copy the rest of the application files
COPY . .

# Expose the port your Node.js app is listening on
EXPOSE 3000

# Start your Node.js application in production mode
CMD ["npm", "start"]

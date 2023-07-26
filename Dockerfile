FROM node:lts-alpine

# Copy package.json and package-lock.json
COPY package.json package-lock.json index.js ./

# Install dependencies for development
RUN npm ci

# Expose the port your Node.js app is listening on
EXPOSE 3000

# Start your Node.js application
CMD ["npm", "start"]
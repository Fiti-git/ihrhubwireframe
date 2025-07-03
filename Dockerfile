# Step 1: Build the React app
FROM node:16 AS build

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Set Node.js memory limit to 512MB (adjust based on your needs)
RUN node --max-old-space-size=512 /app/node_modules/.bin/react-scripts build

# Step 2: Serve the React app using NGINX
FROM nginx:alpine

# Copy the built React app from the build stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]

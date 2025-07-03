# Step 1: Build the React app
FROM node:16 AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy all files from your local machine to the container
# Ensure public/ and src/ are included in the Docker context
COPY . ./

# Set Node.js memory limit to 1024MB (1GB)
RUN node --max-old-space-size=1024 /app/node_modules/.bin/react-scripts build

# Step 2: Serve the React app using NGINX
FROM nginx:alpine

# Copy the built React app from the build stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]

FROM node:20-alpine

WORKDIR /app

# Copy ONLY package.json so we don't drag any old lockfiles in
COPY package.json ./

# Install dependencies using standard npm
RUN npm install --legacy-peer-deps

# Copy the rest of the application code
COPY . .

# Build the Next.js application
RUN npm run build

# Expose the port Next.js runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]

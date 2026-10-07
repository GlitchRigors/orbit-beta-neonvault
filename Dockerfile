FROM node:18-alpine

WORKDIR /app

# Install pnpm
RUN npm install -g pnpm

# Disable pnpm v9 strict script approval so Next.js binaries can download
RUN pnpm config set ignore-scripts false

# Copy package management files
COPY package.json pnpm-lock.yaml* ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Build the Next.js application
RUN pnpm build

# Expose the port Next.js runs on
EXPOSE 3000

# Start the application
CMD ["pnpm", "start"]

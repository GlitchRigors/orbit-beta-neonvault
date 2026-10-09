FROM node:20-alpine

WORKDIR /app

# Copy ONLY package.json
COPY package.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy the rest of the application code
COPY . .

# Inject build-time dummy secrets so Next.js static evaluation doesn't crash on uninitialized services
ENV STRIPE_SECRET_KEY=sk_test_placeholder_key_for_build_12345
ENV STRIPE_WEBHOOK_SECRET=whsec_placeholder_key_for_build_12345
ENV POSTGRES_URL=postgresql://dummy:dummy@localhost:5432/dummy
ENV BASE_URL=http://localhost:3000
ENV AUTH_SECRET=dummy_auth_secret_minimum_32_characters_long_for_build

# Build the Next.js application
RUN npm run build

# Expose the port Next.js runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]

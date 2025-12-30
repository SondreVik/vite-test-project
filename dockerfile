# Stage 1: Build the Vite application
FROM node:20-alpine AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Run the Node.js server
FROM node:20-alpine AS production-stage
WORKDIR /app
COPY --from=build-stage /app/.output /app/.output
COPY --from=build-stage /app/package*.json ./
# Expose port 3000 (default for TanStack Start)
EXPOSE 3000
CMD ["node", ".output/server/index.mjs"]

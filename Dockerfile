# We'll use a specific version for stability, e.g., 24-alpine for a smaller image.
FROM node:24-alpine

# Install pnpm globally
RUN npm install -g pnpm@10.10.0

# Set the working directory inside the container
WORKDIR /app

# This step installs dependencies first, so if only source code changes, pnpm install isn't re-run.
COPY package.json pnpm-lock.yaml* ./

# Install project dependencies using pnpm
RUN pnpm i

# Copy the rest of your application code to the container
COPY . .

# Build the Astro project for production using pnpm
# This runs 'pnpm run build' as defined in your package.json scripts
RUN pnpm run build

# Expose the port that Astro's preview server will run on
EXPOSE 7777

# Command to run the application when the container starts
CMD ["pnpm", "run", "dev"]
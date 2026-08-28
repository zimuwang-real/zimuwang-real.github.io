# Base image: Ruby with necessary dependencies for Jekyll
FROM ruby:3.2

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    && rm -rf /var/lib/apt/lists/*


# Create a non-root user with UID 1000
RUN groupadd -g 1000 vscode && \
    useradd -m -u 1000 -g vscode vscode

# Set the working directory
WORKDIR /usr/src/app

# Set permissions for the working directory
RUN chown -R vscode:vscode /usr/src/app

# Switch to the non-root user
USER vscode

# Copy the dependency manifest and lockfile so local builds use the same
# versions as GitHub Pages.
COPY --chown=vscode:vscode Gemfile Gemfile.lock ./



# Install bundler and dependencies
RUN gem install connection_pool:2.5.0
RUN gem install bundler:2.6.3
RUN bundle install

# Ignore a host-mounted .bundle/config file when the repository is mounted at
# runtime; gems are installed in the image's default bundle path.
ENV BUNDLE_IGNORE_CONFIG=1

# Command to serve the Jekyll site
CMD ["jekyll", "serve", "-H", "0.0.0.0", "-w", "--config", "_config.yml,_config_docker.yml"]

# Use AlpineLinux as base image
FROM alpine:3.20

# Install Git
RUN apk add --no-cache bash git openssh

# Install Supervisor
RUN apk add --no-cache \
    supervisor

# Install Python and needed python modules
RUN apk add --no-cache \
    python3 \
    py3-requests

# Install NSD
RUN apk add --no-cache \
    nsd

# Copy supervisor config
COPY conf/supervisord.conf /etc/supervisord.conf

COPY conf/gitconfig /etc/gitconfig

# Copy our Scripts
COPY --chmod=755 scripts/* /usr/bin/

# Add any user custom scripts + set permissions
COPY --chmod=755 custom_scripts /custom_scripts

# Expose Webhook port
EXPOSE 8555

# run start script
CMD ["/bin/bash", "/usr/bin/start.sh"]

FROM docker.io/cloudflare/sandbox:0.7.0

# Install Node.js 22 (required by OpenClaw) and rclone (for R2 persistence)
# The base image has Node 20, we need to replace it with Node 22
# Using direct binary download for reliability
ENV NODE_VERSION=22.13.1
RUN ARCH="$(dpkg --print-architecture)" \
    && case "${ARCH}" in \
         amd64) NODE_ARCH="x64" ;; \
         arm64) NODE_ARCH="arm64" ;; \
         *) echo "Unsupported architecture: ${ARCH}" >&2; exit 1 ;; \
       esac \
    && apt-get update && apt-get install -y xz-utils ca-certificates rclone \
    && curl -fsSLk https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.xz -o /tmp/node.tar.xz \
    && tar -xJf /tmp/node.tar.xz -C /usr/local --strip-components=1 \
    && rm /tmp/node.tar.xz \
    && node --version \
    && npm --version

# Install pnpm globally
RUN npm install -g pnpm

# Install OpenClaw (formerly clawdbot/moltbot) and ws for generated Node scripts.
# Pin versions for reproducible builds.
RUN npm install -g openclaw@2026.2.3 ws@8.18.0 \
    && openclaw --version \
    && node -e "require('/usr/local/lib/node_modules/ws/lib/websocket.js'); console.log('ws installed')"

# Allow plain `require('ws')` from arbitrary workspace scripts.
ENV NODE_PATH=/usr/local/lib/node_modules

# Create OpenClaw directories
# Legacy .clawdbot paths are kept for R2 backup migration
RUN mkdir -p /root/.openclaw \
    && mkdir -p /root/clawd \
    && mkdir -p /root/clawd/skills \
    && mkdir -p /workspace/docs/reference/templates \
    && mkdir -p /root/clawd/docs/reference/templates

# Copy startup script
# Build cache bust: 2026-02-24-v34-template-primary-sync
COPY start-openclaw.sh /usr/local/bin/start-openclaw.sh
RUN chmod +x /usr/local/bin/start-openclaw.sh

# Package workspace templates expected by OpenClaw bootstrap/runtime.
COPY docs/reference/templates/ /workspace/docs/reference/templates/
COPY docs/reference/templates/ /root/clawd/docs/reference/templates/
RUN if [ -d /usr/local/lib/node_modules/openclaw/docs/reference/templates ]; then \
      cp -f /workspace/docs/reference/templates/*.md /usr/local/lib/node_modules/openclaw/docs/reference/templates/; \
    fi \
    && if [ -d /usr/local/lib/node_modules/openclaw/dist/docs/reference/templates ]; then \
      cp -f /workspace/docs/reference/templates/*.md /usr/local/lib/node_modules/openclaw/dist/docs/reference/templates/; \
    fi

# Copy custom skills
COPY skills/ /root/clawd/skills/

# Set working directory
WORKDIR /root/clawd

# Expose the gateway port
EXPOSE 18789

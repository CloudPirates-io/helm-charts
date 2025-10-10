# Multi-stage build for OpenLDAP from source
# Build stage
FROM debian:12-slim AS builder

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    git \
    groff-base \
    libdb-dev \
    libsasl2-dev \
    libssl-dev \
    libtool \
    libltdl-dev \
    libodbc1 \
    unixodbc-dev \
    openssl \
    pkg-config \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Set OpenLDAP version
ARG OPENLDAP_VERSION=2.6.9
ARG OPENLDAP_SHA256=2cb7dc73e9c8340dff0d99357fbaa578abf30cc6619f0521972c555681e6b2ff

# Download and verify OpenLDAP source
WORKDIR /tmp
RUN wget -O openldap.tar.gz "https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-${OPENLDAP_VERSION}.tgz" && \
    echo "${OPENLDAP_SHA256}  openldap.tar.gz" | sha256sum -c - && \
    tar -xzf openldap.tar.gz && \
    rm openldap.tar.gz

# Build OpenLDAP
WORKDIR /tmp/openldap-${OPENLDAP_VERSION}
RUN ./configure \
    --prefix=/usr/local/openldap \
    --enable-slapd \
    --enable-modules \
    --enable-mdb=yes \
    --enable-ldap=yes \
    --enable-meta=yes \
    --enable-asyncmeta=yes \
    --enable-null=yes \
    --enable-passwd=yes \
    --enable-relay=yes \
    --enable-sock=yes \
    --enable-sql=mod \
    --enable-overlays=mod \
    --with-tls=openssl \
    --with-cyrus-sasl \
    && make depend \
    && make -j$(nproc) \
    && make install

# Runtime stage
FROM debian:12-slim

# Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libdb5.3 \
    libsasl2-2 \
    libssl3 \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Copy OpenLDAP binaries from builder
COPY --from=builder /usr/local/openldap /usr/local/openldap

# Create OpenLDAP directories
RUN mkdir -p /var/lib/ldap /etc/ldap/slapd.d /run/slapd && \
    chmod 755 /var/lib/ldap /etc/ldap/slapd.d /run/slapd

# Create openldap user and group
RUN groupadd -r -g 389 openldap && \
    useradd -r -u 389 -g openldap -d /var/lib/ldap -s /usr/sbin/nologin -c "OpenLDAP Server Account" openldap && \
    chown -R openldap:openldap /var/lib/ldap /etc/ldap/slapd.d /run/slapd

# Set PATH
ENV PATH="/usr/local/openldap/bin:/usr/local/openldap/sbin:${PATH}"

# Expose LDAP and LDAPS ports
EXPOSE 389 636

# Set working directory
WORKDIR /var/lib/ldap

# Run as openldap user
USER openldap

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
    CMD ldapsearch -x -b "" -s base "(objectclass=*)" namingContexts || exit 1

# Default command
CMD ["slapd", "-d", "256", "-h", "ldap:/// ldaps:///", "-u", "openldap", "-g", "openldap"]

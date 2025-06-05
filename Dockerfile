# ---------- Stage 1: Build ----------
FROM rust:1.87.0-bullseye as builder

WORKDIR /usr/src/app

# Cache dependencies
COPY Cargo.toml Cargo.lock ./
RUN mkdir src && echo "fn main() {}" > src/main.rs
RUN cargo build --release
RUN rm -rf src

# Copy actual source and build
COPY . .
RUN cargo build --release

# ---------- Stage 2: Runtime ----------
FROM debian:bullseye

RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/src/app/target/release/helprly /usr/local/bin/helprly

EXPOSE 8000

CMD ["helprly"]
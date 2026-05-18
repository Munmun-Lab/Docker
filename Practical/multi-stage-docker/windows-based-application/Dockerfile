# =========================
# Stage 1 - Build Stage
# =========================

FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS builder

WORKDIR /src

# Copy source code
COPY . .

# Build application
RUN msbuild MyWebApp/MyWebApp.csproj /p:Configuration=Release


# =========================
# Stage 2 - Runtime Stage
# =========================

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8

WORKDIR /inetpub/wwwroot

# Copy built application from builder stage
COPY --from=builder /src/MyWebApp/bin/Release/ .

# Expose IIS port
EXPOSE 80

# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:9.0-alpine AS build
WORKDIR /src

# Copy the project files
COPY /app/app.csproj .
RUN dotnet restore

# Copy the rest of the source code
COPY app /src

# Build the application
RUN dotnet publish -c Release -o ./publish

# Stage 2: Create the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:9.0-alpine AS runtime
WORKDIR /app

# Copy the published application from the build stage
COPY --from=build /src/publish .

# Expose the port your application will run on
EXPOSE 5000

# Set the entry point for the application
ENTRYPOINT ["dotnet", "app.dll"]
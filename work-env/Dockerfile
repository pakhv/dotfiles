FROM debian

RUN apt-get update && apt-get install -y build-essential \
    && apt-get update && apt-get install -y curl \
    && apt-get update && apt-get install -y git \
    && apt-get update && apt-get install -y unzip \
    && apt-get update && apt-get install ripgrep -y

RUN apt-get update && apt-get install -y ca-certificates curl gnupg \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install nodejs -y
    
RUN curl -fsSL https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -o packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get update && apt-get install -y dotnet-sdk-7.0

ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]
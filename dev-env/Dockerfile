FROM cicd.ossdep.rt.ru:5002/mcr.microsoft.com/sdk:7.0

EXPOSE 8080

RUN mkdir /etc/apt/keyrings

RUN apt-get update && apt-get install -y ca-certificates curl gnupg \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install nodejs -y

RUN apt-get update && apt-get install build-essential -y \
    && apt-get update && apt-get install unzip -y \
    && apt-get update && apt-get install grep -y

ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]

FROM golang:1.21.5-alpine3.19

WORKDIR /api-service

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod go.sum ./

# Download all the dependencies
RUN go mod download && go mod verify

# Compile daemon for hot reloading
RUN go install -mod=mod github.com/githubnemo/CompileDaemon

COPY . .

EXPOSE 7200

ENTRYPOINT CompileDaemon -build="go build -o /usr/local/bin/app -v" -command="/usr/local/bin/app" -directory="./cmd" -exclude-dir=".data" exclude-dir=".git" -exclude=".#*" -color=true -log-prefix=true -graceful-kill=true 
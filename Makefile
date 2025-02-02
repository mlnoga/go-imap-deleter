# Set target based on platform
OS := $(shell uname -s)
ifeq ($(OS), Windows_NT)
    TARGET = go-imap-backup.exe
else
    TARGET = go-imap-backup
endif


all: $(TARGET)

$(TARGET): *.go
	go build

install: $(TARGET)
	sudo cp $(TARGET) /usr/local/bin/$(TARGET)
	sudo chown root:root /usr/local/bin/$(TARGET)
	sudo chmod 755 /usr/local/bin/$(TARGET)

commit: $(TARGET)
	go fmt
	golangci-lint run
	go mod tidy
	go build
	go test

test:
	go test

clean:
	rm -f $(TARGET) $(TARGET).exe

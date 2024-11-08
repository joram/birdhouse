BOARD?=esp32:esp32:esp32s3:CDCOnBoot=cdc
PORT?=/dev/tty.usbmodem14*
BUILD=build

.PHONY: default lint all flash clean

default: lint all flash clean

lint:
	cpplint --extensions=ino --filter=-legal/copyright *.ino

all:
	arduino-cli compile --fqbn $(BOARD) --output-dir $(BUILD) ./

flash:
	arduino-cli upload --fqbn $(BOARD) --port $(PORT) --input-dir $(BUILD)

clean:
	rm -r build

install-dependencies:
	apt install cpplint
#	wget https://downloads.arduino.cc/arduino-cli/arduino-cli_latest_Linux_64bit.tar.gz -O arduino-cli.tar.gz
#	tar -xvf arduino-cli.tar.gz
	sudo mv arduino-cli /usr/local/bin
	arduino-cli core update-index
	arduino-cli core install esp32:esp32
	rm ./arduino-cli.tar.gz
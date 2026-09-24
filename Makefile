FILE ?= Main.java

.PHONY: all run clean

all: run

run:
	@bash ./run.sh "$(FILE)"

clean:
	@rm -rf .build
	@echo "Build directory cleaned."
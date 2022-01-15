GENERATE-DATA-EXECUTABLE=$(shell swift build --show-bin-path)/generate-data
BINARY_NAME=budoux-swift
EXECUTABLE=$(shell swift build --configuration release --product $(BINARY_NAME) --show-bin-path --arch arm64 --arch x86_64)/$(BINARY_NAME)

ifeq ($(shell uname -m),arm64)
BINARIES_FOLDER=/opt/homebrew/bin
else
BINARIES_FOLDER=/usr/local/bin
endif

.PHONY: format lint check-env clean

generate_data: clean
		swift build --product generate-data && $(GENERATE-DATA-EXECUTABLE)

update_model: generate_data format

format:
	swift-format format --parallel --in-place --ignore-unparsable-files --recursive ./Sources ./Tests ./Tools

lint:
	swift-format lint --parallel --recursive ./Sources --recursive ./Tests

check-env:
	if test "$(SIGNING_IDENTIFIER)" = "" ; then \
		echo "SIGNING_IDENTIFIER not set"; \
		exit 1; \
	fi

build_cli:
	swift build -c release --product $(BINARY_NAME) --arch arm64 --arch x86_64

install: clean build_cli
	install -d "$(BINARIES_FOLDER)"
	install "$(EXECUTABLE)" "$(BINARIES_FOLDER)"

clean:
	swift package clean

# You need to define `SIGNING_IDENTIFIER` environment variable. the value looks like "Developer ID Application: <TEAM NAME> (<TEAM_ID>)". You can see <TEAM NAME> and <TEAM_ID> at https://developer.apple.com/account/#!/membership
release_zip: check-env install
	# make sure `xcrun notarytool` exists.
	xcrun notarytool --help
	rm -rf release_binary
	rm -rf release_binary.zip
	mkdir release_binary
	cp "$(EXECUTABLE)" release_binary
	cp "README.md" release_binary
	codesign --force --options runtime --deep-verify --verbose --sign "$(SIGNING_IDENTIFIER)" release_binary/"$(BINARY_NAME)"
	ditto -c -k --keepParent release_binary release_binary.zip
	rm -rf release_binary
	xcrun notarytool submit ./release_binary.zip --keychain-profile 'AC_PASSWORD' --wait

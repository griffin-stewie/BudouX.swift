GENERATE-DATA-EXECUTABLE=$(shell swift build --show-bin-path)/generate-data

.PHONY: update_data clean

update_data:
	swift build --product generate-data && $(GENERATE-DATA-EXECUTABLE)

clean:
	swift package clean

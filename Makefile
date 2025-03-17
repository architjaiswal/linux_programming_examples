# Compiler
CC = gcc
CFLAGS = -Wall -Wextra -Ilib # Adding -Werror flag will treat all compilation warnings are errors

# Directories
SRC_DIR = lib
OBJ_DIR = obj

# Find all headers recursively included in main.c
HEADERS := $(shell cat JSR_test_code.c $(wildcard $(SRC_DIR)/*.h) | grep -oE '#include "([^"]+)"' | cut -d'"' -f2 | sort -u)

# Map headers to their corresponding .c files
SOURCES := $(foreach hdr, $(HEADERS), $(wildcard $(SRC_DIR)/$(hdr:.h=.c))) JSR_test_code.c
OBJECTS := $(SOURCES:%.c=$(OBJ_DIR)/%.o)

# Executable name
TARGET = JSR_test_executable

# Create object directory if not exists
$(shell mkdir -p $(OBJ_DIR)/$(SRC_DIR))

# Default target
all: $(TARGET)

# Linking
$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) $^ -o $@

# Compilation
$(OBJ_DIR)/%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean
clean:
	rm -rf $(OBJ_DIR) $(TARGET)

# Phony targets
.PHONY: all clean

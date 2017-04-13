CC?=gcc
SIZE?=size
OUTPUT=output
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
project_name=$(notdir $(current_dir))

INCLUDE+= -I. 

SRCS+= main.c 
CFLAGS+=-std=c99

OBJS+=$(patsubst %.c,%.o,$(SRCS))
OBJECTS=$(addprefix $(OUTPUT)/, $(OBJS))

$(OUTPUT)/%.o:%.c
	mkdir -p $(@D)
	$(CC)  $(INCLUDE) $(CFLAGS) -c $< -o $@

all: INIT_DIR $(OUTPUT)/$(project_name) showsize

INIT_DIR:
	$(shell mkdir -p ${OUTPUT} 2>/dev/null)

$(OUTPUT)/$(project_name): $(OBJECTS) 
	$(CC) -o $@ $^ $(INCLUDE)

showsize:
	$(SIZE) -B $(OUTPUT)/$(project_name)
clean:
	rm -R output/
MAKEFILE_DIR := .

# Where compiled objects are stored.
OBJDIR := $(MAKEFILE_DIR)/gen/obj/
BINDIR := $(MAKEFILE_DIR)

CXX := gcc
CXXOPTS := --std=c++17 -O3 -DNDEBUG
INCLUDES := -I.
LDOPTS := --std=c++17
LIBS := -lstdc++ -lm

EXECUTABLE_PATH := $(BINDIR)/extract_loudest_section

EXECUTABLE_SRCS := $(wildcard ./*.cc)
EXECUTABLE_OBJS := $(addprefix $(OBJDIR), \
$(patsubst %.cc,%.o,$(patsubst %.c,%.o,$(EXECUTABLE_SRCS))))

$(OBJDIR)%.o: %.cc
	@mkdir -p $(dir $@)
	$(CXX) $(CXXOPTS) $(INCLUDES) -c $< -o $@

all: $(EXECUTABLE_PATH)

$(EXECUTABLE_PATH): $(EXECUTABLE_OBJS)
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(INCLUDES) \
	-o $(EXECUTABLE_PATH) $(EXECUTABLE_OBJS) \
	$(LDOPTS) $(LIBS)

clean:
	rm -rf $(MAKEFILE_DIR)/gen

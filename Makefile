# if your compiler doesn't support hard then use 'make -i'
# or comment out hard stuff here

HARD=-mfloat-abi=hard
# unimp -mapcs-float, needs gcc 4.5
SOFT=-mfloat-abi=soft
SOFTFP=-mfloat-abi=softfp
NEON=-mfpu=neon
VFP=-mfpu=vfpv3-d16
VECTOR=-ftree-vectorize
COMMON=-O9 -std=c99 -march=armv7-a

# Command line arguments to the test program
# -------------------------------------------
ARGS=2.200002 2.200001 5

# Source file with the program
# ----------------------------
SOURCE=test.c

# List of unique test-case identifiers
# -----------------------------------
TEST_CASES = \
	soft \
	soft-neon \
	soft-neon-vector   \
	hard \
	hard-neon \
	hard-neon-vector \
	hard-vfp \
	hard-vfp-neon \
	hard-vfp-neon-vector  \
	softfp \
	softfp-vfp \
	softfp-neon \
	softfp-neon-vector \
	softfp-vfp-neon \
	softfp-vfp-neon-vector \
	default

# Make binary file names
# ----------------------
BIN_PREFIX = bin
TEST_CASE_BIN_FILES = $(addprefix $(BIN_PREFIX)-,$(TEST_CASES))

# For each entry from $(TEST_CASE), add a combination of settings
# ---------------------------------------------------------------
$(BIN_PREFIX)-soft-settings =               $(SOFT)
$(BIN_PREFIX)-soft-neon-settings =          $(SOFT) $(NEON)
$(BIN_PREFIX)-soft-neon-vector-settings =   $(SOFT) $(NEON) $(VECTOR)

$(BIN_PREFIX)-hard-settings =                  $(HARD)
$(BIN_PREFIX)-hard-neon-settings =             $(HARD) $(NEON)
$(BIN_PREFIX)-hard-neon-vector-settings =      $(HARD) $(NEON) $(VECTOR)
$(BIN_PREFIX)-hard-vfp-settings =              $(HARD) $(NEON) 
$(BIN_PREFIX)-hard-vfp-neon-settings =         $(HARD) $(VFP) $(NEON) 
$(BIN_PREFIX)-hard-vfp-neon-vector-settings =  $(HARD) $(VFP) $(NEON) $(VECTOR)

$(BIN_PREFIX)-softfp-settings =                 $(SOFTFP) 
$(BIN_PREFIX)-softfp-vfp-settings =		$(SOFTFP) $(VFP) 
$(BIN_PREFIX)-softfp-neon-settings =		$(SOFTFP) $(NEON) 
$(BIN_PREFIX)-softfp-neon-vector-settings =	$(SOFTFP) $(NEON) $(VECTOR) 
$(BIN_PREFIX)-softfp-vfp-neon-settings =	$(SOFTFP) $(VFP) $(NEON) 
$(BIN_PREFIX)-softfp-vfp-neon-vector-settings =	$(SOFTFP) $(VFP) $(NEON) $(VECTOR) 

$(BIN_PREFIX)-default-settings = 

# Default target (all), then loop over all the test cases
# -------------------------------------------------------
all: $(TEST_CASE_BIN_FILES)
	for i in $(TEST_CASE_BIN_FILES) ; do \
		./$$i $(ARGS); \
	done

clean:
	rm -rf $(TEST_CASE_BIN_FILES)


# Single recipe
# --------------------
$(BIN_PREFIX)-%: $(SOURCE) Makefile
	cc $< $(COMMON) $($@-settings) -o $@

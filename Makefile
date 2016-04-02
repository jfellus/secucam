
###### INSTALLATION GUIDE ######
# make external_libs
# make
# ./coeos++
################################


APT_GET_DEPENDENCIES:= 


REQUIRED_PACKAGES:= 
REQUIRED_LIBS:=pthread dl jpeg


INCLUDE_PATHS:=

SRC_DIR:=./src

EXECUTABLE:=test







########################## DON'T EDIT BELOW THIS LINE (unless you are a gnu make's expert ##############

SRC := $(shell find $(SRC_DIR) -name '*.cpp' -not -name 'test.cpp') 
OBJS := $(addprefix bin/,$(SRC:.cpp=.o))
TEST_SRC := $(shell find $(SRC_DIR) -name 'test.cpp') 
TEST_OBJS := $(addprefix bin/,$(TEST_SRC:.cpp=.o))

all: $(EXECUTABLE) $(LIBRARY)
$(EXECUTABLE): $(OBJS)

CXXFLAGS := -fPIC -fopenmp -g -rdynamic -Wall -MMD $(addprefix -I,$(INCLUDE_PATHS))
LDFLAGS := -fPIC -fopenmp -rdynamic  $(addprefix -l,$(REQUIRED_LIBS)) 
DEPENDS = $(OBJS:.o=.d)    


$(EXECUTABLE) : $(OBJS) $(TEST_OBJS)
	@echo "Build executable $@"
	@$(CXX) $(OBJS) $(TEST_OBJS) -o $@ $(LDFLAGS) 
	
package:
	zip -r pop.zip Makefile src

bin/%.o: %.cpp
	@mkdir -p `dirname $(@:.o=.d)`
	@touch $(@:.o=.d)
	@echo "Compilation : $< "
	@g++ $(CXXFLAGS) -MMD -c $< -o $@

bin: 
	@mkdir -p bin

clean:
	@rm -f $(EXECUTABLE)
	@rm -rf bin
	


external_libs:
	@echo "We need your password for this : "
	@sudo echo "thank you"
	@sudo apt-get install $(APT_GET_DEPENDENCIES)
	@echo "DONE"
	

.PHONY: package
-include $(DEPENDS) 

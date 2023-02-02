VPATH = cymeteo/src
EXEC_PATH = cymeteo/bin
OBJ_PATH = cymeteo/bin
SRC = $(VPATH)/sort/sort.c \
	$(VPATH)/sort/tree.c \
	$(VPATH)/sort/avl.c \
	$(VPATH)/sort/abr.c \
	$(VPATH)/sort/tab.c \
	$(VPATH)/sort/date.c \
	$(VPATH)/sort/opts_sort.c \
	$(VPATH)/sort/csv.c \
	$(VPATH)/edit/edit.c \
	$(VPATH)/edit/error_bar.c \
	$(VPATH)/edit/single_line.c \
	$(VPATH)/edit/multi_lines.c \
	$(VPATH)/edit/vector.c \
	$(VPATH)/edit/heat_map.c \
	$(VPATH)/edit/opts_edit.c

OBJ = $(SRC:.c=.o)

all: $(OBJ)
	mkdir -p $(EXEC_PATH)
	mkdir -p $(OBJ_PATH)
	gcc -o $(EXEC_PATH)/sort $(OBJ_PATH)/sort.o $(OBJ_PATH)/tree.o $(OBJ_PATH)/avl.o $(OBJ_PATH)/abr.o $(OBJ_PATH)/tab.o $(OBJ_PATH)/date.o $(OBJ_PATH)/csv.o $(OBJ_PATH)/opts_sort.o -lm
	gcc -o $(EXEC_PATH)/edit $(OBJ_PATH)/edit.o $(OBJ_PATH)/error_bar.o $(OBJ_PATH)/single_line.o $(OBJ_PATH)/multi_lines.o $(OBJ_PATH)/vector.o $(OBJ_PATH)/heat_map.o $(OBJ_PATH)/opts_edit.o -lm
	rm -f $(OBJ_PATH)/*.o

%.o: %.c $(HEADER)
	gcc -c $< -o $@
	mkdir -p $(OBJ_PATH)
	mv $@ $(OBJ_PATH)

clean:
	rm -f $(OBJ_PATH)/*.o

mrproper: clean
	rm -rf $(OBJ_PATH)
	rm -rf $(EXEC_PATH)

secret:
	@cat secret.txt

help:
	@echo "help     : Show this help"
	@echo "all      : Compiles all files"
	@echo "clean    : Deletes object files"
	@echo "mrproper : Deletes object files and the executable"
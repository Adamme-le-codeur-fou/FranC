SRC := src
HEADER := headers
OBJ := obj
BIN := bin
TEST_DIR := tests
OUTPUT_DIR := output

OCAMLFLAGS := -g

EXE := $(BIN)/main
TEST_FILE := $(TEST_DIR)/test1.fr
OUTPUT_FILE := $(OUTPUT_DIR)/output.c
GCC_OUTPUT := $(OUTPUT_DIR)/output


.PHONY: all clean run

all: $(EXE)

$(EXE): $(OBJ)/ast.cmo $(OBJ)/parser.cmo $(OBJ)/lexer.cmo $(OBJ)/main.cmo 
	ocamlc $(OCAMLFLAGS) -o $@ $^

$(OBJ)/%.cmo: $(SRC)/%.ml
	ocamlc $(OCAMLFLAGS) -c -I $(OBJ) $< -o $@ 

$(OBJ)/%.cmi: $(HEADER)/%.mli
	ocamlc -c -I $(OBJ) $< -o $@

$(OBJ)/lexer.cmo: $(SRC)/lexer.ml $(OBJ)/parser.cmo
$(OBJ)/parser.cmo: $(OBJ)/ast.cmi $(OBJ)/parser.cmi
$(OBJ)/parser.cmi: $(OBJ)/ast.cmo $(HEADER)/parser.mli
$(OBJ)/main.cmo : $(OBJ)/parser.cmi $(OBJ)/lexer.cmo $(OBJ)/ast.cmi

$(SRC)/lexer.ml: $(SRC)/lexer.mll
	ocamllex $<

$(SRC)/parser.ml $(HEADER)/parser.mli: $(SRC)/parser.mly
	ocamlyacc -v $<
	mv $(SRC)/parser.mli $(HEADER)/parser.mli

clean:
	-rm -f $(SRC)/lexer.ml $(SRC)/parser.ml $(HEADER)/parser.mli
	-rm -f $(OBJ)/*.cmo $(OBJ)/*.cmi
	-rm -f $(EXE) $(OUTPUT_FILE) $(GCC_OUTPUT)
	-rm -f $(SRC)/parser.output

run: clean all
	clear
	$(EXE) < $(TEST_FILE) > $(OUTPUT_FILE)
	gcc -Wall -Wextra $(OUTPUT_FILE) -o $(GCC_OUTPUT)
	$(GCC_OUTPUT)

all: main

%.cmi: %.mli
	ocamlc -g -c $<

%.cmo: %.ml
	ocamlc -g -c $<

lexer.ml: lexer.mll
	ocamllex $<

parser.ml: parser.mly
	ocamlyacc -v $<

parser.cmo: ast.cmi parser.cmi

parser.cmi: parser.mli ast.cmo
	ocamlc -g -c $<

main: ast.cmo parser.cmo lexer.cmo main.cmo
	ocamlc -g -o $@ $^

ast.cmo: ast.cmi
main.cmo : parser.cmi lexer.cmo ast.cmi

clean:
	-rm lexer.ml parser.ml parser.mli main *.cmo *.cmi *.output



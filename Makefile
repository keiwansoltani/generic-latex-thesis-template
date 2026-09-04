MAIN=thesis_main

.PHONY: all clean

all:
	latexmk -pdf $(MAIN).tex

clean:
	latexmk -C $(MAIN).tex
	$(MAKE) -C paper1/figs clean

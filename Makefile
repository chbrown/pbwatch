all: poll
# -lobjc -std=c99 -framework ApplicationServices

poll: poll.m poll.h
	clang $< -o $@ -Wall -framework Foundation -framework AppKit -fobjc-arc

.PHONY: run
run: poll
	./$<


SRC = $(abspath locks.c)
SYS_INC = -I/usr/local/bin/../lib/clang/4.0.0/include

all: locks locks.static

locks.bc : $(SRC)
	clang -O0 -c -emit-llvm -I../../tesla-install/include $< -o $@

locks.tesla : $(SRC)
	tesla analyse $< -o $@ -- -I../../tesla-install/include $(SYS_INC)

locks.manifest : locks.tesla
	tesla cat $< -o $@

locks.static.manifest : locks.manifest locks.bc
	tesla static -mc -print-counter $^ -o $@

%.instr.bc : %.manifest locks.bc
	tesla instrument -tesla-manifest $^ -o $@

locks : locks.instr.bc
	clang -L../../tesla-install/lib -ltesla $< -o $@

locks.static : locks.static.instr.bc
	clang -L../../tesla-install/lib -ltesla $< -o $@

clean:
	rm -f *.bc *.manifest *.tesla locks

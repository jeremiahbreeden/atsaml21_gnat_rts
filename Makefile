.PHONY: runtime

default:
	gprbuild

debug:
	gprbuild -XBUILD=debug

runtime:
	gprbuild runtime/build_runtime.gpr

runtime_debug:
	gprbuild runtime/build_runtime.gpr -XBUILD=debug

all: runtime default

debug_all: runtime_debug debug

clean:
	- gprclean

clean_runtime:
	- gprclean runtime/build_runtime.gpr

clean_all: clean_runtime clean

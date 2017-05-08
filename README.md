# TESLA Examples

This repository contains a number of examples of TESLA applied to small
programs, as well as Makefiles demonstrating how to build TESLA-instrumented C
programs.

## Mutex Lock (`locks/`)

These examples demonstrate TESLA being used to instrument single-use mutual
exclusion locks. The original purpose of these examples was to test static
analysis and model checking of TESLA assertions.

To build the examples, set `TESLA_ROOT` to the path of a TESLA installation
directory, and `TESLA_CC` and `TESLA_LINK` to the paths of clang 4.0 and
llvm-link 4.0 respectively. This is the latest stable version.

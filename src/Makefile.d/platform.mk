#
# Platform specific options.
#

PKG_CONFIG?=pkg-config

ifdef WINDOWSHELL
rmrf?=DEL /S /Q
mkdir?=MD
else
rmrf?=rm -rf
mkdir?=mkdir -p
endif

ifdef LINUX64
LINUX=1
endif

ifdef MINGW64
MINGW=1
endif

ifdef LINUX
UNIX=1
ifdef LINUX64
NONX86=1
# LINUX64 does not imply X86_64=1;
# could mean ARM64 or Itanium
platform=linux/64
else
platform=linux
endif
else ifdef FREEBSD
UNIX=1
platform=freebsd
else ifdef SOLARIS # FIXME
UNIX=1
platform=solaris
else ifdef CYGWIN32 # FIXME
nasm_format=win32
platform=cygwin
else ifdef MINGW
ifdef MINGW64
NONX86=1
NOASM=1
# MINGW64 should not necessarily imply X86_64=1,
# but we make that assumption elsewhere
# Once that changes, remove this
X86_64=1
platform=mingw
else
platform=mingw/64
endif
include Makefile.d/win32.mk
endif

ifdef platform
makedir:=$(makedir)/$(platform)
endif

ifdef UNIX
include Makefile.d/nix.mk
endif

ifdef SDL
include Makefile.d/sdl.mk
endif

#!/bin/bash

# You need to just run this script in the parent folder of the future project folder and follow instructions it will produce
# ./setup_project.sh

SRC=src/
INC=includes/
TASK=task/

echo -n "Input project name: "; read -r NAME

echo -n "Is it C or C++ project? (c or c++): "; read -r tmp;
if [[ "$tmp" = "c" ]]; then
		REGFILE_EXT=".c"; INCLFILE_EXT=".h"
	else
		REGFILE_EXT=".cpp"; INCLFILE_EXT=".hpp"
fi

cd $NAME
mkdir -p $SRC $INC $TASK
touch ${SRC}/${NAME}${REGFILE_EXT}
touch ${INC}/${NAME}${INCLFILE_EXT}
echo $(whoami) > author

echo -n "Do you want to add ft_printf libtrary? (y or n): "; read -r tmp;
if [[ "$tmp" = "y" ]]; then
	git submodule add https://github.com/millon15/ft_printf ft_printf
fi

echo -n "Do you want to download subject? (y or n): "; read -r tmp;
if [[ "$tmp" = "y" ]]; then
	echo -n "Please enter the subject pdf's link: "; read -r tmp;
	curl $tmp > $TASK/$NAME.pdf
fi

echo -n "Initialize the git? (y or n): "; read -r tmp;
if [[ "$tmp" = "y" ]]; then
	git init;
	echo $NAME >> .gitignore
	echo -n "Input origin remote: "; read -r ORIG
	echo -n "Input vogsphere remote: "; read -r VOGSP
	if [[ ${ORIG} ]]; then
		git remote add origin ${ORIG}
	fi
	if [[ ${VOGSP} ]]; then
		git remote add vog ${VOGSP}
	fi

# Put .gitignore
cat > .gitignore <<GITIGNORE
# Prerequisites
*.d
.*

# Object files
*.o
*.ko
*.obj
*.elf

# Linker output
*.ilk
*.map
*.exp

# Precompiled Headers
*.gch
*.pch

# Libraries
*.lib
*.a
*.la
*.lo

# Shared objects (inc. Windows DLLs)
*.dll
*.so
*.so.*
*.dylib

# Executables
*.exe
*.out
*.app
*.i*86
*.x86_64
*.hex

# Debug files
*.dSYM/
*.su
*.idb
*.pdb

# Kernel Module Compile Results
*.mod*
*.cmd
.tmp_versions/
modules.order
Module.symvers
Mkfile.old
dkms.conf

# My addings
_*
*~
test
$TASK

GITIGNORE
fi

# Put Makefile
cat > aMakefile <<MAKEFILE
# **************************************************************************** #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vbrazas <vbrazas@student.unit.ua>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/08/02 18:58:59 by vbrazas           #+#    #+#              #
#    Updated: 2018/08/13 19:52:44 by vbrazas          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.PHONY: all clean fclean re mclean mfclean mre

NAME = $NAME

SRC_PATH = src/
LIB_PATH = ft_printf/
OBJ_PATH = .obj/

CC = clang
CFLAGS = -g -Wall -Wextra -Werror

INC_PATH = includes/
IFLAGS = -I \$(INC_PATH) -I \$(LIB_PATH)
LFLAGS = -L \$(LIB_PATH) -lftprintf

HFILES = $NAME
FILES = $NAME
LIB = \$(LIB_PATH)libftprintf.a

HDRS = \$(addprefix \$(INC_PATH), \$(addsuffix .h, \$(HFILES)))
SRCS = \$(addprefix \$(SRC_PATH), \$(addsuffix .c, \$(FILES)))
OBJS = \$(addprefix \$(OBJ_PATH), \$(SRCS:%.c=%.o))


all: \$(NAME)

\$(NAME): \$(LIB) \$(OBJ_PATH) \$(OBJS)
	\$(CC) \$(CFLAGS) \$(IFLAGS) \$(LFLAGS) \$(OBJS) -o \$(NAME)

\$(LIB):
	make -C \$(LIB_PATH)

\$(OBJ_PATH):
	mkdir -p \$(OBJ_PATH)\$(SRC_PATH)
\$(OBJ_PATH)%.o: %.c \$(HDRS)
	\$(CC) \$(CFLAGS) \$(IFLAGS) -c \$< -o \$@

clean: mclean
	make clean -C \$(LIB_PATH)
fclean: mfclean
	make fclean -C \$(LIB_PATH)
re: fclean all

mclean:
	rm -f \$(OBJS) \$(DEPS)
mfclean:
	rm -f \$(NAME)
	rm -rf \$(OBJ_PATH)
mre: mfclean all

MAKEFILE

if [[ "$REGFILE_EXT" = ".cpp" ]]; then
	sed -e "s/\.c/\.cpp/g" -e "s/\.h/\.hpp/g" Makefile
fi

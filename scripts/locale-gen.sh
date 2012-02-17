#!/bin/bash

LOCALE_DIR=/usr/share/X11/locale/locale.dir
COMPOSE_DIR=/usr/share/X11/locale/compose.dir
LOCALE_ALIAS=/usr/share/X11/locale/locale.alias
GREP_STR=en_DK

if grep -q $GREP_STR $LOCALE_DIR
then
echo No changes to be written for $LOCALE_DIR.
else
echo Writing changes to $LOCALE_DIR..
cat >> $LOCALE_DIR << "EOF"
en_US.UTF-8/XLC_LOCALE        en_DK.UTF-8
en_US.UTF-8/XLC_LOCALE:        en_DK.UTF-8
EOF
fi

if grep -q $GREP_STR $COMPOSE_DIR
then
echo No changes to be written for $COMPOSE_DIR.
else
echo Writing changes to $COMPOSE_DIR
cat >> $COMPOSE_DIR << "EOF"
en_US.UTF-8/Compose            en_DK.UTF-8
en_US.UTF-8/Compose:        en_DK.UTF-8
EOF
fi

if grep -q $GREP_STR $LOCALE_ALIAS
then
echo No changes to be written for $LOCALE_ALIAS.
else
echo Writing changes to $LOCALE_ALIAS
cat >> $LOCALE_ALIAS << "EOF"
en_DK.utf8        en_DK.UTF-8
en_DK.utf8:        en_DK.UTF-8
EOF
fi

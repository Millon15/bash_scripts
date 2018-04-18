#!/bin/bash
argc=$#
argv=($@)
aim="vogsphere@vogsphere-2.unit.ua:intra/2018/activities/42_piscine_c_formation_piscine_php_day_03/vbrazas"
tdir=$(mktemp -d /tmp/foo.XXXXXXXXX)

if [[ ${argv[0]} = "clone" && ${argv[1]} = ${aim} ]]; then
git "$@"
echo -e "[user]
\temail = appleitunesstore11@gmail.com
\tname = vbrazas" > ~/.gitconfig
git clone ${aim} ${tdir}/tmp &> /dev/null
else
git "$@"
fi
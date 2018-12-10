#!/usr/bin/env bash
set -euf

set windows=
if [[ $OS == Windows* ]]; then
    windows=1
    export PATH=${LIBRARY_BIN}:$PATH
fi

# there is no build step

export prefix=$PREFIX
export activate_prefix=$PREFIX
export etc_lp='${CONDA_PREFIX}/etc/liquidprompt'

if [ ! -z ${windows} ]; then
  export prefix=$LIBRARY_PREFIX
  export etc_lp='$(cygpath ${CONDA_PREFIX})/Library/etc/liquidprompt'
fi

sed -e "s|/etc/liquidpromptrc|${etc_lp}rc|g" \
    -i \
    liquidprompt
sed -e "s|~/.config/liquidprompt/nojhan.theme|${etc_lp}/liquid.theme|" \
    -e "s|~/.config/liquidprompt/nojhan.ps1|${etc_lp}/liquid.ps1|" \
    -i \
    liquidpromptrc-dist

mkdir -p ${activate_prefix}/etc/conda/activate.d
cp liquidprompt ${activate_prefix}/etc/conda/activate.d/liquidprompt.sh
cp liquidpromptrc-dist ${prefix}/etc/liquidpromptrc

mkdir -p ${prefix}/etc/liquidprompt
cp liquid.ps1 liquid.theme ${prefix}/etc/liquidprompt

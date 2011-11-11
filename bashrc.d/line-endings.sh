#!/bin/bash

if [[ ! -x $(which unix2dos) ]] && [[ -x $(which perl) ]]; then
	function dos2unix {
		if [[ -r $1 ]] && [[ -w $2 ]]; then
			perl -p -e 's/\r$//' < $1 > $2
		fi
	}
fi

if [[ ! -x $(which unix2dos) ]] && [[ -x $(which perl) ]]; then
	function unix2dos {
		if [[ -r $1 ]] && [[ -w $2 ]]; then
			perl -p -e 's/\n/\r\n/' < $1 > $2
		fi
	}
fi

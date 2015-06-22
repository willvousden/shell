if type qdel 2> /dev/null > /dev/null && type qstat 2> /dev/null > /dev/null; then
    function qstat()
    {
        local args=$@
        if [[ -z $args ]]; then
            args="-u $USER"
        fi
        
        env qstat $args
    }

    _pbs_jobs()
    {
        local word=${COMP_WORDS[COMP_CWORD]}
        local ids=$(qstat -u $USER | tail -n +6 | awk '{print $1}')
        COMPREPLY=($(compgen -W "$ids" -- $word))
    }

    complete -F _pbs_jobs qstat
    complete -F _pbs_jobs qdel
fi

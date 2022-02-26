#!/usr/bin/env bash
#
builder_completions()
{
  COMPREPLY=($(compgen -W "ubuntu2004" "${COMP_WORDS[1]}"))
}
complete -F builder_completions ./builder.sh

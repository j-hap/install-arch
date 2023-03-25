#! /bin/bash
this="$(readlink --canonicalize "$0")"
here=$(dirname -- "$this")
for script in $(find $here/*.sh -exec readlink --canonicalize "{}" \;); do
  if [[ "$script" != "$this" ]]; then
    echo "Executing $script"
    bash $script
  fi
done

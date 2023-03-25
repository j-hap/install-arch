#! /bin/bash
target_dir="$HOME/dracula/qtcreator"
theme_dir="$HOME/.config/QtProject/qtcreator/styles"
mkdir --parents "$theme_dir"
if [ ! -d "$target_dir" ]; then
  echo "Cloning..."
  git clone --quiet https://github.com/dracula/qtcreator.git "$target_dir"
else
  echo "Updating..."
  pushd $target_dir >/dev/null
  git reset --hard --quiet
  git clean -d --force --quiet
  git pull --quiet
  popd >/dev/null
fi
ln --symbolic --force "$target_dir/dracula.xml" "$theme_dir/."

#! /bin/bash
# dracula theme for vim
target_dir="$HOME/dracula/vim"
theme_dir="$HOME/.vim/pack/themes/opt"

mkdir --parents "$(dirname $target_dir)"
mkdir --parents $theme_dir
pushd $HOME/dracula >/dev/null
if [ ! -d vim ]; then
  echo "Cloning..."
  git clone --quiet https://github.com/dracula/vim.git $target_dir
else
  echo "Updating..."
  pushd vim >/dev/null
  git reset --hard --quiet
  git clean -d --force --quiet
  git pull --quiet
  popd >/dev/null
fi
ln -sf $target_dir $theme_dir/dracula
popd >/dev/null

rc_file=$(vim --version | grep -e "^\s*user vimrc file:" | awk -F":" '{print $2}' | envsubst)
rc_file=${rc_file:2:-1}

if ! [[ -f "$rc_file" ]]; then
  echo "Touching $rc_file"
  touch "$rc_file"
fi

lines=(
  "packadd! dracula"
  "syntax enable"
  "colorscheme dracula"
)

for line in "${lines[@]}"; do
  sed -i "/$line/d" $rc_file
done
for line in "${lines[@]}"; do
  echo $line >>$rc_file
done

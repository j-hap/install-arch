#! /bin/sh
# the hard way
# URL=http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
# filename=$(basename $URL)
# mkdir --parents ~/texlive-installation
# cp --force ./texlive.profile ~/texlive-installation
# pushd ~/texlive-installation
# wget --quiet --output-document=$filename --no-clobber -- $URL
# tar --extract --gzip --strip-components=1 --file $filename
# sudo perl ./install-tl --profile ./texlive.profile --no-interaction
# popd
# rm -r ~/texlive-installation

latexmk_packages=(
  perl-File-Copy
  perl-Time-HiRes
  perl-Unicode-Normalize
  perl-sigtrap
)

latexindent_packages=(
  perl-FindBin
  perl-open
  perl-YAML-Tiny
  perl-File-HomeDir
)

if command -v dnf &>/dev/null; then
  sudo dnf install --assumeyes ${latexmk_packages[@]} ${latexindent_packages[@]}
elif command -v apt >/dev/null 2>&1; then
  sudo apt --assume-yes install ${latexmk_packages[@]} ${latexindent_packages[@]}
elif command -v pacman >/dev/null 2>&1; then
  # if one package is not found, packman cancels, so in a loopp
  for package in ${latexmk_packages[@]} ${latexindent_packages[@]}; do
    # need lower case conversion
    sudo pacman -S --noconfirm "${package,,}"
  done
fi

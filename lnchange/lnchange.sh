#!/bin/bash

#TODO make to input arguments
to="PH1_R.1.1"
ln_at="~/HOME"

ln_files=(
  "bin"
  "lib"
  "data"
  "jar"
  "slp"
  "openapi"
  "db_script"
  "lua"
)

echo 'package symlink will be'
echo $to

for f in "${ln_files[@]}"; do
  echo change $ln_at/$f
#unlink $ln_at/$f
  unlink $f
  ln -s $to/$f $f
done

#!/bin/bash

to=''
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

echo -n "symlink directory(default=R.5.0.0): "
read to 
if [$to -eq '']; then
  to='R.5.0.0'   
fi
echo 'package symlink will be'
echo $to

for f in "${ln_files[@]}"; do
  echo change $ln_at/$f
  unlink $f
  ln -s $to/$f $f
done

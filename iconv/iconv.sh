#!/bin/bash

echo -n "before encoding(default=euc-kr): "
read be
if [$be -eq '']; then
  be='euc-kr'   
fi
echo $be

echo -n "after encoding(default=utf-8): "
read ae
if [$ae -eq '']; then
  ae='utf-8'   
fi
echo $ae

echo -n "src file to convert: "
read sf
echo $sf

echo -n "dest file: "
read df
echo $df

iconv -f ${be} -t ${ae} ${sf} > ${df}

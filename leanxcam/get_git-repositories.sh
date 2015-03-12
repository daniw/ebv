#!/bin/bash

#define all packages here
PKG_TO_DOWNLOAD="oscar leanXcam leanXzebra leanXalarm leanXstream osc-cc web-view app-template basic-template tutorial toolchain-bin"

for PKG in $PKG_TO_DOWNLOAD
do
   if [ ! -d $PKG ]; then
       echo "git clone git://github.com/scs/$PKG.git"
       git clone git://github.com/scs/$PKG.git
   else
      echo "package $PKG already installed"  
   fi
done

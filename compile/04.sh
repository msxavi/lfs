touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664  /var/log/lastlog
chmod -v 600  /var/log/btmp

declare -a arr=("linux-5.5.5.tar.xz" "man-pages-5.04.tar.xz" "glibc-2.31.tar.xz")

for tarFile in "${arr[@]}"
do
  tarDir=$(echo "${tarFile%.*.*}")
  echo "Extracting $tarFile ..."
  mkdir -v $tarDir && tar -xf $tarFile -C $tarDir --strip-components 1
  cd $tarDir
  bash $SCRIPT_DIR/compile/scripts/${tarDir}/run2.sh
  cd ..
  rm -rf $tarDir
  echo "$tarFile Succeeded!"
done

echo "Done. Keep going and execute compile/05.sh"

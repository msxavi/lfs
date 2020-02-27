declare -a arr=("binutils-2.34.tar.xz" "gcc-9.2.0.tar.xz" "linux-5.5.5.tar.xz" "glibc-2.31.tar.xz" "gcc-9.2.0-2.tar.xz" "binutils-2.34-2.tar.xz" "gcc-9.2.0-3.tar.xz" "tcl8.6.10-src.tar.gz" "expect5.45.4.tar.gz"
"dejagnu-1.6.2.tar.gz" "m4-1.4.18.tar.xz" "ncurses-6.1.tar.gz" "bash-5.0.tar.gz" "bison-3.5.1.tar.xz" "bzip2-1.0.8.tar.gz" "coreutils-8.31.tar.xz"
"diffutils-3.7.tar.xz" "file-5.38.tar.gz" "findutils-4.7.0.tar.xz" "gawk-5.0.1.tar.xz" "gettext-0.20.1.tar.xz" "grep-3.4.tar.xz"
"gzip-1.10.tar.xz" "make-4.3.tar.gz" "patch-2.7.6.tar.xz" "perl-5.30.1.tar.xz" "Python-3.8.1.tar.xz" "sed-4.8.tar.xz" "tar-1.32.tar.xz" "texinfo-6.7.tar.xz" "xz-5.2.4.tar.xz")

touch compile1.log
for tarFile in "${arr[@]}"
do
  tarDir=$(echo "${tarFile%.*.*}")
  echo "Extracting $tarFile ..."
  sleep 3
  mkdir -v $tarDir && tar -xf $tarFile -C $tarDir --strip-components 1
  cd $tarDir
  bash $SCRIPT_DIR/compile/scripts/${tarDir}/run.sh
  cd ..
  rm -rf $tarDir
  echo "$tarFile Succeeded!" >> compile1.log
done

echo "All done!. Now execute change to 'su - root' and run scripts/stripping.sh"

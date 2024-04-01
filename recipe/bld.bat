@echo on

echo "**************** F R E E F E M  B U I L D  S T A R T S  H E R E ****************"

bash -c "autoreconf -fi"
if errorlevel 1 exit 1

set MAKE=mingw32-make

bash -c "./configure CXXFLAGS=\"-Wa,-mbig-obj $CXXFLAGS\" --prefix=`cygpath -u $PREFIX` --bindir=`cygpath -u $LIBRARY_BIN` --libdir=`cygpath -u $LIBRARY_LIB` includedir=`cygpath -u $LIBRARY_INC` --enable-mingw64 --enable-m64 --enable-optim --without-mpi --disable-fortran --disable-ffcs" 
if errorlevel 1 exit 1

mingw32-make -j %CPU_COUNT%
if errorlevel 1 exit 1

mingw32-make install
if errorlevel 1 exit 1

mingw32-make check -j %CPU_COUNT%
if errorlevel 1 exit 1

echo "**************** F R E E F E M  B U I L D  E N D S  H E R E ****************"

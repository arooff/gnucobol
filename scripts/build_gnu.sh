# variables
dirName=$(echo ${GITHUB_REPOSITORY##*/})
# Create directories tree
mkdir -p rpmbuild/BUILD
mkdir -p rpmbuild/BUILDROOT
mkdir -p rpmbuild/RPMS
mkdir -p rpmbuild/SOURCES
mkdir -p rpmbuild/SPECS
mkdir -p rpmbuild/SRPMS

# Make archive
cp _spec/gnucobol.spec rpmbuild/SPECS
rm -rf _spec
rm -rf _dist
rm -f gnucobol.tar.xz

pwd
echo "-----------------------------"

ls -al

echo "-----------------------------"
ls -al ../

echo "-----------------------------"

echo "DIRNAME: $dirName"
#tar cfJP gnucobol.tar.xz ../$dirName
tar cfJP gnucobol.tar.xz ../gnucobol
Result=$?
if [ $Result -gt 1 ] 
then
   echo "bad"
   exit 1
fi
echo "Result : " $Result
mv gnucobol.tar.xz rpmbuild/SOURCES
ls -al rpmbuild/SOURCES/
# Force Autoreconf
#autoreconf -f ../gnucobol
echo "HERE: $(pwd) and\n $(ls -al ../)"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
#autoreconf -f ../$dirName
autoreconf -f ../gnucobol

WORKDIR=$(pwd)
echo "WORKDIR: $WORKDIR"
ls $WORKDIR/rpmbuild
echo "BEFORE"
ll rpmbuild/SPECS/gnucobol.spec
# Make packages
rpmbuild --define "_topdir ${WORKDIR}/rpmbuild" -ba rpmbuild/SPECS/gnucobol.spec


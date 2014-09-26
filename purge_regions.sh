#!/bin/bash
rm -f level.dat_old
cp -f level.dat_ori level.dat

rm -fr data
#rm -fr players
rm -fr stats
rm -f session.lock
rm -f uid.dat

regionDir="region"
tempDir="region_tmp"
regions=(
0,0
0,-1
-1,-1
-1,0
-1,1
0,1
1,1
1,0
1,-1
1,-2
0,-2
-1,-2
-2,-2
-2,-1
-2,0
-2,1
-2,2
-1,2
0,2
1,2
2,2
2,1
2,0
2,-1
2,-2
)
if [ -d "$tempDir" ];then
echo 'region temp folder exist, do not purge.';exit 2;
fi
mv $regionDir $tempDir
mkdir -p $regionDir
for ((i=0; i<${#regions[@]}; i++)); do
x=${regions[$i]%%,*}
y=${regions[$i]##*,}
mcaFileName="r.${x}.${y}.mca"
mv $tempDir/$mcaFileName $regionDir/$mcaFileName
done

rm -fr $tempDir

fdupes -r -d -N .

for i in $(find ./recup_dir.* -type f);do 
	ext=$(echo $i | sed 's|.*\.||')
#	echo $i
#	echo $ext
echo	mkdir --parents ./$ext/
        mkdir --parents ./$ext/
echo	mv -v --backup=nil $i ./$ext/  
        mv -v --backup=nil $i ./$ext/

done

find . -type d -empty -delete

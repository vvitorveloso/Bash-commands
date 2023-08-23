fdupes -r -d -N .

for i in $(find ./recup_dir.* -type f);do 
	ext=$(echo $i | sed 's|.*\.||')
#	echo $i
#	echo $ext
	mkdir --parents ./$ext/
	mv -v --backup=nil $i ./$ext/  
done

find . -type d -empty -delete

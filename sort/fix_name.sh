IFS=$'\n'

echo $1
find $1 -regextype posix-egrep -regex '.[{ÁÉÍÓÚÀÈÌÒÙÄËÏÖÜé].' | while read filename; do
file_clean=echo $filename | iconv -f utf8 -t ascii//TRANSLIT
echo mv -n "$filename" "$file_clean"
echo "$file_clean"
done

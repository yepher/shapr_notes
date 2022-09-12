find . -name "thumb.png" -print0 | while read -d $'\0' file
do
    echo '<a href="'"$file"'"><img src="'"$file"'" style="width:80px;"></a><br>\n'
done

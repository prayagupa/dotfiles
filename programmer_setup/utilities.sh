convertMP4toMP3(){
	echo -n "Enter source mp4 file : "
	read sourceFile

	echo -n "Enter destination mp3 file : "
	read destFile

	avconv -i $sourceFile -vn -acodec libmp3lame -ac 2 -ab 160k -ar 48000 $destFile
}


configureMP3Codecs(){
  sudo apt-get install ffmpeg libavcodec-extra-53
}
convertMP4toMP3(){
  configureMP3Codecs
	#echo -n "Enter source mp4 file : "
	#read sourceFile
  sourceFile=$1
	#echo -n "Enter destination mp3 file : "
	#read destFile
  destFile=$2
	avconv -i $sourceFile -vn -acodec libmp3lame -ac 2 -ab 160k -ar 48000 $destFile
}

installYoutubeDownloader(){
  sudo wget https://yt-dl.org/downloads/2013.10.18/youtube-dl -O /usr/local/bin/youtube-dl
	sudo chmod a+x /usr/local/bin/youtube-dl
  #sudo apt-get install youtube-dl
}

downloadMP3(){
  youtube-dl --extract-audio --audio-format mp3 $1
}

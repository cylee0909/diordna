#/bin/bash
# Android反编译工具 for linux/mac
# author eyescylee@163.com
current=`dirname $0`
function phelp() {
	echo "using diordna.sh apkpath [-d] to decompile apk file"
}

echo "Welcom diordna V1.0"
if [ ! -f "$1" ] || [ ! -e "$1" ]; then
	echo "$1 is not file or not exist"
	phelp;
	exit 1
fi

if [ $# == 1 ] || [ $2 == "" ]; then
	echo "Using jd-jui decompile..."
	tar -jxv -f $1 -C "$current" classes.dex
	bash "$current/"dex2jar/d2j-dex2jar.sh --force "$current/"classes.dex -o "$current/"out.jar 
	rm "$current/"classes.dex
	java -jar "$current/"jd-gui-1.4.0.jar "$current/"out.jar
	unlink "$current/"out.jar
elif [ $2 == "d" ]; then
	echo "Using apktool decode..."
	java -jar "$current/apktool_2.0.3.jar" d $1
else 
	echo "Param error"
	phelp;
fi


echo "hola mundo awk" | awk '{print $0}'
mkdir awk_data
echo "Hola Mundo Awk [de un archivo]"> awk_data/first.txt
awk '{print $0}' awk_data/first.txt
awk '{print $2}' awk_data/first.txt
awk -F'[][]' '{print $2}' awk_data/first.txt
wget -O awk_data/access_log http://www.almhuette-raith.at/apache-log/access.log
#uniq alternative from https://stackoverflow.com/questions/32364102/finding-a-uniq-c-substitute-for-big-files
cat awk_data/access_log | awk '{ print $1;}' |  awk '{ipcount[$0]++} END {for (line in ipcount) print ipcount[line], line}' |sort -n  | tail -n10
cat awk_data/access_log | awk -F'[ "]+' '$7 == "/" { ipcount[$1]++ } END {for (line in ipcount) print ipcount[line], line}' |sort -n  | tail -n10
cat awk_data/access_log | awk -F'[ "]+' '$12 == "Go-http-client/1.1"{ ipcount[$1]++ } END {for (line in ipcount) print ipcount[line], line}' |sort -n  | tail -n10
total=$(cat awk_data/access_log | wc -l)
item=$(grep -c 200 awk_data/access_log)

percent=$(awk "BEGIN { pc=100*${item}/${total}; i=int(pc); print (pc-i<0.5)?i:i+1 }")
#porcent formule https://stackoverflow.com/questions/24284460/calculating-rounded-percentage-in-shell-script-without-using-bc
echo $percent "%"
cat awk_data/access_log | awk -F'[ "]+' '$9 !~ /200/ { ipcount[$7]++ } END {for (line in ipcount) print ipcount[line], line}' |sort -n  | tail -n10
cat awk_data/access_log | awk '{c[$1]++} END {for (line in c) print c[line], line}' |sort -n  | tail -n10 | awk '{ print $2;}'| while read  ip; do dig +noall +answer -x $ip </dev/null; done | awk '{ print $5;}' 

#dig comand from https://unix.stackexchange.com/questions/20784/how-can-i-resolve-a-hostname-to-an-ip-address-in-a-bash-script

cat awk_data/access_log|awk -F'[ "]+' 'NF !~ /20/{print NR, NF, $0}'|head
wget -O awk_data/quijote.txt https://www.gutenberg.org/ebooks/2000.txt.utf-8
cat awk_data/quijote.txt | awk 'BEGIN { x=0 } /^\s*$/ { x=x+1 } END   { print "He encontrado " x " lineas en blanco. :)" }';
cat awk_data/quijote.txt | awk '/Rocinante/{print FNR,$0}'
cat awk_data/quijote.txt | awk 'BEGIN {IGNORECASE=1};/rocinante/{print FNR,$0}'
cat awk_data/quijote.txt | awk '/Rocinante/{print FNR,$0}'|awk '{gsub(/^Rocinante/,"Banana")}1'
cat awk_data/quijote.txt | awk '{gsub(/^Rocinante/,"Banana")};/Banana/{print FNR,$0}'
cat awk_data/quijote.txt | awk 'NR < 6'
cat awk_data/quijote.txt | awk 'NR < 10' |awk 'NR%2==0'
cat awk_data/quijote.txt | awk 'NR < 6' |awk 'NR%2==1'
cat awk_data/quijote.txt | awk 'NR < 6 &&NR%2==1'
ls -l awk_data;
ls awk_data/* | awk '{print "cp "$0" "$0".bak"}' |bash;
ls -l awk_data;
rm awk_data/*.bak*
rm -r awk_data/

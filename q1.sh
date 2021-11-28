

if [ "$#" -gt 1 ];
then
    echo "The variable is equal to 10."
    exit 1
elif [ "$#" -eq 1 ];
then
    filename=$1
    n=1
        while read line; do
        #echo "${line::-1}"
        AFTER=`echo $line | sed 's/\\r//g'`
        words=( $line )
        for i in ${!words[@]}; do

            upper=`grep -o '[A-Z]' <<< "${words[$i]}" | wc -l`
            lower=`grep -o '[a-z]' <<< "${words[$i]}" | wc -l`
            digit=`grep -o '[0-9]' <<< "${words[$i]}" | wc -l`
            total=${#words[$i]}
            nonChar="$(($total-$lower-$upper-$digit))"
            echo  -ne $upper"."$lower"."$digit"."$nonChar"  "
        done
        echo ""
    done < $filename
else
  while true; do
    line=''

    while IFS= read -r -N 1 ch; do
        case "$ch" in
            $'\04') got_eot=1   ;&
            $'\n')  break       ;;
            *)      line="$line$ch" ;;
        esac
    done
    echo ""
    words=( $line )
    for i in ${!words[@]}; do
        #echo "${words[$i]}"
        upper=`grep -o '[A-Z]' <<< "${words[$i]}" | wc -l`
        lower=`grep -o '[a-z]' <<< "${words[$i]}" | wc -l`
        digit=`grep -o '[0-9]' <<< "${words[$i]}" | wc -l`
        total=${#words[$i]}
        nonChar="$(($total-$lower-$upper-$digit))"
        echo -ne $upper"."$lower"."$digit"."$nonChar"   "
        
done
	echo ""
    if (( got_eot )); then
        break
    fi
done
fi



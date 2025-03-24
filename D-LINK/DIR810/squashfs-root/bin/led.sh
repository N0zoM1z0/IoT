## @file led.sh
## @Author Andrew Tong
## @Date 2013-11-04
## @brief Led Control
## @param 0 ./led.sh 0 not support
## @param 1 ./led.sh 1 fail
## @param 2 ./led.sh 2 process
## @param 3 ./led.sh 3 success
## @param 4 ./led.sh 4 finish

case $1 in
    826)
    case $2 in
	    0)
	    gpio l 31 0 4000 0 0 0;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 0;;
	    1)
	    gpio l 31 0 4000 0 0 0;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 1;;
	    2)
	    gpio l 31 5 5 4000 1 4000;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 2;;
	    3)
	    gpio l 31 4000 0 0 0 0;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 3;;
	    4)
	    gpio l 31 4000 0 0 0 0;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 4;;
    esac;;
    626)
    case $2 in
	    0)
	    gpio l 31 0 4000 0 0 0;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 0;;
	    1)
	    gpio l 31 0 4000 0 0 0;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 1;;
	    2)
	    gpio l 31 5 5 4000 1 4000;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 2;;
	    3)
	    gpio l 31 4000 0 0 0 0;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 3;;
	    4)
	    gpio l 31 4000 0 0 0 0;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 4;;
    esac;;
    836)
    case $2 in
	    0)
	    gpio l 31 0 4000 0 0 0;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 0;;
	    1)
	    gpio l 31 0 4000 0 0 0;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 1;;
	    2)
	    gpio l 31 5 5 4000 1 4000;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 2;;
	    3)
	    gpio l 31 4000 0 0 0 0;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 3;;
	    4)
	    gpio l 31 4000 0 0 0 0;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 4;;
    esac;;
    636)
    case $2 in
	    0)
	    gpio l 31 0 4000 0 0 0;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 0;;
	    1)
	    gpio l 31 0 4000 0 0 0;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 1;;
	    2)
	    gpio l 31 5 5 4000 1 4000;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 2;;
	    3)
	    gpio l 31 4000 0 0 0 0;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 3;;
	    4)
	    gpio l 31 4000 0 0 0 0;gpio l 30 0 4000 0 0 0;gpio l 25 0 4000 0 0 0;gpio l 24 0 4000 0 0 0;echo 4;;
    esac;;
    810)
    case $2 in
	    0)
	    gpio l 9 4000 0 0 0 0;gpio l 12 0 4000 0 0 0;gpio l 13 0 4000 0 0 0;gpio l 40 0 4000 0 0 0;echo 0;;
	    1)
	    gpio l 9 4000 0 0 0 0;gpio l 12 0 4000 0 0 0;gpio l 13 0 4000 0 0 0;gpio l 40 0 4000 0 0 0;echo 1;;
	    2)
	    gpio l 9 4000 0 0 0 0;gpio l 12 4000 0 0 0 0;gpio l 13 4000 0 0 0 0;gpio l 40 5 5 4000 1 4000;echo 2;;
	    3)
	    gpio l 9 0 4000 0 0 0;gpio l 12 4000 0 0 0 0;gpio l 13 4000 0 0 0 0;gpio l 40 0 4000 0 0 0;echo 3;;
	    4)
	    gpio l 9 0 4000 0 0 0;gpio l 12 4000 0 0 0 0;gpio l 13 4000 0 0 0 0;gpio l 40 0 4000 0 0 0;echo 4;;
    esac;;
    808)
    case $2 in
	    0)
	    gpio l 9 4000 0 0 0 0;gpio l 12 0 4000 0 0 0;gpio l 13 0 4000 0 0 0;gpio l 40 0 4000 0 0 0;echo 0;;
	    1)
	    gpio l 9 4000 0 0 0 0;gpio l 12 0 4000 0 0 0;gpio l 13 0 4000 0 0 0;gpio l 40 0 4000 0 0 0;echo 1;;
	    2)
	    gpio l 9 4000 0 0 0 0;gpio l 12 4000 0 0 0 0;gpio l 13 4000 0 0 0 0;gpio l 40 5 5 4000 1 4000;echo 2;;
	    3)
	    gpio l 9 0 4000 0 0 0;gpio l 12 4000 0 0 0 0;gpio l 13 4000 0 0 0 0;gpio l 40 0 4000 0 0 0;echo 3;;
	    4)
	    gpio l 9 0 4000 0 0 0;gpio l 12 4000 0 0 0 0;gpio l 13 4000 0 0 0 0;gpio l 40 0 4000 0 0 0;echo 4;;
    esac;;
esac
exit 0


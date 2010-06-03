# ---

# script for preparing the A5 binding book out of A4 pages
# in a way, that on one A5 side you should see CODE (or description)
# and on the next one you should see corresponding PICTURE (or other result)
# both are called as a pair

# author: Jakub Godawa, Poland
# date: 17.04.2010
# place: Prepared for Linux Conference in Linz

# it is to show how the paper should be inserted to the printer
# to have an output of a bindable A5 format book

# usage:
# chmod +x bind_a5_book.sh #remember to make it executable

# you can provide the number of pairs or it will try to count it by itself withing a folder
# ./bind_a5_book.sh [ int ]

# example (even):
# ./bind_a5_book.sh 16

# output:

# 1 - F,  B  / C1, --
# 2 - B1, -- / C2, B16
# 3 - B2, C16 / C3, B15
# 4 - B3, C15 / C4, B14
# 5 - B4, C14 / C5, B13
# 6 - B5, C13 / C6, B12
# 7 - B6, C12 / C7, B11
# 8 - B7, C11 / C8, B10
# 9 - B8, C10 / C9, B9

# example (odd):

# ./bind_a5_book.sh 15

# output:

# 1 - F,  B  / C1, B15
# 2 - B1, C15 / C2, B14
# 3 - B2, C14 / C3, B13
# 4 - B3, C13 / C4, B12
# 5 - B4, C12 / C5, B11
# 6 - B5, C11 / C6, B10
# 7 - B6, C10 / C7, B9
# 8 - B7, C9 / C8, B8

# output explanation:
# <paper page number> - <left_bottom_side_of_A4>, <right_bottom_side_of_A4> / <left_top_side_of_A4>, <right_top_side_of_A4>

# then you can put it to the printer, print odds at first and then evens! Without suprise.

# ---

pairs_count=0

# provide the number of pairs (code&picture is a one pair)
# or it count it by itself
if [ "$1" != "" ]; then
  pairs_count=$1
else
  count=`ls | grep pdf | wc -l`
  pairs_count=$((count/2))
fi
 
paper_count=$((pairs_count/2+1))

max=$pairs_count
min=1

# odd pairs
if [ $((pairs_count % 2)) -eq 1 ]; then

  echo "1 - F,  B  / C1, B$max"

  for ((i=2; i<=$paper_count; i++))
  do

    j=$((min+i-2))
    k=$((max-i+2))
    n=$((max-i+1))
    
    echo "$i - B$j, C$k / C$i, B$n"
  
  done

# even pairs
else

  echo "1 - F,  B  / C1, --"
  echo "2 - B1, -- / C2, B$max"

  for ((i=3; i<=$paper_count; i++))
  do

    j=$((min+i-2))
    k=$((max-i+3))
    n=$((max-i+2))
    
    echo "$i - B$j, C$k / C$i, B$n"
  
  done
fi

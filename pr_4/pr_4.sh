#!/bin/bash
echo -n "Enter author name: "
read author_name

echo -n "Enter publisher name: "
read publisher_name

# join Author, Publisher, and Book tables on author_id and publisher_id
echo ""
echo ""
echo "Author name and publisher name wise report:"

#publisher id
pub_id=$(grep -i "$publisher_name" PUBLISHER.txt | cut -d':' -f 1)
# echo $pub_id

#author id
aut_id=$(grep -i "$author_name" AUTHOR.txt | cut -d':' -f 1)
# echo $aut_id

if [ -z "$pub_id" ]; then
    echo "Publisher not Found"
    exit
fi

# show details
# book_id book_name author_name publisher_name price

awk -F: -v aut_id="$aut_id" -v pub_id="$pub_id" -v author_name="$author_name" -v publisher_name="$publisher_name" 'BEGIN{ OFS="\t"; print "book_id","book_name","author_name","publisher_name","price" }{if($3 == aut_id && $4 == pub_id) print $1 $2 author_name publisher_name $5}' BOOK.txt   

# report 2: publisher wise book report
echo ""
echo ""
echo "Publisher wise book report:"
# Publisher Name: <<Publisher name>>
# Book id Book Name Author Name Price

echo "Publisher Name : $publisher_name"

awk -F: -v pub_id="$pub_id" 'BEGIN{ OFS="\t"; print "book_id","book_name","author_name","price" }{if($4 == pub_id) print $1 $2 $3 $5}' BOOK.txt

 #awk -v publisher_name="$publisher_name" '$4==p{print $1,$2,a[$3],$5}' <(awk -v publisher_name="$publisher_name" '$2 == publisher_name {print $1,$2}' Publisher) <(awk '{a[$1]=$2} END{for(i in a) print i,a[i]}' Author) <(awk 'NR==FNR{a[$1]=$2; next} $3 in a{print $1,$2,$3,$4,$5}' Author <(awk -v publisher_name="$publisher_name" '$2 == publisher_name {print $1,$2}' Publisher) <(awk 'NR==FNR{a[$1]=$2; next} $3 in a{print $3,$6}' Author Book))

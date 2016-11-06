echo "# cat index.html | grep \"yahoo.com\""
cat index.html | grep "yahoo.com"
echo "~~~~~~~~~~~~~~~~SEP~~~~~~~~~~~~~~~~"

echo "# cat index.html | grep \"yahoo.com\" | cut -d \":\" -f 2"
cat index.html | grep "yahoo.com" | cut -d ":" -f 2
echo "~~~~~~~~~~~~~~~~SEP~~~~~~~~~~~~~~~~"

echo "# cat index.html | grep \"yahoo.com\" | cut -d \":\" -f 2 |  cut -d \"/\" -f 3"
cat index.html | grep "yahoo.com" | cut -d ":" -f 2 |  cut -d "/" -f 3
echo "~~~~~~~~~~~~~~~~SEP~~~~~~~~~~~~~~~~"

echo "# cat index.html | grep \"yahoo.com\" | cut -d \":\" -f 2 |  cut -d \"/\" -f 3 | sort -u"
cat index.html | grep "yahoo.com" | cut -d ":" -f 2 |  cut -d "/" -f 3 | sort -u
echo "~~~~~~~~~~~~~~~~SEP~~~~~~~~~~~~~~~~"

echo "# cat index.html | grep \"yahoo.com\" | cut -d \":\" -f 2 |  cut -d \"/\" -f 3 | sort -u | cut -d \"\\\"\" -f 1"
cat index.html | grep "yahoo.com" | cut -d ":" -f 2 |  cut -d "/" -f 3 | sort -u | cut -d "\"" -f 1
echo "~~~~~~~~~~~~~~~~SEP~~~~~~~~~~~~~~~~"

echo "# cat index.html | grep \"yahoo.com\" | cut -d \":\" -f 2 |  cut -d \"/\" -f 3 | sort -u | cut -d \"\\\"\" -f 1 > domains.txt"
cat index.html | grep "yahoo.com" | cut -d ":" -f 2 |  cut -d "/" -f 3 | sort -u | cut -d "\"" -f 1 > domains.txt
echo "~~~~~~~~~~~~~~~~SEP~~~~~~~~~~~~~~~~"

echo "# cat domains.txt | sort -u | grep \"yahoo.com\""
cat domains.txt | sort -u | grep "yahoo.com"
echo "~~~~~~~~~~~~~~~~SEP~~~~~~~~~~~~~~~~"

echo "# cat domains.txt | sort -u | grep \"yahoo.com\" > domains.txt"
cat domains.txt | sort -u | grep "yahoo.com" > domains.txt
echo "~~~~~~~~~~~~~~~~SEP~~~~~~~~~~~~~~~~"


docker exec -it postgres12 /bin/sh
createdb --username=root --owner=root bank
psql bank
\q
dropdb bank
exit
# --------------------------------


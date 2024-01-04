all: postgres createdb migrateup test

postgres:
	docker stop postgres12 || echo "Not running"
	docker rm postgres12 || echo "Does not exist"
	docker run --name postgres12 -p 5433:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=mypassword -d postgres:12-alpine
	sleep 2 

createdb: postgres
	docker exec -it postgres12 createdb --username=root --owner=root bank

dropdb: 
	docker exec -it postgres12 dropdb bank

migratecreate:
	[ -d "db/migration" ] || migrate create -ext sql -dir db/migration -seq init_schema
	ls -l db/migration

migrateup: createdb
	migrate -path db/migration -database "postgresql://root:mypassword@localhost:5433/bank?sslmode=disable" -verbose up

migratedown:
	yes | migrate -path db/migration -database "postgresql://root:mypassword@localhost:5433/bank?sslmode=disable" -verbose down

sqlc:
	sqlc init
	sqlc generate

go:
	go mod init "module-bank"
	go get github.com/lib/pq
	go get github.com/stretchr/testify

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown migratecreate sqlc test

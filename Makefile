postgres: 
	docker run --name postgresdb -p 5432:5432 -e POSTGRESS_PASSWORD=123 -e POSTGRESS_USER=root -d postgres:12-alpine

createdb: 
	docker exec -it postgresdb createdb --username=root --owner=root simple_bank

dropdb: 
	docker exec -it postgresdb createdb --username=root --owner=root simple_bank

migrateup: 
	migrate -path db/migration -database postgresql://root:123@localhost:5432/simple_bank?sslmode=disable -verbose up

migratedown: 
	migrate -path db/migration -database postgresql://root:123@localhost:5432/simple_bank?sslmode=disable -verbose down

sqlc:
	sqlc generate

test:
	find . -name go.mod -execdir go test -v -cover ./... \;

.PHONY: postgres createdb dropdb migrateup migratedown sqlc

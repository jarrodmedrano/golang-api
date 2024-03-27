postgres:
	docker run --name pgsimplebank -p 5496:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine
createdb:
	docker exec -it pgsimplebank createdb --username=root --owner=root simple_bank
dropdb:
	docker exec -it pgsimplebank dropdb simple_bank
migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5496/simple_bank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5496/simple_bank?sslmode=disable" -verbose down
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
server:
	go run main.go

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server
.PHONY: run-offline
run-offline:
	poetry run -m ds_blog

.PHONY: run
run:
	@poetry export --without-hashes --without-urls > requirements.txt
	@docker login -u dhwanitddesai -p NOT_A_REAL_PASSWORD
	@docker build . -t dhwanitddesai/personal:dsbv1
	@docker push dhwanitddesai/personal:dsbv1
	poetry run python -m ds_blog

.PHONY: install
install:
	@./install.sh
	poetry install

.PHONY: add-data
add-data:  ## Minio must be port-forwarded before running
	@mc mb minio/workflows --ignore-existing
	@mc alias set minio http://localhost:9000 argoproj NOT_A_REAL_PASSWORD
	@mc put assets/diabetes.csv minio/workflows/diabetes.csv

.PHONY: format
format: ## Format and sort imports for source, tests, examples, etc.
	@poetry run ruff format .
	@poetry run ruff check . --fix

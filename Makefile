.DEFAULT_G`2OAL := help

.PHONY: help
help:
	@echo "make [target]"

.PHONY: unittest
unittest:
	@echo "========"
	@echo "Unit Test"
	@echo "========"
	python -m unittest discover -s yw_etl_target_clickhouse/ -p '*_test.py'

.PHONY: test
test: unittest
	@echo "================"
	@echo "Integration Test"
	@echo "================"
	@bash test/integration_test.sh


.PHONY: build
build:
	@python -m build -w

build_out = dist/ build/ *.egg-info/
.PHONY: clean
clean:
	@rm -rf $(build_out)

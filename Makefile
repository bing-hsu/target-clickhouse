.DEFAULT_G`2OAL := help

.PHONY : help
help :
	@echo "make [target]"

.PHONY : unittest
unittest :
	python -m unittest discover -s yw_etl_target_clickhouse/ -p '*_test.py'

.PHONY : build
build :
	@python -m build -w

build_out = dist/ build/ *.egg-info/
.PHONY : clean
clean :
	@rm -rf $(build_out)

.DEFAULT_G`2OAL := help

help :
	@echo "make [target]"

unittest :
	python -m unittest discover -s yw_etl_target_clickhouse/ -p '*_test.py'

venv:
	python3 -m venv .venv
	@echo 'run `source .venv/bin/activate` to use virtualenv'

setup: venv
	source .venv/bin/activate && pip3 install -U black isort mypy pylint twine

dev: setup
	source .venv/bin/activate && python3 setup.py develop
	@echo 'run `source .venv/bin/activate` to develop diff-match-patch'

release: lint test clean
	python3 setup.py sdist
	python3 -m twine upload dist/*

lint:
	-python -m black --check diff_match_patch setup.py
	-python -m mypy --ignore-missing-imports .

test:
	python -m unittest -v diff_match_patch.tests

clean:
	rm -rf build dist README MANIFEST *.egg-info

distclean: clean
	rm -rf .venv

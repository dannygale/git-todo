
deploy:
	cp git-todo ~/bin/

clean:
	find . | grep -E '(__pycache__|\.pyc|\.pyo$$)' | xargs rm -rf

typecheck:
	mypy

test:
	python -m unittest discover -s tests



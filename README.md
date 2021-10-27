Welcome to the Spark Advnaced Topics Working Group!

# Veiwing the docs

First make sure you have the requirements `pip install -r requirements.txt` then `mkdocs serve` should let you view the docs.

# Contributing

Yay! We are so excited you want to contribute! Pull requests are welcome.

## Layout

docs/details/
	- The details for each case

docs/flowchart/
	- The flow chart

private/
	- All company specific notes

tools/
	- tools for building & handling the repo
	- import.sh
		- try and pick up any external changes
	- export_external.sh
		- Export the repo (- company specifics) to OSS docs
		- You should run import before this
		- Requires git-filter-repo

# License

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

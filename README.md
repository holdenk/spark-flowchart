Welcome to the Spark Advanced Topics Working Group!

# Viewing the docs

First make sure you have the requirements `pip install -r requirements.txt` then `mkdocs serve` should let you view the docs.



If you have difficulty running `mkdocs serve` you may need to place your local pip path ahead of the other elements so that version of mkdocs takes precedence (e.g. for me `export PATH=~/.local/bin/:$PATH`).

# Contributing

Yay! We are so excited you want to contribute! Pull requests are welcome.

## Layout

- docs/details/
	- The details for each case
- docs/flowchart/
	- The flow chart
- private/
	- All company specific notes
- tools/
	- tools for building & handling integration with OSS export *requires OSS branch added as oss* (e.g. `git remote add oss git@github.com:holdenk/spark-flowchart.git` OR if you don't have push permissions to that your own OSS repo to raise PRs from)
	- export_external.sh
		- Export the repo (- company specifics) to OSS docs
		- You should cherry-pick any new OSS commits before running this
		- Requires git-filter-repo

# License

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

# git-todo: Git todo tracking for humans 
Create and manage todo items on the command line, from TODO tags in files, or through a curses-based terminal-UI (TUI). 

# Installation 

`make install`

git-todo is written in python and has limited external dependencies. To make sure git-todo works system-wide, `make
install` will deactivate any virtualenv, `pip install` the dependencies on your system-wide python, install `git-todo`
on your path, and reactivate your virtualenv. Git will automatically pick up `git-todo` for any commands starting with
`git todo`

# Usage 
There are three ways to interact with git-todo:
1. command-line only: add, edit, and manage todos from the command line. This will not interact with your source at all
2. scan source code: You can leave "TODO" tags in comments in your source files. git-todo will scan your source files
   and identify them, then automatically convert them to full todo tags.
3. Use your favorite editor and the `edit` command

The most efficient and powerful is a combination of the three. When editing files, place TODO tags as needed, then scan
your files. By default, scan does not modify your source files at all. To get the best use of git-todo, use `git-todo
scan --inplace` to automatically convert TODO tags to a format that git-todo will track and not duplicate. From there,
the todo items can be managed individually through the command line. If you have a lot of operations to do, it might be
more efficient to use the curses interface `git-todo curses`

I recommend the following aliases:
```
t = todo 
ta = todo add
tu = todo update
te = todo edit
td = todo detail
ti = todo inprogress
tw = todo workon
tf = todo finish
tx = todo cancel
ts = todo scan
```

## Tags
git-todo uses a regex to pick up todo messages in files. The regex is [TBC]. Even in non-source files, git-todo requires any TODO tag to be behind a one-line comment:
`# TODO: a todo item`
`// TODO: another todo item`
```
Anything to the right of TODO: will be captured as the description of the todo item. The regex is flexible depending on your specific preferences. You can use whitespace or not, you can use a colon after TODO or not. git-todo is expecting to find only one TODO item per line. Once scanned and updated, the two TODO tags above will be transformed to:
`# [1a2b3c4d][+] TODO: a todo item`
`// [5e6f7a8b][+] TODO: another todo item`
The two tags added between the comment and the TODO tag are a uuid and a status, respectively. The uuid is hashed based on the description, file, and line number. git-todo will use this ID to track the todo item, even if the description changes or the whole thing is moved to a different line, or even a different file. 

The status symbols git-todo understands are:
- '+': a new todo item produced on the most recent scan
- ' ': an open todo item
- '-': a todo item that has been marked as in-progress
- 'X': a todo item that's finished
- '/': a todo item that's been cancelled
You can edit the status symbol in a source file and rescan to update the status in the database, but the preferred method is to use the command-line or curses interfaces. These will update the symbol in your source file for you.

## Command-line
Each command has built-in help and additional flags not shown here:
- `git todo` (lists todos by default)
- `git todo add "todo description"`
- `git todo scan`
- `git todo edit [uuid]`

## Scan:
`git todo scan`
Scan your repository for items marked "TODO:" and automatically create and track TODO items for them. 

# Details
## "Database"
Todo items are stored in a human-readable JSON file. By default, this file is in the same directory as your .git folder, with the name .todo. Any additional information added to the todo item, such as category, branch, or due date, will be tracked here but not in your source file. This prevents cluttering the source files. 

# Future improvements
- TODO: pick up configuration from .git/config
- TODO: implement goto command
- TODO: implement "blocks" and "blocked_by"
- TODO: implement todos per branch
- TODO: implement unit tests
- TODO: implement todo categories (is this redundant with branches?)
- TODO: implement an update mechanism
- TODO: hide completed from list by default (if configured to do so?)
- TODO: use more interesting (unicode?) symbols for status symbols
- TODO: implement autocompletion for uuids and description

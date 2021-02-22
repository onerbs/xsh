# XSH

Another Bash library


## Requirements

- Upstream [V](https://github.com/vlang/v#installing-v-from-source)


## Setup

Clone this repository wherever you want, e.g. in `~/.xsh`

	git clone https://github.com/onerbs/xsh ~/.xsh

Source the `setup` script, preferably in your `~/.bashrc` file

	source ~/.xsh/setup


## Usage

xsh is segmented in "libs", to load a lib simply run:

	# you can load as many libs as you want
	lib alpha beta gamma

> try `lib -l` to list the available libs, or `lib -h` to get help


## Writing your own libs

Choose a desired location for your content, e.g. in `~/.ush`

You can name your lib whatever you want, even `base` or as any of the xsh libs,
the `lib` function will source both of them (if applicable).

To make your content visible to `lib`, run `xsh_watch ~/.ush` once.

> Only files with `sh` extension are recognized.


## About "folder libs"

Imagine you have the following tree:

	.ush/
	 ├─ gamma/
	 │   ├─ alpha.sh
	 │   ├─ beta.sh
	 │   └─ gamma.sh
	 └─ zeta.sh

By running `lib gamma`, all the libs inside the `gamma` directory will be sourced,
being `gamma.sh` the first (because the names are the same) and then the rest
of files in alphabetical order.

You can also source a particular lib by running `lib gamma/beta`
(this is useful in development mode, i.e. `lib -e gamma/beta`).

> Deeper nested libs won't be sourced.

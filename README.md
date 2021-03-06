# Quoted

[![Build Status](https://github.com/ellmetha/quoted/workflows/CI/badge.svg?branch=master)](https://github.com/ellmetha/quoted/actions)
[![codecov](https://codecov.io/gh/ellmetha/quoted/branch/master/graph/badge.svg)](https://codecov.io/gh/ellmetha/quoted)

Quoted is a pet project where random quotes are being matched to corresponding images. I worked on
this project in order to discover the [Crystal](https://crystal-lang.org/) language and to 
experiment with the [Kemal](https://kemalcr.com/) micro framework.

## System requirements

* [Crystal](https://crystal-lang.org/) 0.32+
* [kcov](https://github.com/SimonKagstrom/kcov) - for code coverage only

## Installation

If all the above system dependencies are properly installed on the target system, it should be 
possible to install the project using the following command:

```shell
$ make
```

This command will take care of installing the dependencies and initializing the environment-specific 
configuration. It should be noted that a [Pixabay API token](https://pixabay.com/api/docs/) is
needed in order for the application to perform images lookups: once you get one you'll have to
put it in the `pixabay_api_key` option in the `config/secrets/development.yml` file.

## Running the development server

The development server can be started using the following command:

```shell
$ make server
```

The development server should be accessible at http://127.0.0.1:3000.

## Running the test suite

The test suite can be run using the following command:

```shell
$ make test
```

For code coverage, the following command can be used:

```shell
$ make coverage
```

This will produce a coverage report under `./coverage`.

Finally, code quality checks can be triggered using the following command:

```shell
$ make qa
```

## License

MIT. See `LICENSE` for more details.

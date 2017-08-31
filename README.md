# Hackers at Cambridge Website
[![Build Status](https://travis-ci.org/hackersatcambridge/hac-website.svg?branch=master)](https://travis-ci.org/hackersatcambridge/hac-website)

This website is written using the Swift web framework [Kitura](https://github.com/IBM-Swift/Kitura) to allow us the flexibility to do what we please with the website and to allow us to try out Swift as an option for server-side programming.

## Installing and running the website

We use Docker to make this quick and painless for you, [make sure you have it installed](https://docs.docker.com/engine/installation/).

If you are on Windows, go to docker settings and ensure the drive you are using is shared.

This has been tested to work with at least `docker 17.03.0-ce, build 60ccb22` and `docker-compose version 1.11.2, build dfed245`.

Instructions are as follows. Clone this repository:

```bash
git clone https://github.com/hackersatcambridge/hac-website.git
```
Navigate to the hac-website directory that you've now cloned. Create an empty file named `.env`.
Save the file. Why did we have to do that? This file will later be used to store sensitive information like API keys and environment-specific information in here for our server to use.

Now run:

```bash
docker-compose up
```

This will build all the files and run the web server with appropriate output. It will also watch for changes to the files and rebuild as necessarily. You can stop this process at any time with `^C` (`ctrl` + `C`).

If the Dockerfile has been changed, run `docker-compose build`

### Unit Testing

In order to run unit tests:

```bash
docker-compose run web yarn test
```

### What `docker-compose up` is doing

This command starts up a docker container that has all the required dependencies, then starts up a development server.

Internally, this command uses the [Gulp task runner](http://gulpjs.com) to run the Swift and static file (CSS, images, etc.) build processes in parallel. When they complete, it runs the executable produced by the Swift build. It exposes a server on http://localhost:3000. For convenience, it will reload the browser window for you whenever you make a relevant change to the files. This is powered by BrowserSync, and you can access the interface for it at http://localhost:3001.

It is worth noting that we are using Gulp v4, which hasn't been officially released. It would be useful to refer to the [version 4 documentation](https://github.com/gulpjs/gulp/blob/4.0/docs/getting-started.md).

### Running commands in the container

If you want to access an instance of `yarn` or `swift` inside the Docker container to do some debugging or modifications, you can simply use `docker-compose run`.

```
docker-compose run web swift <<SWIFT COMMAND>>
docker-compose run web yarn <<YARN COMMAND>>
docker-compose run web yarn gulp <<GULP COMMAND>>
```

As the container shares source files with your project directory, any source files modified inside the container (e.g. `package.json`) will also be modified outside the container (and vice versa).

## Developing

### Writing HTML

You may notice that we aren't using a templating library for rendering HTML to serve. Inspired by the likes of [Elm](http://elm-lang.org/) and [React](https://facebook.github.io/react/), we've written a module _HaCTML_ for making HTML type-safe and Swifty! For an example, have a look at our [home page](Sources/HaCWebsiteLib/views/home.swift).

We're currently experimenting with the API for HaCTML, but once it's a little more stable we hope to release it as a standalone module.

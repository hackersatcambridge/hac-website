# Hackers at Cambridge Website
[![Build Status](https://travis-ci.org/hackersatcambridge/hac-website.svg?branch=master)](https://travis-ci.org/hackersatcambridge/hac-website)
> The public website of [Hackers at Cambridge]()

This website is built using the Swift web framework [Kitura](https://github.com/IBM-Swift/Kitura). This allows us to build the site fast and reliably and to learn about and contribute to server-side Swift in the process.

For more reasons as to why we chose to do things this way, please [read our blog post about it](https://medium.com/hackers-at-cambridge/why-were-writing-our-website-in-swift-2e620ae7b72b).

## Installing and running the website

### Docker

We use Docker to make installation quick and painless, [make sure you have it installed](https://docs.docker.com/engine/installation/). This has been tested to work with at least `docker 17.03.0-ce, build 60ccb22` and `docker-compose version 1.11.2, build dfed245`.

If you are on GNU/Linux, you will also need to [install Docker Compose](https://docs.docker.com/compose/install/) seperately

If you are on Windows, go to Docker settings and ensure the drive you are using is shared.

### Installation Instructions

- Clone this repository:
`git clone https://github.com/hackersatcambridge/hac-website.git`
- Navigate to the hac-website directory that you've now cloned
- Now run `docker-compose up`

This will build the project run the web server at [`localhost:3000`](http://localhost:3000). It will also watch for changes to the files and rebuild as necessarily. You can stop this process at any time with `^C` (`ctrl` + `C`).

### Subsequent runs

When you want to run the project again (and you will, it's great):

- If the Dockerfile has been changed, run `docker-compose build`
- run `docker-compose up`

## Notes on using Windows
If you are on Windows, go to Docker settings and ensure the drive you are using is shared.

We also use use [Gulp](https://gulpjs.com/) for hot-reloading and building of the website when we make edits during development, however as [inotify doesn't work on shared drives](https://github.com/docker/for-win/issues/56), hot-reloading doesn't work out of the box.

There is an [alternative solution available](http://blog.subjectify.us/miscellaneous/2017/04/24/docker-for-windows-watch-bindings.html), which essentially requires the following.

Run `pip install docker-windows-volume-watcher`, then, after you have done `docker-compose up`, open another console window and run `docker-volume-watcher`.

## Development

### Contributing

Please look at the [CONTRIBUTING.md](CONTRIBUTING.md) on how to contribute to
the project!

### *"Um. It looks like your HTML is written in Swift."*

You may notice that we aren't using a templating library for rendering HTML. Inspired by the likes of [Elm](http://elm-lang.org/) and [React](https://facebook.github.io/react/), we've written a module _HaCTML_ for making HTML type-safe and Swifty! For an example, have a look at our [home page](Sources/HaCWebsiteLib/ViewModels/LandingPage.swift).

We're currently experimenting with the API for HaCTML, and once it's a little more stable we hope to release it as a standalone module.

### Unit Testing

In order to run unit tests:

```bash
docker-compose run web yarn test
```

### Working with the Docker container

#### What `docker-compose up` is doing

This command starts up a docker container that has all the required dependencies, then starts up a development server.

Internally, this command uses the [Gulp task runner](http://gulpjs.com)*. Check out [our Gulpfile](https://github.com/hackersatcambridge/hac-website/blob/master/gulpfile.js) to see everything that does.

**TL;DR**

- Builds the Swift files
- Builds the stylesheets
- Starts the server (at [`localhost:3000`](http://localhost:3000))
- Waits eagerly for you to make changes to any of the files, rebuilds, and reloads the browser (powered by [BrowserSync](https://github.com/Browsersync/browser-sync))

\*It is worth noting that we are using Gulp v4, which hasn't been officially released. It would be useful to refer to the [version 4 documentation](https://github.com/gulpjs/gulp/blob/4.0/docs/getting-started.md).

#### Running commands in the container

If you want to access an instance of `yarn` or `swift` inside the Docker container to do some debugging or modifications, you can simply use `docker-compose run`.

```
docker-compose run web swift <<SWIFT COMMAND>>
docker-compose run web yarn <<YARN COMMAND>>
docker-compose run web yarn gulp <<GULP COMMAND>>
```

As the container shares source files with your project directory, any source files modified inside the container (e.g. `package.json`) will also be modified outside the container (and vice versa).

## Documentation

Documentation on further features can be found in the [`/Docs`](/Docs) folder.

# Hackers at Cambridge Website [![Build Status](https://travis-ci.org/hackersatcambridge/hac-website.svg?branch=master)](https://travis-ci.org/hackersatcambridge/hac-website)
> The public website of [Hackers at Cambridge]()

This website is built using the Swift web framework [Kitura](https://github.com/IBM-Swift/Kitura). This allows us to build the site fast and reliably and to learn about and contribute to server-side Swift in the process. 


## Installing and running the website

**Docker**

We use Docker to make installation quick and painless, [make sure you have it installed](https://docs.docker.com/engine/installation/). This has been tested to work with at least `docker 17.03.0-ce, build 60ccb22` and `docker-compose version 1.11.2, build dfed245`.

If you are on Windows, go to docker settings and ensure the drive you are using is shared.

**Installation Instructions**

- Clone this repository:
`git clone https://github.com/hackersatcambridge/hac-website.git`
- Navigate to the hac-website directory that you've now cloned
- Create an empty file named `.env` and save it*
- Now run `docker-compose up`

This will build the project run the web server at [`localhost:3000`](http://localhost:3000). It will also watch for changes to the files and rebuild as necessarily. You can stop this process at any time with `^C` (`ctrl` + `C`).

**Subsequent runs**

When you want to run the project again (and you will, it's great):  

- If the Dockerfile has been changed, run `docker-compose build`
- run `docker-compose up`

\**Why did we have to do that?* The `.env` file will later be used to store sensitive information like API keys and environment-specific information in here for our server to use.

## Development
- ["Um. It looks like your HTML is written in Swift."](#writinghtml)
- Writing stylesheets (with BEM)
- Working with the container
	- What `docker-compose` is doing
	- Running unit tests
	- Running other commands


### *"Um. It looks like your HTML is written in Swift."*

You may notice that we aren't using a templating library for rendering HTML. Inspired by the likes of [Elm](http://elm-lang.org/) and [React](https://facebook.github.io/react/), we've written a module _HaCTML_ for making HTML type-safe and Swifty! For an example, have a look at our [home page](Sources/HaCWebsiteLib/views/home.swift).

We're currently experimenting with the API for HaCTML, and once it's a little more stable we hope to release it as a standalone module.

### Our Stylesheets and Their BEM
CSS is great but it's easy to end up with hundreds of classes that overlap, underlap and wrestle with each other and that's when things get a whole lot less fun. To keep our stylesheets from this fate, we adopt the [BEM naming convention](http://getbem.com/naming/) for CSS classes. This stands for Block, Element, Modifier and it makes it a lot easier to think about styling individual components of the site!

The best way to get to grips with this is to skim through [our stylesheets](https://github.com/hackersatcambridge/hac-website/tree/master/static/src/styles).

Here's an example:  

- The info cards on the landing page have the class `PostCard`. A `PostCard` is a 'block', since these cards are meaningful on their own. Notice the CamelCase in this class name.

- The photo on an info card has the class `PostCard__photoBackground`. This is an 'element' since it lives within a block and is specific to that block so doesn't make sense on its own. Notice the double underscore in the class name to separate the block name from the element name.

Once you feel comfortable with this convention, give it a whirl! The team will be happy to give you pointers on this naming convention in code review.


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

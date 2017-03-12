# Hackers at Cambridge Website

This website is written using the Swift web framework [Kitura](https://github.com/IBM-Swift/Kitura) to allow us the flexibility to do what we please with the website and to allow us to try out Swift as an option for server-side programming.

## Installing and running the website
This project uses the [Gulp v4](http://gulpjs.com) to make this super simple. 

First make sure you have [Node](https://nodejs.org/en/) (you will need `npm` to install and run Gulp) and [Swift 3](https://swift.org/download/) installed 

Then you will need to install the gulp-cli globally:
```
npm rm -g gulp
npm install -g gulp-cli
```
Note: This won't interfere with other Gulp projects you may have on your machine, the new CLI is backwards compatible. For more details on using Gulp 4, see [this blog post](https://www.liquidlight.co.uk/blog/article/how-do-i-update-to-gulp-4/)

Clone this repository

```
git clone https://github.com/hackersatcambridge/hac-website.git
```

And then run:

```
npm install
```

followed by:

```
gulp serve
```

This will build all the files and run the web server with appropriate output. Gulp will also watch for changes to the files and rebuild as necessarily. You can stop this process at any time with `^C` (`ctrl` + `C`).
### What `gulp serve` is doing
This command runs the Swift and static file (CSS, images, etc.) build processes in parallel. When they complete, it runs the executable produced by the Swift build. This starts a local server on http://localhost:8090. For convenience, it also starts a BrowserSync server on port 3000 (and a BroswerSync interface on port 3001) that simply serves as a proxy to http://localhost:8090 but with the added feature that it will reload the browser window for you whenever you make a relevant change to the files.

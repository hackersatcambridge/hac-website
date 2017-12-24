const gulp = require('gulp')
const changed = require('gulp-changed')
const browserSync = require('browser-sync').create()
const childProcesses = require('child_process')
const chalk = require('chalk')
const fs = require('fs')
const path = require('path')
const webpack = require('webpack')
const webpackStream = require('webpack-stream')
const ManifestPlugin = require('webpack-manifest-plugin')
const ExtractTextPlugin = require('extract-text-webpack-plugin')

// Define a global serverProcess that we can use to keep track of the running server instance
let serverProcess = null

// Whether our webpack task should be watching or not
let isStaticBuildWatching = false

const PROJECT_ROOT = __dirname;
const EXEC_PATH = './.build/debug/HaCWebsite'
const isProduction = process.env.NODE_ENV === 'production'

function setWatchOnBuildStatic () {
  isStaticBuildWatching = true
  return Promise.resolve()
}

function buildStatic () {
  // To prevent lots of files and add ease to live reloading,
  // We don't want to hash filenames in dev mode
  const dotHash = isProduction ? '.[hash]' : ''

  return gulp.src('static/src/main.js')
    .pipe(
      webpackStream({
        watch: isStaticBuildWatching,
        context: path.join(PROJECT_ROOT, 'static/src'),
        entry: {
          // Scripts entry points
          main: './main.js',
          // Styles entry points
          'styles/main': './styles/main.styl',
          // TODO: Ideally we want this to be a wildcard match of some form
          // so we can automatically pick-up new custom styles.
          'styles/custom/gamegig2017': './styles/custom/gamegig2017.styl'
        },
        output: {
          filename: `[name]${dotHash}.js`,
          publicPath: '/static/'
        },
        module: {
          // We add rules explicitly for every file type
          // If you need to support a new file extension, edit a rule below
          // or add a new one
          rules: [
            {
              test: /\.styl$/,
              use: ExtractTextPlugin.extract({
                use: 'css-loader!postcss-loader!stylus-loader',
              }),
            },
            {
              test: /\.(png|jpg|gif|woff|woff2|ttf|eot|svg)$/,
              loader: 'file-loader',
              options: {
                name: `[path][name]${dotHash}.[ext]`,
              }
            }
          ]
        },
        resolve: {
          extensions: ['.js', '.styl']
        },
        plugins: [
          new ManifestPlugin({
            fileName: 'manifest.json'
          }),
          new ExtractTextPlugin(`[name]${dotHash}.css`),
        ]
      }, webpack)
    )
    .pipe(changed('static/dist', { hasChanged: changed.compareContents }))
    .pipe(gulp.dest('static/dist/'))
    .pipe(browserSync.stream())
}

// Hooks up the stdout adn stderr of a child process to the gulp output
function connectProcessOutput (process, prefix) {
  const logPrefix = prefix == null ? '' : '[' + chalk.blue(prefix) + '] '
  process.stdout.on('data', function (data) {
    data.toString().split('\n').map(line => console.log(logPrefix, line));
  })
  process.stderr.on('data', function (data) {
    data.toString().split('\n').map(line => console.log(logPrefix, chalk.red(line)))
  })
}

// Runs the `swift build` command
function swiftBuild (done) {
  var stream = fs.createWriteStream("swift_build.log");

  stream.once('open', function(fd) {
    const buildProcess = childProcesses.spawn('swift', ['build'])

    buildProcess.stdout.on('data', data => {
      stream.write(data);
    });
    buildProcess.stderr.on('data', data => {
      stream.write(data);
    });

    const logPrefix = 'swift-build'
    connectProcessOutput(buildProcess, logPrefix)
    buildProcess.on('exit', function (code) {
      stream.end();
      if (code === 0) {
        fs.unlink("swift_build.log");
        done()
      } else {
        // The build failed
        // Ring the console 'bell'
        console.log('\u0007')
        done()
      }
    });
  });
}

// Starts our server process
function startServer (done) {
  serverProcess = childProcesses.spawn(EXEC_PATH)
  serverProcess.on('exit', function (code) {
    serverProcess = null
  })
  connectProcessOutput(serverProcess, 'web-server')

  // Wait for Kitura to tell us it's listening
  serverProcess.stdout.on('data', function (data) {
    if (data.toString().includes('Listening on port')) {
      done()
    }
  })
}

// Starts our server process, killing it first if necessary
function reloadServer (done) {
  if (serverProcess === null) {
    startServer(done)
  } else {
    serverProcess.kill()
    serverProcess.on('exit', function (code) {
      // The process exited, restart it
      startServer(done)
    })
  }
}

function reloadBrowser (done) {
  browserSync.reload()
  done()
}

function watch () {
  browserSync.init({
    proxy: 'http://localhost:8090',
    notify: false,
    open: false,
    ghostMode: false
  })
  gulp.watch(['Sources/**/*', 'Package.swift'], gulp.series(swiftBuild, reloadServer, reloadBrowser))
}

const build = gulp.parallel(swiftBuild, buildStatic)
const serve = gulp.series(setWatchOnBuildStatic, swiftBuild, gulp.parallel(buildStatic, reloadServer, watch))

// Expose the serve and build tasks
gulp.task('static-build', buildStatic)
gulp.task('build', build)
gulp.task('serve', serve)

// When the gulp process is terminated, make sure to clean up
process.on('exit', function () {
  if (serverProcess != null) {
    serverProcess.kill()
  }
})

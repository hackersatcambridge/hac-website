const gulp = require('gulp')
const autoprefixer = require('gulp-autoprefixer')
const changed = require('gulp-changed')
const stylus = require('gulp-stylus')
const browserSync = require('browser-sync').create()
const childProcesses = require('child_process')
const chalk = require('chalk')

// Define a global serverProcess that we can use to keep track of the running server instance
let serverProcess = null

const EXEC_PATH = './.build/debug/HaCWebsite'

// A straight copy of files that don't require processing
// You should update this glob if you ever add processing to a new file type
function copy () {
  return gulp.src('static/src/**/!(*.styl)')
    .pipe(changed('static/dist'))
    .pipe(gulp.dest('static/dist'))
}

// Process the Stylus files into CSS
function buildStyles () {
  return gulp.src('static/src/styles/main.styl')
    .pipe(changed('static/dist/styles'))
    .pipe(stylus({
      'include css': true,
      paths: ['./node_modules']
    }))
    .on('error', function (err) {
      console.log('[' + chalk.red('Stylus error...') + ']')
      console.log(err.message)
      console.log('\u0007')
      this.emit('end')
    })
    .pipe(autoprefixer())
    .pipe(gulp.dest('static/dist/styles'))
    .pipe(browserSync.stream())
}

function trimNewLine (string) {
  return string.replace(/\n$/, '')
}

// Hooks up the stdout adn stderr of a child process to the gulp output
function connectProcessOutput (process, prefix) {
  const logPrefix = prefix == null ? '' : '[' + chalk.blue(prefix) + '] '
  process.stdout.on('data', function (data) {
    console.log(logPrefix, trimNewLine(data.toString()))
  })
  process.stderr.on('data', function (data) {
    console.log(logPrefix, chalk.red(trimNewLine(data.toString())))
  })
}

// Runs the `swift build` command
function swiftBuild (done) {
  const buildProcess = childProcesses.spawn('swift', ['build'])
  const logPrefix = 'swift-build'
  connectProcessOutput(buildProcess, logPrefix)
  buildProcess.on('exit', function (code) {
    if (code === 0) {
      done()
    } else {
      // The build failed
      // Ring the console 'bell'
      console.log('\u0007')
      done()
    }
  })
}

// Starts our server process
function startServer (done) {
  serverProcess = childProcesses.spawn(EXEC_PATH)
  serverProcess.on('exit', function (code) {
    serverProcess = null
  })
  connectProcessOutput(serverProcess, 'kitura')

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

// All the tasks that handle the building of static files
const buildStaticAssets = gulp.parallel(buildStyles, copy)

function watch () {
  browserSync.init({
    proxy: 'http://localhost:8090',
    notify: false,
    open: false,
    ghostMode: false
  })
  gulp.watch('static/src/styles/**/*.styl', gulp.parallel(buildStyles))
  gulp.watch('static/src/**/!(*.styl)', gulp.parallel(copy))
  gulp.watch(['Sources/**/*', 'Package.swift'], gulp.series(swiftBuild, reloadServer, reloadBrowser))
}

const build = gulp.parallel(swiftBuild, buildStaticAssets)
const serve = gulp.series(build, gulp.parallel(reloadServer, watch))

// Expose the serve and build tasks
gulp.task('static-build', buildStaticAssets)
gulp.task('build', build)
gulp.task('serve', serve)

// When the gulp process is terminated, make sure to clean up
process.on('exit', function () {
  if (serverProcess != null) {
    serverProcess.kill()
  }
})

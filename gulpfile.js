const gulp = require('gulp')
const autoprefixer = require('gulp-autoprefixer')
const changed = require('gulp-changed')
const stylus = require('gulp-stylus')
const browserSync = require('browser-sync').create()
const childProcesses = require('child_process')
const chalk = require('chalk')

// Define a global serverProcess that we can use to keep track of the running server instance
let serverProcess = null

const EXEC_PATH = './.build/debug/HackersAtCambridgeWebsite'

// A straight copy of files that don't require processing
// You should update this glob if you ever add processing to a new file type
gulp.task('copy', () =>
  gulp.src('static/src/**/!(*.styl)')
    .pipe(changed('static/dist'))
    .pipe(gulp.dest('static/dist'))
)

// Process the Stylus files into CSS
gulp.task('styles', () =>
  gulp.src('static/src/styles/**/*.styl')
    .pipe(changed('static/dist/styles'))
    .pipe(stylus({
      'include css': true,
      paths: ['./node_modules']
    }))
    .pipe(autoprefixer())
    .pipe(gulp.dest('static/dist/styles'))
    .pipe(browserSync.stream())
)

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

// Runs the `swift build` task
gulp.task('swift-build', function (done) {
  const swiftBuild = childProcesses.spawn('swift', ['build'])
  const logPrefix = 'swift-build'
  connectProcessOutput(swiftBuild, logPrefix)
  swiftBuild.on('exit', function (code) {
    if (code === 0) {
      done()
    } else {
      // Ring the console 'bell'
      console.log('\u0007')
      done()
    }
  })
})

function spawnServer () {
  serverProcess = childProcesses.spawn(EXEC_PATH)
  setTimeout(browserSync.reload, 300)
}

// Runs the built Swift package
gulp.task('reload-server', function (done) {
  if (serverProcess === null) {
    spawnServer()
    done()
  } else {
    serverProcess.kill()
    serverProcess.on('exit', function (code) {
      // The process exited, restart it
      spawnServer()
      done()
    })
  }
})

// Run the Kitura server
gulp.task('start-server', function (done) {
  serverProcess = childProcesses.spawn(EXEC_PATH)
  connectProcessOutput(serverProcess, 'kitura')
  done()
})

// All the tasks that handle the building of static files
gulp.task('static-build', gulp.parallel('styles', 'copy'))

gulp.task('swift-reload', function (done) {
  gulp.task
})

// Watch for changes and perform appropriate actions
gulp.task('watch', function () {
  // Start browserSync in proxy mode. Augments the server at localhost:8090
  browserSync.init({
    proxy: 'http://localhost:8090',
    notify: false
  })
  gulp.watch('static/src/styles/**/*.styl', gulp.parallel('styles'))
  gulp.watch('static/src/**/!(*.styl)', gulp.parallel('copy'))
  gulp.watch('Views/**/*.stencil', function (done) {
    browserSync.reload()
    done()
  })
  gulp.watch('Sources/**/*', gulp.series('swift-build', 'reload-server'))
})

gulp.task('serve', gulp.series(gulp.parallel('swift-build', 'static-build'), gulp.parallel('start-server', 'watch')))

// When the gulp process is terminated, make sure to clean up
process.on('exit', function () {
  if (serverProcess != null) {
    serverProcess.kill()
  }
})

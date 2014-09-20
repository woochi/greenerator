gulp = require("gulp")
sass = require("gulp-ruby-sass")
gutil = require("gulp-util")
autoprefixer = require("gulp-autoprefixer")
minifyCSS = require('gulp-minify-css')

gulp.task "sass", ->
  gulp.src("src/stylesheets/app.sass")
    .pipe(sass(compass: true, loadPath: ["bower_components/foundation/scss"]))
    .on('error', gutil.log)
		.on('error', gutil.beep)
    .pipe(autoprefixer("last 1 version", "> 1%", "ie 8", "ie 7"))
    .pipe(minifyCSS())
    .pipe gulp.dest("build/stylesheets")

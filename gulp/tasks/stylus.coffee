gulp = require("gulp")
stylus = require("gulp-stylus")
nib = require("nib")
gutil = require("gulp-util")

gulp.task "stylus", ->
  gulp.src("./src/stylesheets/app.styl")
    .pipe(stylus(use: [nib()]))
    .on('error', gutil.log)
		.on('error', gutil.beep)
    .pipe(gulp.dest("./build/stylesheets"))

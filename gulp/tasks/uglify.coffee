gulp = require("gulp")
uglify = require("gulp-uglify")

gulp.task "uglify", ["browserify"], ->
  gulp.src("build/javascripts/app.js")
    .pipe(uglify())
    .pipe(gulp.dest("build/javascripts"))

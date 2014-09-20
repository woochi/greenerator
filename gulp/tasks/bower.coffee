gulp = require("gulp")
bower = require('gulp-bower')
path = require("path")

gulp.task 'bower', ->
  console.log(__dirname)
  bower(directory: "./bower_components", cwd: path.join(__dirname, "../../"))
    .pipe gulp.dest('./build/')

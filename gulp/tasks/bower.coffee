gulp = require("gulp")
bower = require('gulp-bower')

gulp.task 'bower', ->
  bower("./bower_components").pipe gulp.dest('./build/')

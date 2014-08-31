gulp = require("gulp")
bower = require('gulp-bower')

gulp.task 'bower', ->
  bower().pipe gulp.dest('./build/')

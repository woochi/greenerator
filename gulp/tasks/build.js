var gulp = require('gulp');

gulp.task('build', ['bower-files', 'browserify', 'sass', 'images']);

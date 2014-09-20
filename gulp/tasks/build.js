var gulp = require('gulp');

gulp.task('build', ['bower-files', 'browserify', 'sass', 'images']);
gulp.task('build-production', ['bower-files', 'browserify', 'sass', 'uglify', 'images']);

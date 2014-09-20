var browserify   = require('browserify');
var gulp         = require('gulp');
var handleErrors = require('../util/handleErrors');
var source       = require('vinyl-source-stream');

gulp.task('browserify', ['bower-files'], function(){
	return browserify({
			entries: ['./src/javascripts/app.coffee'],
			extensions: ['.coffee', '.hbs'],
			debug: true
		})
		.bundle()
		.on('error', handleErrors)
		.pipe(source('app.js'))
		.pipe(gulp.dest('./build/javascripts/'));
});

gulp = require("gulp")
mainBowerFiles = require("main-bower-files")
path = require("path")

gulp.task "bower-files", ->
  gulp.src(mainBowerFiles(
    paths:
      bowerDirectory: path.join(__dirname, "../../bower_components")
      bowerrc: path.join(__dirname, "../../.bowerrc")
      bowerJson: path.join(__dirname, "../../bower.json")
  )).pipe(gulp.dest('./build/javascripts/'))

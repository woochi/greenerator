gulp = require("gulp")

gulp.task "express", ->
  app = require("../../app.coffee")
  app.listen(4000)

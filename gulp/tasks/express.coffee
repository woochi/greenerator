gulp = require("gulp")
phantom = require("phantom")

gulp.task "express", ->
  app = require("../../app.coffee")
  app.listen(4000)

  phantom.create (ph) ->
    ph.createPage (page) ->
      page.open "http://localhost:4000/download", (status) ->
        getTitle = -> return document.title
        page.set "paperSize", {format: "A4"}, ->
          page.render "/Users/woochi/Projects/greenerator/sheet2.pdf", ->
            ph.exit()

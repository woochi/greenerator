$ = require("jquery")
React = require("react")
Generator = require("./generator.coffee")

React.renderComponent Generator(), $('body').get(0)

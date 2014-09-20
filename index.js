coffee = require("coffee-script/register")

var app = require("./app.coffee");
app.listen(process.env.PORT || 4000);

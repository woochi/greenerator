express = require('express')
router = express.Router()

router.get '/', (req, res) ->
  res.render('download')

module.exports = router

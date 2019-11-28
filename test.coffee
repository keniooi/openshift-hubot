# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

getarg = (arg)->
  index = arg.indexOf " "
  arg = arg.substring(index+1)
  return arg

epochd = (res, d) ->
  res.send(d.toLocaleString())

epoch = (res, d) ->
  res.send(''+d.getTime())


module.exports = (robot) ->

  isDone = 0

  robot.hear /epoch [0-9]{10}/, (res) ->
     if isDone is 0
        time = getarg(res.match[0])
        d = new Date(0);
        d.setUTCSeconds(time)
        epochd(res,d)
        isDone = 1

  robot.hear /epoch [0-9]{13}/, (res) ->
     if isDone is 0
        time = getarg(res.match[0])
        d = new Date(time)
        epochd(res,d)
        isDone = 1

  robot.hear /epoch [0-9]{4}(-|\/)[0-9]{1,2}(-|\/)[0-9]{1,2} [0-9]{2}:[0-9]{2}:[0-9]{2}/, (res) -> 
     if isDone is 0
        time = getarg(res.match[0])
        time = time.replace(/-/g, '/')
        d = new Date(time)
        epoch(res,d)
        isDone = 1

  robot.hear /epoch now/, (res) ->
     if isDone is 0
        d = new Date()
        epochd(res,d)
        epoch(res,d)
        isDone = 1

  robot.hear /epoch.*/, (res) ->
     if isDone is 0
        res.send("epoch 1234567890 / epoch 1234567890123 / epoch 2019-12-31 23:59:59 / epoch now")
        isDone = 1


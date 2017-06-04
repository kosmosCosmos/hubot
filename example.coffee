# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

  robot.hear /post (.*) (.*) (.*)/i, (res) ->
    input=res.match[0].split(" ")
    input1=input[1]
    input2=input[2]
    input3=input[3..-1].join()
    robot.http("http://35.194.133.234:8088/v1/app/#{input2}/#{input1}/#{encodeURI(input3)}")
      .header('Accept', 'application/json')
      .get() (err, response, body) ->
# error checking code here
        data = JSON.parse body
        if input2=='title'
          res.reply("update PostID #{data.id} for title #{data.title}")
          res.reply("Content:#{data.title}")
          res.reply("title Done")
        else if input2=='tag'
          res.reply("update PostID #{data.id} for tag #{data.tag}")
          res.reply("Content:#{data.tag}")
          res.reply("tag Done")
        else if input2=='comment'
          res.reply("update PostID #{data.id} for comment")
          res.reply("Content:#{data.comment}")
          res.reply("comment Done")

  robot.hear /fetch (.*)/i, (res) ->
    robot.http("http://35.194.133.234:8088/v1/app/url/#{res.match[1]}")
      .header('Accept', 'application/json')
      .get() (err, response, body) ->
# error checking code here
        data = JSON.parse body
        res.reply("Getting #{data.url}")
        res.reply("       ")
        res.reply("Done!")
        res.reply("       ")
        res.reply("ID:#{data.id}")
        res.reply("Url:#{data.url}")

  robot.hear /blog (.*)/i, (res) ->
    robot.http("http://35.194.133.234:8088/v1/app/post/#{res.match[1]}")
      .header('Accept', 'application/json')
      .get() (err, response, body) ->
        data = JSON.parse body
        res.reply("Posting #{data.id}")
        if data.result=='success'
          res.reply("       ")
          res.reply("Done!")
        else
          res.reply("       ")
          res.reply("Failed,#{data.result}")








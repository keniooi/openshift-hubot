# specify the node base image with your desired version node:<version>
FROM nodejs/hubot:latest

# ENV HUBOT_NAME bot4you
# ENV HUBOT_SLACK_TOKEN *Put your token on this*
ENV NO_UPDATE_NOTIFIER true
ENV HOME /home/hubot
ADD test.coffee /home/hubot/scripts

CMD bin/hubot -n $HUBOT_NAME --adapter slack

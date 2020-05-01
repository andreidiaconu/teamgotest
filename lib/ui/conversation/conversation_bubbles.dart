import 'package:flutter/material.dart';
import 'package:teamgotest/model/conversation_message.dart';

class CurrentUserMessageBubble extends StatelessWidget {
  final ConversationMessage message;

  const CurrentUserMessageBubble({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(width: 40),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.brown.shade200),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "ME",
                      style: Theme.of(context).textTheme.overline,
                    ),
                    Text(
                      message.message,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          SizedBox(
            width: 32,
            height: 32,
            child: CircleAvatar(
              backgroundImage: NetworkImage(message.author.avatar),
            ),
          ),
        ],
      ),
    );
  }
}

class OtherUserMessageBubble extends StatelessWidget {
  final ConversationMessage message;

  const OtherUserMessageBubble({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: CircleAvatar(
              backgroundImage: NetworkImage(message.author.avatar),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey.shade300),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.author.name.toUpperCase(),
                      style: Theme.of(context).textTheme.overline,
                    ),
                    Text(
                      message.message,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 40),
        ],
      ),
    );
  }
}
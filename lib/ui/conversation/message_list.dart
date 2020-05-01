import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teamgotest/business_logic/session_state.dart';
import 'package:teamgotest/model/conversation_message.dart';
import 'package:teamgotest/ui/conversation/conversation_bubbles.dart';

class MessagesList extends StatelessWidget {
  final List<ConversationMessage> messages;

  const MessagesList({Key key, this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SessionState session = Provider.of<SessionState>(context);
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: messages.length,
      itemBuilder: (context, index) =>
      messages[index].author == session.currentUser
          ? CurrentUserMessageBubble(message: messages[index])
          : OtherUserMessageBubble(message: messages[index]),
    );
  }
}
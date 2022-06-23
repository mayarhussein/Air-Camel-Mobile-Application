import 'package:air_camel/constants.dart';
import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class ChatBotScreen extends StatefulWidget {
  static const routeName = '/chatbot';

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final _inputFocusNode = FocusNode();
  final _submitFocusNode = FocusNode();

  late DialogFlowtter dialogFlowtter;
  final TextEditingController messageController = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
  }

  void _submit() {
    sendMessage(messageController.text);
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var themeValue = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text(
          'Air Camel bot',
          style: headFont1,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Body(messages: messages)),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      focusNode: _inputFocusNode,
                      controller: messageController,
                      onFieldSubmitted: (_) {
                        _submit();
                        _inputFocusNode.requestFocus();
                      },
                      style: TextStyle(
                          color: themeValue == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontFamily: 'Poppins'),
                      decoration: new InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: themeValue == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                            borderRadius: BorderRadius.circular(15)),
                        hintStyle: TextStyle(
                          color: themeValue == Brightness.dark
                              ? Colors.white54
                              : Colors.black54,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                        labelStyle: TextStyle(
                            color: themeValue == Brightness.dark
                                ? Colors.white
                                : Colors.black),
                        hintText: 'Send a message',
                      ),
                    ),
                  ),
                  IconButton(
                    focusNode: _submitFocusNode,
                    color: themeValue == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    icon: Icon(Icons.send),
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage(String text) async {
    if (text.isEmpty) return;
    setState(() {
      addMessage(
        Message(text: DialogText(text: [text])),
        true,
      );
    });

    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: text)),
    );

    if (response.message == null) return;
    setState(() {
      addMessage(response.message!);
    });
  }

  void addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
  }

  @override
  void dispose() {
    dialogFlowtter.dispose();
    _inputFocusNode.dispose();
    _submitFocusNode.dispose();
    super.dispose();
  }
}

class _MessageContainer extends StatelessWidget {
  final Message message;
  final bool isUserMessage;

  const _MessageContainer({
    Key? key,
    required this.message,
    this.isUserMessage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 250),
      child: LayoutBuilder(
        builder: (context, constrains) {
          return Container(
            decoration: BoxDecoration(
              color: isUserMessage ? Colors.blue : Colors.grey[800],
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              message.text?.text?[0] ?? '',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}

class Body extends StatelessWidget {
  final List<Map<String, dynamic>> messages;

  const Body({
    Key? key,
    this.messages = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, i) {
        var obj = messages[messages.length - 1 - i];
        Message message = obj['message'];
        bool isUserMessage = obj['isUserMessage'] ?? false;
        return Row(
          mainAxisAlignment:
              isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _MessageContainer(
              message: message,
              isUserMessage: isUserMessage,
            ),
          ],
        );
      },
      separatorBuilder: (_, i) => Container(height: 10),
      itemCount: messages.length,
      reverse: true,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
    );
  }
}

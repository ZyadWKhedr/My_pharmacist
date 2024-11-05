import 'dart:io';
import 'dart:typed_data';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class GeminiChatPage extends StatefulWidget {
  const GeminiChatPage({super.key});

  @override
  State<GeminiChatPage> createState() => _GeminiChatPageState();
}

class _GeminiChatPageState extends State<GeminiChatPage> {
  final Gemini gemini = Gemini.instance; 
  List<ChatMessage> messages = []; // List to hold chat messages

  // Define users
  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "Gemini",
    profileImage:
        "https://seeklogo.com/images/G/google-gemini-logo-A5787B2669-seeklogo.com.png",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chat with AI"),
      ),
      body: _buildUI(), // Build the chat UI
    );
  }

  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(
        trailing: [
          // Button to send media messages
          IconButton(
            onPressed: _sendMediaMessage,
            icon: const Icon(Icons.image),
          ),
        ],
      ),
      currentUser: currentUser, 
      onSend: _sendMessage, // Function to call when sending a message
      messages: messages, // List of messages
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    // Add the sent message to the list
    setState(() {
      messages = [chatMessage, ...messages];
    });

    try {
      String question = chatMessage.text; // Get the message text
      List<Uint8List>? images;

      // If the message contains media, read the image file
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }

      // Send the question to Gemini and listen for a response
      gemini.streamGenerateContent(question, images: images).listen((event) {
       
        String response = event.content?.parts?.fold(
                "", (previous, current) => "$previous ${current.text}") ??
            "";

        // Create a new chat message with the AI's response
        ChatMessage message = ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: response,
        );

        // Update the message list with the AI's response
        setState(() {
          messages = [message, ...messages];
        });
      });
    } catch (e) {
      
      print(e);
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source:
          ImageSource.gallery, // Allow user to select an image from the gallery
    );

    // If an image is selected, create a chat message for it
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "Describe this picture?",
        medias: [
          ChatMedia(
            url: file.path,
            fileName: "",
            type: MediaType.image,
          )
        ],
      );
      _sendMessage(chatMessage); // Send the media message
    }
  }
}

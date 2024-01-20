import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_camera/whatsapp_camera.dart';

Color themeColor = Color.fromARGB(255, 136, 165, 81);

class Assistant extends StatefulWidget {
  @override
  _AssistantState createState() => _AssistantState();
}

class _AssistantState extends State<Assistant> {
  List<Map<String, dynamic>> chatMessages = [];
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Add a hardcoded welcome message from the bot
    final botWelcomeMessage = {
      'role': 'bot',
      'content':
          "Hi there! Welcome! I'm Duribot, your AI assistant. Ask me anything about durian.",
    };
    // Add the welcome message to the chatMessages list
    chatMessages.add(botWelcomeMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg/3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 40),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: chatMessages.length,
                  itemBuilder: (context, index) {
                    final message = chatMessages[index];
                    return buildMessageContainer(
                      message['role']!,
                      message['content']!,
                    );
                  },
                ),
              ),
              textInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMessageContainer(String role, dynamic content) {
    final isUser = role.toLowerCase() == 'user';
    final isImage = content is File;

    return Container(
      margin: EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        right: isUser ? 0 : 40,
        left: isUser ? 40 : 00,
      ),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isUser ? Color.fromRGBO(47, 203, 166, 0) : Colors.transparent,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (isImage)
              Container(
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.file(
                    content,
                    fit: BoxFit.cover,
                    width: 300,
                    height: 200,
                  ),
                ),
              ),
            if (!isImage)
              Container(
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    content,
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Padding textInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Color.fromARGB(255, 193, 193, 193),
            width: 0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25.0, top: 5, bottom: 5, right: 15),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  onSubmitted: (_) {
                    sendMessage();
                  },
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.camera,
                  size: 30,
                  color: themeColor,
                ),
                onPressed: () {
                  takePicture(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    sendMessage();
                  },
                  icon: Icon(Icons.send_rounded, size: 30, color: themeColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendMessage() {
    final userMessage = {
      'role': 'user',
      'content': messageController.text,
    };

    setState(() {
      chatMessages.add(userMessage);
    });

    fetchDataFromAPI(message: messageController.text);
    messageController.clear();

    scrollToBottom();
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> fetchDataFromAPI({required String message}) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer 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',
    };

    final body = {
      "model": "gpt-3.5-turbo-1106",
      "response_format": {"type": "json_object"},
      "messages": [
        {
          "role": "system",
          "content":
              '''As the Duribot assistant, your role is to output JSON in the format: {'response': response}. Your task is to assist in providing information on durian, following this format if the users asked you for information on Durian general info, however for other requests, then response normal:

                Durian Type:
                new line
                Other Names:
                new line
                Place Of Origin:
                new line
                Market Value In Malaysia (provide a number in MYR):
                new line
                Disease: This durian has stem rot, which is a destructive fungal disease occurring with durian fruits.
                new line
                Additionally, in your responses, please format the string properly by adding new lines for readability. Keep your answers concise, with a length of 50 words.

                if user asks for market size for a specific type of durian, just come up with any number tho currency is in MYR
              '''
        },
        {"role": "user", "content": message}
      ]
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final responseData = json.decode(
            jsonResponse['choices'][0]["message"]["content"])["response"];

        final botMessage = {
          'role': 'bot',
          'content': responseData.toString(),
        };

        setState(() {
          chatMessages.add(botMessage);
          scrollToBottom();
        });
      } else {
        final errorMessage = {
          'role': 'bot',
          'content': 'Error: ${response.statusCode}',
        };

        setState(() {
          chatMessages.add(errorMessage);
        });
      }
    } catch (error) {
      final errorMessage = {
        'role': 'bot',
        'content': 'Error: $error',
      };

      setState(() {
        chatMessages.add(errorMessage);
      });
    }
  }

  Future<void> takePicture(BuildContext context) async {
    List<File>? res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WhatsappCamera(),
      ),
    );

    if (res != null && res.isNotEmpty) {
      File firstFile = res.first;

      final imageUrl = await uploadImage(firstFile);
      print("Image URL: $imageUrl");

      final imageMessage = {
        'role': 'user',
        'content': firstFile,
      };

      setState(() {
        chatMessages.add(imageMessage);
      });

      fetchDataFromAPI(message: "Tell me about musang king (durian) fruit");
    }
  }

  Future<void> processImage(String imageUrl) async {
    try {
      final http.Response response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        String base64Image = base64Encode(response.bodyBytes);

        while (base64Image.length % 4 != 0) {
          base64Image += '=';
        }

        final apiUrl =
            'https://detect.roboflow.com/durian-r6ykr/1?api_key=F1mQjaZRGePHUiH3RoqO';
        final headers = {'Content-Type': 'application/json'};
        final body = {'base64': base64Image};

        final apiResponse = await http.post(Uri.parse(apiUrl),
            headers: headers, body: jsonEncode(body));

        if (apiResponse.statusCode == 200) {
          final jsonResponse = json.decode(apiResponse.body);

          final predictions = jsonResponse['predictions'];
          if (predictions.isNotEmpty) {
            final firstPrediction = predictions[0];
            final predictedClass = firstPrediction['class'];
          } else {
            throw Exception('No predictions found.');
          }
        } else {
          throw Exception(
              'API request failed with status code ${apiResponse.statusCode}');
        }
      } else {
        throw Exception(
            'Failed to retrieve image from URL with status code ${response.statusCode}');
      }
    } catch (error) {
      _showAlert('Error: $error');
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Prediction Result'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<String> uploadImage(File imageFile) async {
    scrollToBottom();
    return imageFile.path;
  }
}

import 'package:ai_assistance/feature_box.dart';
import 'package:ai_assistance/openaiService.dart';
import 'package:ai_assistance/pallete.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  final speechToText = SpeechToText();
  final openAiService openAi = openAiService();
  final flutterTts = FlutterTts();
  String lastwords = '';
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;
  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastwords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  Future<void> systemSpeak(String str) async {
    await flutterTts.speak(str);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 24, 38),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 24, 38),
        title: BounceInDown(
            child: Text(
          "AI-OM",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 35),
        )),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: ZoomIn(
                child: Container(
                  height: 180,
                  width: 140,
                  child: Image.asset('assets/images/tl-removebg-preview.png'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: FadeInRight(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Pallete.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(25)
                        .copyWith(topLeft: Radius.zero),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      generatedContent == null
                          ? 'Good Morning!, What task can i do?'
                          : generatedContent!,
                      style: TextStyle(
                          fontFamily: 'Cera Pro',
                          color: Colors.white,
                          fontSize: generatedContent == null ? 25 : 18),
                    ),
                  ),
                ),
              ),
            ),
            if (generatedImageUrl != null)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: 375,
                  height: 375,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        generatedImageUrl!,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: SlideInLeft(
                child: Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    "Here are some features!",
                    style: TextStyle(
                      fontFamily: 'Cera Pro',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SlideInLeft(
                  delay: Duration(milliseconds: start),
                  child: FeatureBox(
                    color: Pallete.firstSuggestionBoxColor,
                    headerText: "Hello",
                    descriptionText: "hello this is gpt Omkar",
                  ),
                ),
                SlideInLeft(
                  delay: Duration(milliseconds: start + delay),
                  child: FeatureBox(
                    color: Pallete.secondSuggestionBoxColor,
                    headerText: "Dall-E",
                    descriptionText:
                        "Get inspired and create bobbling images using the AI assistance",
                  ),
                ),
                SlideInLeft(
                  delay: Duration(milliseconds: start + delay + delay),
                  child: FeatureBox(
                    color: Pallete.thirdSuggestionBoxColor,
                    headerText: "Smart Voice Assistantn ",
                    descriptionText: "hello this is gpt Omkar",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.firstSuggestionBoxColor,
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            final speech = await openAi.isArtPrompt(lastwords);
            if (speech.contains('https')) {
              generatedImageUrl = speech;
              generatedContent = null;
              setState(() {});
            } else {
              generatedImageUrl = null;
              generatedContent = speech;
              setState(() {});
              await systemSpeak(speech);
            }
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        child: Icon(
          speechToText.isListening ? (Icons.stop) : Icons.mic,
          color: Colors.black,
        ),
      ),
    );
  }
}

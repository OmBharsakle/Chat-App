import 'package:chat_app/Screens/LandingScreen/View/LandingPage2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  late bool isFinished;

  @override
  void initState() {
    isFinished = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/background.png',
                      ),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.2.h,
              width: double.infinity,
              decoration:  BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30)
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                     Text(
                      "Express your self with emoji experiences",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),

                    const SizedBox(height: 20),
                     Text(
                      "Chat using avatar emoji gives a different impression, dare to try it ?",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 35),
                    SwipeableButtonView(
                        isFinished: isFinished,
                        onFinish: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => const LandingPage2(),
                            ),
                          );
                        },
                        onWaitingProcess: () {
                          setState(() {
                            isFinished = true;
                          });
                        },
                        activeColor: Colors.blue,
                        buttonWidget: const Icon(
                          CupertinoIcons.chevron_right_2,
                          color: Colors.grey,
                        ),
                        buttonText: "Swipe to start"
                    )
                  ],
                ),
              ),
            )
          ]
      ),
    );
  }
}
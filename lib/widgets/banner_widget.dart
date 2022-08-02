// ignore_for_file: prefer_const_constructors

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .23,
        color: Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'JOBS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 45.0,
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            child: AnimatedTextKit(
                              repeatForever: true,
                              animatedTexts: [
                                FadeAnimatedText(
                                    'Reaching 1K+\n\tsatisfied users',
                                    duration: Duration(seconds: 4)),
                                FadeAnimatedText(
                                    'New way to\n\t\tGive and Get jobs',
                                    duration: Duration(seconds: 4)),
                                FadeAnimatedText(
                                    'Over 100+ Jobs\n\t\taround you',
                                    duration: Duration(seconds: 4)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Neumorphic(
                      style: NeumorphicStyle(
                        color: Colors.white,
                        oppositeShadowLightSource: true,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/udyog-app.appspot.com/o/banner%2Ficons.png?alt=media&token=288cf192-95c9-4308-95c7-8abb300b6226'),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: NeumorphicButton(
                      onPressed: () {},
                      style: NeumorphicStyle(color: Colors.white),
                      child: Text(
                        'Get Job',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: NeumorphicButton(
                      onPressed: () {},
                      style: NeumorphicStyle(color: Colors.white),
                      child: Text(
                        'Give Job',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

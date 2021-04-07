import 'package:flutter/material.dart';
import 'quizpage.dart';

class QuizWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Multiple Choice Rorschach Test',
      //     style: TextStyle(
      //       fontSize: 18.0,
      //     ),
      //   ),
      //   backgroundColor: Color(0xffffc629),
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      backgroundColor: Color(0xffffc629),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    'Multiple Choice Rorschach Test',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff524e4d),
                    ),
                  )),
              Expanded(
                flex: 10,
                child: Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)
                      ),),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25.0,horizontal: 15.0),
                      child: Text(
                        'The Rorschach Test is a projective psychological test developed in 1921 by Hermann Rorschach to measure thought disorder for the purpose of identifying mental illness. It was inspired by the observation that schizophrenia patients often interpret the things they see in unusual ways.''\n\nTest Instructions: \n'
                            'This test consists of ten images. For each image you will be given some time to memorize it and then on a following page you will have to pick from a list what the best descriptions of that image is. The original instructions call for each image to be projected on a screen for thirty seconds, this test lets you go as fast as you want, however it is recommended that you not go to fast.''\n\nThis test is provided for educational and entertainment use only. It should not be used as psychological advice of any kind and comes without any guarantee of accuracy or fitness for any particular purpose.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   flex: 5,
              //   child: Center(
              //     child: Card(
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Text(
              //           ,
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Expanded(
              //   flex: 3,
              //   child: Center(
              //     child: Card(
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Text(
              //           ,
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => QuizPage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xff21C38A),
                  ),
                  width: 150.0,
                  height: 40.0,
                  padding: EdgeInsets.all(5.0),
                  child: Center(
                    child: Text(
                      'Start',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

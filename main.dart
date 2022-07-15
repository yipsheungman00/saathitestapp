import 'dart:typed_data';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tab_container/tab_container.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'amplifyconfiguration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saathi Demo',
      theme: ThemeData(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> entries = <String>['A', 'B', 'C', 'D', 'E'];
  final List<int> colorCodes = <int>[600, 500, 100, 500, 400];

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    // Add the following line to add API plugin to your app.
    // Auth plugin needed for IAM authorization mode, which is default for REST API.
    final auth = AmplifyAuthCognito();
    final api = AmplifyAPI();
    await Amplify.addPlugins([api, auth]);

    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      //safePrint('Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
    }
  }

  Future<void> onTestApi() async {
    try {
      final options = RestOptions(
          path: '/creategoal',
          body: Uint8List.fromList('{\'GoalID\':\'2\', \'GoalName\':\'TestGoal2\'}'.codeUnits)
      );
      final restOperation = Amplify.API.get(
          restOptions: options
      );
      final response = await restOperation.response;
      //print('POST call succeeded');
      //print(String.fromCharCodes(response.data));
    } on ApiException catch (e) {
      //print('POST call failed: $e');
    }
  }

  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          body: Center(
              child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 100.w,
                        height: 10.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 8.h,
                              height: 8.h,
                              margin: EdgeInsets.only(right: 2.w),
                              child: CircularProfileAvatar(
                                '',
                                child: FlutterLogo(),
                                borderColor: Colors.purpleAccent,
                                borderWidth: 5,
                                elevation: 2,
                                radius: 50,
                              ),
                            )
                          ],
                        )
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 90.h,
                      child: TabContainer(
                        tabStart: 0.01,
                        tabEnd: 0.5,
                        tabCurve: Curves.easeInToLinear,
                        color: Colors.white,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 100.w,
                                  height: 10.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 75.w,
                                        height: 10.h,
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Savings Balance"),
                                            Text("24950.76")
                                          ],
                                        )
                                      ),
                                      SizedBox(
                                          width: 25.w,
                                          height: 10.h,
                                          child:Container(
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                              child: Text('+ Goal', style: TextStyle(fontSize: 15.sp),),
                                              onPressed: () {
                                                onTestApi();
                                              },
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      )
                                    ],
                                  )
                                ),
                                SizedBox(
                                    width: 100.w,
                                    height: 20.h,
                                    child: ListView(
                                      padding: const EdgeInsets.all(8),
                                      children: <Widget>[
                                        Container(
                                          height: 5.h,
                                          color: Colors.amber[600],
                                          child: const Center(child: Text('7500')),
                                        ),
                                        Container(
                                          height: 5.h,
                                          color: Colors.amber[500],
                                          child: const Center(child: Text('5000')),
                                        ),
                                        Container(
                                          height: 5.h,
                                          color: Colors.amber[100],
                                          child: const Center(child: Text('12450')),
                                        ),
                                      ],
                                    )
                                ),
                                SizedBox(
                                    width: 100.w,
                                    height: 50.h,
                                    child:ListView.builder(
                                        padding: const EdgeInsets.all(8),
                                        itemCount: entries.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Container(
                                            height: 50,
                                            color: Colors.amber[colorCodes[index]],
                                            child: Center(child: Text('Entry ${entries[index]}')),
                                          );
                                        }
                                    )
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Text('Earn'),
                          ),
                          Container(
                            child: Text('Learn'),
                          ),
                        ],
                        tabs: [
                          'Save',
                          'Earn',
                          'Learn',
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ),
        );
      },
    );
  }
}

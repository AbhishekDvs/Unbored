// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import '../Constants/UniversalParams.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class BoredPage extends StatefulWidget {
  const BoredPage({super.key, required this.title});

  final String title;

  @override
  State<BoredPage> createState() => BoredPageState();
}

class BoredPageState extends State<BoredPage> {
  bool hasData = false;

  Uri? _url;
  var activity;
  var type;
  var pricing;
  var link;
  var participants;
  var easeOfAccess;
  var memeData;

  bool isAdvSearch = false;
  String? dropDownVal;

  Future<void> GetSomeActivity() async {
    final response =
        await http.get(Uri.parse('${UniversalParams.universalURL}activity/'));
    const JsonDecoder decoder = JsonDecoder();
    final Map<String, dynamic> object = decoder.convert(response.body);
    print(object);
    setState(() {
      hasData = true;
      activity = object['activity'];
      participants = object['participants'];
      type = object['type'];
      pricing = object['price'];
      link = Uri.parse(object['link']);
    });
  }

  Future<void> GetMemeData() async {
    final response =
        await http.get(Uri.parse('https://api.imgflip.com/get_memes'));
    const JsonDecoder decoder = JsonDecoder();
    final Map<String, dynamic> object = decoder.convert(response.body);
    // print(object['data']['memes']);
    setState(() {
      memeData = object['data']['memes'];
    });
  }

  Future<void> GetSpecificActivity(String v) async {
    final response = await http
        .get(Uri.parse('${UniversalParams.universalURL}activity?type=$v'));
    const JsonDecoder decoder = JsonDecoder();
    final Map<String, dynamic> object = decoder.convert(response.body);
    print(object);
    setState(() {
      hasData = true;
      activity = object['activity'];
      participants = object['participants'];
      type = object['type'];
      pricing = object['price'];
      link = Uri.parse(object['link']);
    });
  }

  void initState() {
    super.initState();

    GetMemeData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Container(
                  alignment: Alignment.center, child: Text(widget.title)),
              bottom: TabBar(
                  indicatorColor: Colors.black45,
                  indicatorWeight: 4,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.local_activity_rounded,
                          color: Colors.black38, size: 24),
                      text: 'Hobbies',
                    ),
                    Tab(
                      icon: Icon(
                        Icons.image_rounded,
                        color: Colors.black38,
                        size: 24,
                      ),
                      text: 'Memes',
                    )
                  ]),
            ),
            body: TabBarView(children: [
              Container(
                  padding: EdgeInsets.all(
                      UniversalParams.screenWidth(context) * 0.05),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                print(memeData);
                                if (isAdvSearch == false)
                                  GetSomeActivity();
                                else if (isAdvSearch == true)
                                  GetSpecificActivity(dropDownVal!);
                              },
                              child: Text(hasData == false
                                  ? "Tap here, get an idea!"
                                  : "Get ANOTHER idea!")),
                          Spacer(),
                          IconButton(
                              onPressed: (() {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                            title: Text('Add filter'),
                                            content: SingleChildScrollView(
                                              child: ListBody(children: [
                                                Text('Select type of activity'),
                                                DropdownButton(
                                                    value: dropDownVal,
                                                    items: [
                                                      DropdownMenuItem(
                                                        child: Text(
                                                            'Recreational'),
                                                        value: 'recreational',
                                                      ),
                                                      DropdownMenuItem(
                                                        child:
                                                            Text('Education'),
                                                        value: 'education',
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('Social'),
                                                        value: 'social',
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('DIY'),
                                                        value: 'diy',
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('Charity'),
                                                        value: 'charity',
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('Cooking'),
                                                        value: 'cooking',
                                                      ),
                                                      DropdownMenuItem(
                                                        child:
                                                            Text('Relaxation'),
                                                        value: 'relaxation',
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('Music'),
                                                        value: 'music',
                                                      ),
                                                      DropdownMenuItem(
                                                        child:
                                                            Text('Busy Work'),
                                                        value: 'busywork',
                                                      ),
                                                    ],
                                                    onChanged: ((value) {
                                                      setState(() {
                                                        dropDownVal = value;
                                                      });
                                                    })),
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: (() {
                                                          print(dropDownVal);
                                                          setState(() {
                                                            isAdvSearch = true;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                        child: Text(
                                                            'Get the activity!')),
                                                    SizedBox(
                                                      width: UniversalParams
                                                              .screenWidth(
                                                                  context) *
                                                          0.02,
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: (() {
                                                          print(dropDownVal);
                                                          setState(() {
                                                            isAdvSearch = false;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                        child: Text('Reset!')),
                                                  ],
                                                )
                                              ]),
                                            )));
                              }),
                              icon: const Icon(Icons.settings))
                        ],
                      ),
                      if (hasData == true)
                        Column(
                          children: [
                            Container(
                              height:
                                  UniversalParams.screenHeight(context) * 0.5,
                              child: GridView.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                padding: EdgeInsets.all(8),
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    color: Colors.blue.shade100,
                                    child: Column(
                                      children: [
                                        Text(
                                          'What to do:',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                            padding: EdgeInsets.all(16),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Text(
                                                '${activity == null ? 'Not available' : activity}',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    color: Colors.amber.shade200,
                                    child: Column(
                                      children: [
                                        Text(
                                          'People needed:',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(16),
                                          child: Text(
                                            '${participants == null ? 'Not available' : participants}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    color: Colors.green.shade200,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Activity Type',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(16),
                                          child: Text(
                                            '${type == null ? 'Not available' : type}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    color: Colors.orange.shade200,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Pricing level(0-1):',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(16),
                                          child: Text(
                                            '${pricing == null ? 'Not available' : pricing}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'More At: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: UniversalParams.screenWidth(context) *
                                      0.5,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: TextButton(
                                      child: Text(
                                          '${link == '' ? 'Not available' : link}'),
                                      onPressed: () async {
                                        if (!await launchUrl(link)) {
                                          throw Exception(
                                              'Could not launch $link');
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      else
                        SizedBox.shrink()
                    ],
                  )),
              Container(
                  height: UniversalParams.screenHeight(context) * 0.5,
                  child: GridView.builder(
                      itemCount: memeData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 16),
                      itemBuilder: ((ctx, index) {
                        return Column(
                          children: [
                            Container(
                                height: UniversalParams.screenHeight(context) *
                                    0.22,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Image.network(
                                    memeData[index]['url'],
                                  ),
                                )),
                            Text(
                              memeData[index]['name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 8),
                            ),
                          ],
                        );
                      })))
            ])

            // This trailing comma makes auto-formatting nicer for build methods.
            ));
  }
}

import 'dart:async';
import 'package:alumniapp/alumnilist.dart';
import 'package:alumniapp/createEvent.dart';
import 'package:alumniapp/eventdetail.dart';
import 'package:alumniapp/notificationPage.dart';
import 'package:alumniapp/page.dart';
import 'package:alumniapp/profile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:alumniapp/logout.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';

class Homepage extends StatelessWidget {
  String accessToken;
  Homepage(this.accessToken);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home page',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(this.accessToken),
    );
  }
}

class HomePage extends StatefulWidget {
  String accessToken;
  HomePage(this.accessToken);
  @override
  _HomePageState createState() => _HomePageState(this.accessToken);
}

class _HomePageState extends State<HomePage> {
  TextEditingController searcheventController = TextEditingController();
  CarouselSlider carouselSlider;

  bool _isloading = true;

  Timer _debounce;
  int _current = 0;
  List imgList = [
    'images/christmas.jpg',
    'images/carnival.jpg',
    'images/aspire.jpg',
    'images/britan.jpg',
    'images/sports.jpg',
    'images/graduation.jpg',
    'images/lhosar.png',
    'images/holi.jpg',
    'images/teej.jpg'
  ];

  ScrollController _scrollController = new ScrollController();

  int page = 1;

  final String url = 'http://192.168.0.114:8000/api/events';
  final String urn = 'http://192.168.0.114:8000/api/search';
  final String uri = 'http://192.168.0.114:8000/api/events?page=';
  List userdata;
  bool _isLoading = false;

  List data;
  Map paging;
  String accessToken;
  _HomePageState(this.accessToken);

  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    print(response.body);

    setState(() {
      _isLoading = false;
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['data'];
    });
    return "Success";
  }

  Future getnext(int page) async {
    var response = await http.get(Uri.encodeFull(uri + page.toString()),
        headers: {"Accept": "application/json"});
    print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['data'];
      paging = convertDataToJson['links'];
      print(paging);
      
    });
    return "Success";
  }

  Future<String> searchData() async {
    var response = await http.get(Uri.encodeFull(urn), headers: {
      "Accept": "application/json",
      "search": searcheventController.text
    });
    print(response.body);

    var datas = jsonDecode(response.body);

    setState(() {
      data = datas;
    });
    return "Success";
  }

 

  

  @override
  void initState() {
    super.initState();
    this.getJsonData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page = page + 1;
        getnext(page);

      if (paging['next'] == null) {
        page = page -1;
        getnext(page);
      
        
          
                
              } 

      
              }
                
            });
          }
        
          @override
          void dispose() {
            _scrollController.dispose();
            super.dispose();
          }
        
          refresh() {
            if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent) {
              getnext(page);
            }
            getJsonData();
          }
        
          List<T> map<T>(List list, Function handler) {
            List<T> result = [];
            for (var i = 0; i < list.length; i++) {
              result.add(handler(i, list[i]));
            }
            return result;
          }
        
          @override
          Widget build(BuildContext context) {
            return Scaffold(
              resizeToAvoidBottomPadding: false,
              backgroundColor: Colors.blue[900],
              appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.blue[900],
                  title: Text('Events'),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(Icons.refresh),
                        iconSize: 25,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(accessToken),
                              ));
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationPage(),
                              ));
                        },
                        icon: Icon(Icons.notifications_active)),
                    SizedBox(
                      width: 20,
                    )
                  ]),
              drawer: Drawer(
                child: ListView(children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text("Hello!"),
                    accountEmail: Text('Welcome to the Application'),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/cover.jpg'),
                    )),
                  ),
                  ListTile(
                      title: Text('View Profile'),
                      leading: Icon(Icons.account_circle),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyProfile(accessToken),
                            ));
                      }),
                  ListTile(
                    title: Text('Search Alumni'),
                    leading: Icon(Icons.search),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlumniList(accessToken),
                          ));
                    },
                  ),
                  ListTile(
                    title: Text('Visit College'),
                    leading: Icon(Icons.school),
                    onTap: () {
                      launch('https://islington.edu.np/');
                    },
                  ),
                  ListTile(
                    title: Text('Report Us'),
                    leading: Icon(Icons.report),
                  ),
                  ListTile(
                    title: Text('Rate us'),
                    leading: Icon(Icons.rate_review),
                  ),
                  ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Logout(accessToken, context),
                          ));
                    },
                  ),
                ]),
              ),
              body: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Container(
                    margin:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0, top: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          offset: Offset(
                            1,
                            2,
                          ),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: <Widget>[
                        TextField(
                          onChanged: (String text) {
                            if (_debounce?.isActive ?? false) _debounce.cancel();
                            _debounce = Timer(const Duration(milliseconds: 1000), () {
                              searchData();
                            });
                          },
                          controller: searcheventController,
                          decoration: InputDecoration(
                            hintText: 'Search events....',
                            contentPadding: EdgeInsets.only(left: 50.0),
                            border: InputBorder.none,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 320),
                          child: IconButton(
                            icon: Icon(
                              Icons.search,
                              size: 25,
                            ),
                            color: Colors.black,
                            onPressed: () {
                              searchData();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
        
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: getJsonData,
                      child:  data == null ?
                             Center(
                              child: CircularProgressIndicator(),
                            )
                            
                          :ListView.builder(
                        controller: _scrollController,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {

                        // if (index == data.length-1) {
                        //   return Center(
                        //     child: CupertinoActivityIndicator(),
                        //   );
                          
                        // } 
                           
                          
                          return Container(
                            color: Colors.black,
                            child: new Center(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Card(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 2, right: 4),
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Eventdetail(
                                                  data[index]['event_name'],
                                                  data[index]['event_date'],
                                                  data[index]['event_time'],
                                                  data[index]['event_venue'],
                                                ),
                                              ));
                                        },
                                        leading: Icon(
                                          Icons.event_available,
                                          size: 50,
                                          color: Colors.blue[900],
                                        ),
                                        title: Text(
                                          data[index]['event_name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        subtitle: Row(
                                          children: <Widget>[
                                            Text(
                                              data[index]['event_venue'],
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 1),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              data[index]['event_time'],
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 1),
                                            ),
                                          ],
                                        ),
                                        trailing: Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.date_range,
                                              color: Colors.black,
                                            ),
                                            SizedBox(height: 5),
                                            Text(data[index]['event_date']),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                      
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 50),
                  //   child: Text(
                  //     'We welcome you !',
                  //     style: TextStyle(
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 20),
                  //   ),
                  // ),
        
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
        
                  //               child: Card(
        
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Row(
                  //           children: <Widget>[
                  //             SizedBox(width: 10),
                  //             Column(
                  //               children: <Widget>[
                  //                 SvgPicture.asset('images/award.svg', height: 35, width: 35,),
                  //                 SizedBox(height:10),
                  //                 Text('Award',style: TextStyle(color:Colors.red[900]),)
                  //               ],
                  //             ),
        
                  //             SizedBox(width: 35),
                  //             Column(
                  //               children: <Widget>[
                  //                 SvgPicture.asset('images/games.svg', height: 35, width: 35,),
                  //                 SizedBox(height:10),
                  //                 Text('Games',style: TextStyle(color:Colors.red[900]))
                  //               ],
                  //             ),
        
                  //             SizedBox(width: 35),
        
                  //            Column(
                  //              children: <Widget>[
                  //                SvgPicture.asset('images/giftsvg.svg', height: 35, width: 35,),
                  //                SizedBox(height:10),
                  //                Text('Gifts',style: TextStyle(color:Colors.red[900]))
                  //              ],
                  //            ),
        
                  //             SizedBox(width: 35),
                  //             Column(
                  //               children: <Widget>[
                  //                 SvgPicture.asset('images/music.svg', height: 35, width: 35,),
                  //                 SizedBox(height:10),
                  //                 Text('Music',style: TextStyle(color:Colors.red[900]))
                  //               ],
                  //             ),
        
                  //                 SizedBox(width:35),
        
                  //                                         Column(
                  //                     children: <Widget>[
                  //                       SvgPicture.asset('images/photo.svg', height: 35, width: 35,),
                  //                       SizedBox(height:10),
                  //                       Text('Photo',style: TextStyle(color:Colors.red[900]))
                  //                     ],
                  //                   ),
        
                  //           ],
                  //         ),
                  //       ),
                  //     ),
        
                  // ),
                  // SizedBox(height:5),
                  // Container(
                  //   width: 380,
                  //   color: Colors.black,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: <Widget>[
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //       carouselSlider = CarouselSlider(
                  //         height: 350.0,
                  //         initialPage: 0,
                  //         enlargeCenterPage: true,
                  //         autoPlay: true,
                  //         reverse: false,
                  //         enableInfiniteScroll: true,
                  //         autoPlayInterval: Duration(seconds: 2),
                  //         autoPlayAnimationDuration: Duration(milliseconds: 2000),
                  //         pauseAutoPlayOnTouch: Duration(seconds: 10),
                  //         scrollDirection: Axis.horizontal,
                  //         onPageChanged: (index) {
                  //           setState(() {
                  //             _current = index;
                  //           });
                  //         },
                  //         items: imgList.map((imgUrl) {
                  //           return Builder(
                  //             builder: (BuildContext context) {
                  //               return Container(
                  //                 width: MediaQuery.of(context).size.width,
                  //                 margin: EdgeInsets.symmetric(horizontal: 10.0),
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(20),
                  //                   color: Colors.green,
                  //                 ),
                  //                 child: Image.asset(
                  //                   imgUrl,
                  //                   fit: BoxFit.fill,
                  //                 ),
                  //               );
                  //             },
                  //           );
                  //         }).toList(),
                  //       ),
                  //       SizedBox(
                  //         height: 5,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: map<Widget>(imgList, (index, image) {
                  //           return Container(
                  //             width: 10.0,
                  //             height: 10.0,
                  //             margin:
                  //                 EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  //             decoration: BoxDecoration(
                  //               shape: BoxShape.circle,
                  //               color: _current == index ? Colors.blue : Colors.white,
                  //             ),
                  //           );
                  //         }),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            );
          }
            
        }
        
      

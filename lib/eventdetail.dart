import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class Eventdetail extends StatelessWidget {
  String name;
  String date;
  String time;
  String venue;

  Eventdetail(this.name,this.date,this.time, this.venue);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Eventdetails(this.name,this.date,this.time, this.venue),
      
      
      
    );
  }
}
class Eventdetails extends StatefulWidget {
  String name;
  String date;
  String time;
  String venue;
  Eventdetails(this.name,this.date,this.time, this.venue);
  @override
  EventDetail_State createState() => EventDetail_State(this.name,this.date,this.time, this.venue);
}

class EventDetail_State extends State<Eventdetails> {
  String name;
  String date;
  String time;
  String venue;
  EventDetail_State(this.name,this.date,this.time, this.venue);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('$name'),
      ),
      body: Column(
          children: <Widget>[
            SizedBox(height:10),
            Text('We Celebrate Together',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20,color: Colors.blue[900]),),
            SizedBox(height:10),
             Container(
               
               height: 400,
               child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    makeItem(image: 'images/christmas.jpg'),
                    makeItem(image: 'images/carnival.jpg'),
                    makeItem(image: 'images/aspire.jpg'),
                    makeItem(image: 'images/britan.jpg'),
                    makeItem(image: 'images/sports.jpg'),
                    makeItem(image: 'images/graduation.jpg'),
                    makeItem(image: 'images/lhosar.png'),
                    makeItem(image: 'images/holi.jpg'),
                    makeItem(image: 'images/teej.jpg'),
                  ],

                ),
             ),
             SizedBox(height:20),
             Text('Details of $name',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15,color: Colors.red[900]),),
             SizedBox(height:10),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   border: Border.all(),
                   color: Colors.blue[900]
                 ),
                 
                
                 child: Column(
                   children:<Widget>[
                     SizedBox(height:20),
                     Row(
                       children: <Widget>[
                         SizedBox(width:80),
                         Icon(Icons.date_range,color: Colors.white,),
                         SizedBox(width:10),
                         Text('Event Date:  $date',style: TextStyle(color:Colors.white),)
                       ],
                     ),
                     SizedBox(height:10),
                     Row(
                       children: <Widget>[
                         SizedBox(width:80),
                         Icon(Icons.timer,color: Colors.white,),
                         SizedBox(width:10),
                         Text('Event Time:  $time',style: TextStyle(color:Colors.white)),
                       ],
                     ),
                     SizedBox(height:10),
                     Row(
                       children: <Widget>[
                         SizedBox(width:80),
                         Icon(Icons.location_on,color: Colors.white,),
                         SizedBox(width:10),
                         Text('Event Venue:  $venue',style: TextStyle(color:Colors.white)),
                       ],
                     ),
                     SizedBox(height:30),
                     Row(
                       children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right:10, left: 20),
                           child: RaisedButton.icon(onPressed: (
                             
                           ){
                             _callPhone('tel:+97714412929');
                              
                           }, icon: Icon(Icons.call), label: Text('Learn more')),

                         ),
                         Container(
                          margin: EdgeInsets.only(left:80),
                           child: RaisedButton.icon(onPressed: (){
                              
                           }, icon: Icon(Icons.favorite), label: Text('Interested')),

                         ),
                       ],
                     ),
                     SizedBox(height:20)
                   ]
                 ),
               ),
               
             ),
             Text(''),
          ]
      ),
    );
    
  }
  
  Widget makeItem({image}){
  return AspectRatio(
    aspectRatio: 1.3 / 1.6,
    child: Container(
      margin: EdgeInsets.only(right: 6, left: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover)
      ),
    ),
    );

}
_callPhone(phone) async {
  if (await canLaunch(phone)) {
    await launch(phone);
  } else {
    throw 'Could not Call Phone';
  }
}

}
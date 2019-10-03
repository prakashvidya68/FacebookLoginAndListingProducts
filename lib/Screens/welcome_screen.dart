import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/Weclcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

List<String> imageUrl =  
        [
          'https://cdn.mos.cms.futurecdn.net/5PMe5hr8tjSS9Nq5d6Cebe-970-80.jpg',
          'https://media.gettyimages.com/photos/beautiful-woman-in-retro-style-picture-id158630429?s=2048x2048',
          'https://media.gettyimages.com/photos/black-and-white-pit-bull-dog-studio-portrait-picture-id699831836?s=2048x2048',
          'https://media.gettyimages.com/photos/extreme-underwater-picture-id675093786?s=2048x2048',
          'https://media.gettyimages.com/photos/black-white-tiger-picture-id954560222?s=2048x2048',
          'https://media.gettyimages.com/photos/manhattan-bridge-new-york-city-picture-id607913622?s=2048x2048'      
        ];
        int counter =6;
        IconData  varIcon = Icons.delete_outline;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    final userData =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
        
        double screenHeight = MediaQuery.of(context).size.height;
        double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: counter>=0?(){
        setState(() {
          varIcon = Icons.delete_outline;
          counter --;
          if(counter<=1)  varIcon =Icons.refresh;
        });
        
      }:(){
        setState(() {
          varIcon = Icons.delete_outline;
          if(counter>=1) varIcon = Icons.delete_outline;
        counter = 6;
        print(counter);
        });
      },child: Icon(varIcon,size: 35,),),
        key: scaffoldKey,
        body: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Theme.of(context).accentColor, Colors.white]),
              )),
              Container(
                height: screenHeight,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                            child: Text('Logout'),
                            color: Colors.transparent,
                            onPressed: () {
                              signOutProviders();
                              Toast.show("Logged Out", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                              Navigator.of(context).pop(null);
                            })
                      ],
                    ),
                    Center(
                      child: Card(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal:20, vertical: 20),
                          child: Column(
                            children: <Widget>[
                              new Container(
                                margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                                child: Text(
                                  userData['name'],
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Lets Stack up..',
                                style: TextStyle(
                                  fontFamily: 'DancingScript',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Container(
                                color: Colors.transparent,
                                height: screenHeight*0.68,
                                child: ListView.builder(
                                  itemCount: counter,
                                  itemBuilder: (context,index){
                                    print(counter);
                                    return Card(child: Image.network(imageUrl[index]));
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

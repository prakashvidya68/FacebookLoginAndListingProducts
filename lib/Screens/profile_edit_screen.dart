import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:toast/toast.dart';
import 'package:firebase_database/firebase_database.dart';
import '../Screens/welcome_screen.dart';

class ProfileEditScreen extends StatefulWidget {
  final FirebaseUser user;

  ProfileEditScreen({this.user});

  @override
  ProfileEditScreenState createState() => ProfileEditScreenState();
}

class ProfileEditScreenState extends State<ProfileEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  // String _name;
  // String _email;
  String gender;

  bool genderMale = false;
  bool genderFemale = false;
  bool genderOthers = false;

  Map<String,String> _bioData = {
  'uid': '',
  'name': '',
  'email': '',
  'gender':'',
  'bio':'',
  'dob':'',
  };
  final _bioController = TextEditingController();
  final _dobController = TextEditingController();

  void dispose() {
    _dobController.dispose();
    _bioController.dispose();
    super.dispose();
  }

   



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          FlatButton(
            child: Text("Logout"),
            textColor: Colors.white,
            onPressed: signOutProviders,
          )
        ],
      ),
      body: new SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                new Container(
                  height: 150,
                  color: Theme.of(context).accentColor.withOpacity(0.6),
                ),
                new Container(
                  margin: new EdgeInsets.all(15.0),
                  child: new Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: formUI(),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 80,
              left: (MediaQuery.of(context).size.width - 150) * 0.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Container(
                  height: 150,
                  width: 150,
                  child: Image.network(
                    widget.user.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Here is our Form UI
  Widget formUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 75),
      child: new Column(
        children: <Widget>[
          new TextFormField(
            initialValue: widget.user.displayName,
            decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                )),
            keyboardType: TextInputType.text,
            validator: validateName,
            onSaved: (String val) {
              _bioData['name'] = val;
            },
          ),
          SizedBox(
            height: 20,
          ),
          new TextFormField(
            initialValue: widget.user.email,
            decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                )),
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            onSaved: (String val) {
            _bioData['email'] = val;
          },
            
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('male'),
                  Checkbox(
                    value: genderMale,
                    onChanged: (newVal) {
                      setState(() {
                        genderMale = newVal;
                        genderFemale = false;
                        genderOthers = false;
                        gender = newVal ? 'male' : null;
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('female'),
                  Checkbox(
                    value: genderFemale,
                    onChanged: (newVal) {
                      setState(() {
                        genderMale = false;
                        genderFemale = newVal;
                        genderOthers = false;
                        gender = newVal ? 'female' : null;
                        // print(gender);
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('others'),
                  Checkbox(
                    value: genderOthers,
                    onChanged: (newVal) {
                      setState(() {
                        genderOthers = newVal;
                        genderFemale = false;
                        genderMale = false;
                        gender = newVal ? 'others' : null;
                        print(gender);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          new SizedBox(
            height: 10.0,
          ),
         Padding(
           padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 120),
           child: FormBuilderDateTimePicker(
                controller: _dobController,
                lastDate: DateTime.now(),
                inputType: InputType.date,
                initialValue: DateTime.now(),
                attribute: 'Date of Birth',
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  alignLabelWithHint: false,
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
         ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60, top: 30),
            child: TextFormField(
              controller: _bioController,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) => value.length < 20 ? 'Bio too short.' : null,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              maxLines: 2,
              autocorrect: true,
              decoration: InputDecoration(
                hintText: 'Tell us about you.',
                alignLabelWithHint: false,
                labelText: 'Bio',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new RaisedButton(
            onPressed: _finaliseSignUp,
            child: new Text('Next'),
            color: Theme.of(context).accentColor,
            textColor:Colors.white,
          )
        ],
      ),
    );
  }

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  void _finaliseSignUp() {
    if (_formKey.currentState.validate()&& gender!=null) {
//    If all data are correct then save data to out variables

    _bioData['gender'] = gender;
    _bioData['dob'] = _dobController.text;
    _bioData['bio']= _bioController.text;
    _bioData['uid'] = widget.user.uid.toString();
    print(_bioData);
      _formKey.currentState.save();
    createRecord();
    Navigator.of(context).pushNamed(WelcomeScreen.routeName,arguments: _bioData);
    } else {
      if(gender==null && _formKey.currentState.validate()){
       Toast.show("Please mark your gender", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
}
void createRecord(){
      final databaseReference = FirebaseDatabase.instance.reference();
  databaseReference.child(widget.user.uid).set(
    _bioData
  );
  }
}
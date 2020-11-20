import 'package:flutter/material.dart';
import 'package:kishor/screens/home_screen.dart';
import 'signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:kishor/models/authentication.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routename='/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> form_key=GlobalKey();

  Map<String,String> _authData={
    'email':'',
    'password':'',
  };
  void _showErrorDialog(String msg){
    showDialog(
      context:context,
      builder:(ctx)=>AlertDialog(
        title: Text('An Error Occured'),
        content: Text(msg),
        actions: [
          FlatButton(
            child: Text('Okay'),
            onPressed: ()
              {
                Navigator.of(ctx).pop();
              }
          )
        ],
      )
    );
  }
  Future<void> submit() async
  {
    if(!form_key.currentState.validate())
      {
        return;
      }
    form_key.currentState.save();

    try{
      await Provider.of<Authentication>(context,listen: false).LoginScreen(
          _authData['email'],
          _authData['password']);
      Navigator.of(context).pushReplacementNamed(HomeScreen.routename);
    }
    catch(error)
    {
      var errorMessage='Authentication Failed. Please try Again later' ;
      _showErrorDialog(errorMessage);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mokshya Login Screen'),
        actions: [
          FlatButton(
            child:Row(
              children: [
                Text("SignUp"),
                Icon(Icons.person_add),
              ],
            ),
            textColor: Colors.white,
            onPressed: ()
              {
                Navigator.of(context).pushReplacementNamed(SignUpScreen.routename);
              }
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
         children:<Widget>[
           Container(
             color: Colors.white,
           ),
           Center(
             child: Card(
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10.0),
               ),
               child: Container(
                 height: 260,
                 width: 300,
                 padding: EdgeInsets.all(16),
                 child: Form(
                   key:form_key,
                   child: SingleChildScrollView(
                     child: Column(
                       children: [
                         //email field
                         TextFormField(
                           decoration: InputDecoration(
                             labelText: 'Email'
                           ),
                           keyboardType: TextInputType.emailAddress,
                           validator: (value) {
                             if (value.isEmpty || !value.contains('@')) {
                               return 'invalid Email';
                             }
                             return null;
                           },
                           onSaved: (value)
                             {
                                _authData['email']=value;
                             }
                         ),
                         TextFormField(
                           decoration: InputDecoration(
                             labelText: 'Password',
                           ),
                           obscureText: true,
                           validator: (value)
                           {
                             if(value.isEmpty||value.length<=5)
                               {
                                 return 'invalid password';
                               }
                             return null;
                           },
                           onSaved: (value)
                           {
                             _authData['password']=value;
                           },
                         ),
                         SizedBox(
                           height: 30,
                         ),
                         RaisedButton(
                           child: Text('Submit'),
                           onPressed: ()
                           {
                            submit();
                           },
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10),
                           ),
                           color: Colors.deepPurple,
                           textColor: Colors.white,
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
             ),
           ),
         ],
        ),
      ),
    );
  }
}


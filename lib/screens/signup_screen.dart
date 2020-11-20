import 'package:flutter/material.dart';
import 'package:kishor/models/authentication.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routename='/signup';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> form_key=GlobalKey();
  TextEditingController password_controller=new TextEditingController();

  Map<String,String> _authdata={
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
    if(! form_key.currentState.validate())
      {
        return;
      }
    form_key.currentState.save();

    try{
      await Provider.of<Authentication>(context,listen: false).SignUp(
          _authdata['email'],
          _authdata['password']);
      Navigator.of(context).pushReplacementNamed(LoginScreen.routename);
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
        title: Text('Mokshya SignUp'),
        actions: [
          FlatButton(
              child:Row(
                children: [
                  Text("Login"),
                  Icon(Icons.person),
                ],
              ),
              textColor: Colors.white,
              onPressed: ()
              {
                Navigator.of(context).pushReplacementNamed(LoginScreen.routename);
              }
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 300,
                  width: 300,
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key:form_key,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //email
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            keyboardType:TextInputType.emailAddress,
                            validator: (value){
                              if(value.isEmpty||!value.contains('@'))
                                {
                                  return 'invalid email';
                                }
                              return null;
                            },
                            onSaved:(value)
                              {
                                _authdata['email']=value;
                              },
                          ),
                          //password
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            controller: password_controller,
                            validator:(value)
                              {
                                if(value.isEmpty||value.length<=5)
                                  {
                                    return 'invalid password';
                                  }
                                return null;
                              },
                            onSaved: (value)
                              {
                                _authdata['password']=value;
                              }
                          ),
                          //confirm password
                          TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                              ),
                              obscureText: true,
                              validator:(value)
                              {
                                if(value.isEmpty||value!=password_controller.text)
                                {
                                  return 'password does not match!!!';
                                }
                                return null;
                              },
                              onSaved: (value)
                              {

                              }
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RaisedButton(
                            child: Text('Submit'),
                            color: Colors.deepPurple,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: ()
                              {
                                submit();
                              },

                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

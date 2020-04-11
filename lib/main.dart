import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signin/bloc/login_bloc/bloc.dart';
import 'package:signin/bloc/login_bloc/login_event.dart';
import 'package:signin/screens/Home.dart';
import 'package:signin/screens/SignUp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(
        title: 'Flutter',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            Center(
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).accentColor),
              ),
            ),
            //TODO: VALIDATOR OF FORM
            TextFormField(
              validator: (value) {
                if (!value.contains('@')) {
                  return "not a valid email address";
                }
                return null;
              },
              controller: emailController,
              decoration: InputDecoration(
                  labelText: "Email", hintText: "Email  Email Address"),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Password", hintText: "Email  Password"),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            RaisedButton(
              onPressed: () {
                if (emailController.value.text.contains('@')) {
                  loginBloc.add(
                    Fetch(
                        email: emailController.text,
                        password: passwordController.text),
                  );
                } else {}
              },
              child: Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              color: Theme.of(context).accentColor,
            ),
            BlocListener(
              bloc: loginBloc,
              listener: (context, state) {
                if (state is LoadingLoginState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is LoadedLoginState) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home(
                                token: state.login.token,
                              )),
                      (Route<dynamic> route) => false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(token: state.login.token),
                    ),
                  );

//
                  return Text("Success " + state.login.token);
                }
                if (state is ErrorLoginState) {
                  return Text("Error" + state.error);
                } else {
                  return Container();
                }
              },
              child: BlocBuilder(
                bloc: loginBloc,
                builder: (context, state) {
                  if (state is LoadingLoginState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ErrorLoginState) {
                    return Text(state.error);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Dont have an account"),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

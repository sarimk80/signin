

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signin/bloc/register_bloc/bloc.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RegisterBloc registerBloc;

  @override
  void initState() {
    registerBloc = RegisterBloc();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    registerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            Center(
              child: Text(
                "Sign Up",
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
                if (emailController.text.contains('@')) {
                  registerBloc.add(
                    Register(
                        email: emailController.text,
                        password: passwordController.text),
                  );
                }
              },
              child: Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              color: Theme.of(context).accentColor,
            ),
            BlocBuilder(
                bloc: registerBloc,
                builder: (context, state) {
                  if (state is LoadingRegisterState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is LoadedRegisterState) {
                    return Text(state.response.token);
                  }
                  if (state is ErrorRegisterState) {
                    return Text(state.error);
                  } else {
                    return Container();
                  }
                }),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Already have an account"),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Sign In",
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

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components/CustomTextField.dart';
import 'package:shop_app/Model/LoginResponseModel.dart';
import 'package:shop_app/Screens/RegisterScreen.dart';
import 'package:shop_app/cubit/LogInCubit.dart';
import 'package:toast/toast.dart';

class LogInScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  static String id = "LogInScreen";
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInCubit, LoginStates>(
      listener: (context, state) {
        if (state is LogInError) {
          Toast.show(state.error, context, duration: Toast.LENGTH_LONG,backgroundColor: Colors.red);
        }
      },
      builder: (context, state) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Login",
                      style: TextStyle(
                          fontSize: 35, fontWeight: FontWeight.bold)),
                  Text(
                    "Login now to browse our hot offers",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  customTextFormField(
                    context: context,
                    hint: "Email",
                    controller: emailController,
                    prefixIcon: Icons.email,
                    isPassword: false,
                    // context, "Email", false, Icons.email, emailController
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  customTextFormField(
                    suffixPressed: () {
                      LogInCubit.get(context).visabilityChanged();
                    },
                    suffixIcon: LogInCubit.get(context).passIcon,
                    context: context,
                    hint: "Password",
                    controller: passwordController,
                    prefixIcon: Icons.lock_outline_rounded,
                    isPassword: LogInCubit.get(context).isVisible,
                    // context, "Password", true,
                    //   Icons.lock_outline_rounded, passwordController
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: ConditionalBuilder(
                      condition: !(state is LogInLoading),
                      fallback: (context) => CircularProgressIndicator(),
                      builder: (context) => FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          height: 45,
                          textColor: Colors.white,
                          minWidth: MediaQuery.of(context).size.width * 0.7,
                          onPressed: () {
                            if (emailController.text.isEmpty ||
                                !emailController.text.contains("@")) {
                              return toastMessage("Email", context);
                            } else if (passwordController.text.isEmpty ||
                                passwordController.text.length < 6) {
                              return toastMessage("Password", context);
                            }

                            LogInCubit.get(context).signIn(
                              context:context,
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                          },
                          color: Colors.blue,
                          child: Text(
                            "Log In",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont\'t have an account ?",
                        style: TextStyle(fontSize: 17),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RegistrationScreen.id);
                          },
                          child: Text("Register Now ",
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 17)))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

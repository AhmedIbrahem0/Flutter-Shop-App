import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components/CustomTextField.dart';
import 'package:shop_app/cubit/RegisterationCubit.dart';
import 'package:toast/toast.dart';

class RegistrationScreen extends StatelessWidget {
  static String id = "RegistrationScreen";
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmedPassController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>( 
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is RegisterError){
            print(state.error);
            Toast.show(state.error,context,duration: 2);}
        },
        builder:(context,state)=> Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: BackButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sign Up",
                        style:
                            TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Sign up now  ",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    customTextFormField(
                      context: context,
                      controller: userNameController,
                      hint: "UserName",
                      isPassword: false,
                      prefixIcon: Icons.account_circle_rounded,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    customTextFormField(
                      context: context,
                      controller: emailController,
                      hint: "Email",
                      isPassword: false,
                      prefixIcon: Icons.email,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    customTextFormField(
                      suffixIcon: RegisterCubit.get(context).visibilityIcon,
                      suffixPressed:RegisterCubit.get(context).changeRegisterVisibility ,
                      context: context,
                      controller: passwordController,
                      hint: "Password",
                      isPassword:  RegisterCubit.get(context).isVisable,
                      prefixIcon: Icons.lock,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    customTextFormField(
                       suffixIcon: RegisterCubit.get(context).visibilityIcon,
                      suffixPressed:RegisterCubit.get(context).changeRegisterVisibility ,
                     
                      context: context,
                      controller: confirmedPassController,
                      hint: "Confirm Password",
                      isPassword: RegisterCubit.get(context).isVisable,
                      prefixIcon: Icons.lock_outline_rounded,
                    ),
                    
                    SizedBox(
                      height: 30,
                    ),
                    customTextFormField(
                      context: context,
                      controller: phoneController,
                      hint: "Phone Number",
                       isPassword: false,
                      prefixIcon: Icons.phone,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: ConditionalBuilder(
                        condition:state is! RegisterLoading,
                        fallback: (context)=>CircularProgressIndicator(),
                         builder:(context)=>     
                         FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          height: 45,
                          textColor: Colors.white,
                          minWidth: MediaQuery.of(context).size.width * 0.7,
                          onPressed: () {
                            if (userNameController.text.isEmpty) {
                              return toastMessage("username", context);
                            } else if (emailController.text.isEmpty ||
                                !emailController.text.contains("@")) {
                              return toastMessage("Email", context);
                            } else if (passwordController.text.isEmpty ||
                                passwordController.text.length < 6) {
                              return toastMessage("Password", context);
                            } else if (passwordController.text !=
                                confirmedPassController.text) {
                              return toastMessage("PasswordConfirmed", context);
                            }
                            else if(phoneController.text.isEmpty||phoneController.text.length<10){
                              return toastMessage("phone", context);
                
                            }
                            else{
                              RegisterCubit.get(context).registerRequest(
                                userNameController.text,
                                emailController.text,
                                passwordController.text,
                                phoneController.text);
                            }
                          },
                          color: Colors.blue,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 20),
                          )),
                 
                         )
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components/CustomTextField.dart';
import 'package:shop_app/Helpers/CacheHelper.dart';
import 'package:shop_app/Screens/LogInScreen.dart';
import 'package:shop_app/cubit/MainShopCubit.dart';
import 'package:shop_app/cubit/ProfileCubit.dart';
import 'package:toast/toast.dart';

class SettingsScreen extends StatelessWidget {
  static String id = "SettingsScreen";
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileCubitStates>(
        listener: (context, state) {
          if(state is UpdateProfileDataError){
            Toast.show(state.error, context,duration:Toast.LENGTH_LONG);
          }
      if (state is ProfileCubitError) {
        print(state.error);
      }
    }, builder: (context, state) {
      return ConditionalBuilder(
          builder: (context) => Center(child: CircularProgressIndicator()),
          condition:
              (state is ProfileCubitLoading || state is BottomNavIndexChanged),
          fallback: (context) {
            usernameController = TextEditingController(
                text: ProfileCubit.get(context).profileData.userData.name);
            emailController = TextEditingController(
                text: ProfileCubit.get(context).profileData.userData.email);
            phoneController = TextEditingController(
                text: ProfileCubit.get(context).profileData.userData.phone);

            return Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 0,
                  actions: [
                    TextButton.icon(
                        onPressed: () {
                          CacheHelper.removeValue(key: "token").then((value) {
                            if (value == true) {
                              return Navigator.of(context)
                                  .pushReplacementNamed(LogInScreen.id);
                            }
                          });
                        },
                        icon: Icon(Icons.exit_to_app),
                        label: Text("LogOut", style: TextStyle(fontSize: 17)))
                  ],
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.20,
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: Image(
                                  image: NetworkImage(ProfileCubit.get(context)
                                      .profileData
                                      .userData
                                      .image)),
                              maxRadius:
                                  MediaQuery.of(context).size.height * 0.20,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Form(
                              key: _key,
                              child: Column(
                                children: [
                                  customTextFormField(
                                      context: context,
                                      hint: "UserName",
                                      isPassword: false,
                                      controller: usernameController,
                                      prefixIcon: null),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  customTextFormField(
                                      context: context,
                                      hint: "Email",
                                      isPassword: false,
                                      controller: emailController,
                                      prefixIcon: null),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  customTextFormField(
                                      suffixIcon:
                                          ProfileCubit.get(context).passIcon,
                                      suffixPressed: ProfileCubit.get(context)
                                          .visibilityChanged,
                                      context: context,
                                      hint: "Password",
                                      isPassword:
                                          ProfileCubit.get(context).isVisible,
                                      controller: passwordController,
                                      prefixIcon: null),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  customTextFormField(
                                      context: context,
                                      hint: "Phone Number",
                                      isPassword: false,
                                      controller: phoneController,
                                      prefixIcon: null),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  state is UpdateProfileDataLoading?
                                  Center(child: CircularProgressIndicator())
                                  :MaterialButton(
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    minWidth:
                                        MediaQuery.of(context).size.width *
                                            0.75,
                                    child: Text("Update"),
                                    onPressed: () {
                                      if (usernameController.text.isEmpty) {
                                        return Toast.show(
                                            "you must enter the username",
                                            context);
                                      } else if (emailController.text.isEmpty ||
                                          !emailController.text.contains("@")) {
                                        return Toast.show(
                                            "Email format is not correct",
                                            context);
                                      } else if (passwordController
                                              .text.length <
                                          7) {
                                        return Toast.show(
                                            "Password must be more than 6 chars",
                                            context);
                                      } else if (phoneController.text.length <
                                          10) {
                                        return Toast.show(
                                            "Phone number must be more than 9 chars",
                                            context);
                                      }
                                      ProfileCubit.get(context)
                                          .updateProfileData({
                                        "name": usernameController.text,
                                        "email":emailController.text,
                                        "phone": phoneController.text,
                                        "password": passwordController.text,
                                      }, context);
                                    },
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                ));
          });
    });
  }
}

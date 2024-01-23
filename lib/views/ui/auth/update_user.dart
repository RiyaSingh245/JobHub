import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:get/get.dart';
import 'package:job_hub/constants/app_constants.dart';
import 'package:job_hub/controllers/exports.dart';
import 'package:job_hub/views/common/app_style.dart';
import 'package:job_hub/views/common/custom_btn.dart';
import 'package:job_hub/views/common/custom_textfield.dart';
import 'package:job_hub/views/common/height_spacer.dart';
import 'package:job_hub/views/common/reusable_text.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {

  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController skill0 = TextEditingController();
  TextEditingController skill1 = TextEditingController();
  TextEditingController skill2 = TextEditingController();
  TextEditingController skill3 = TextEditingController();
  TextEditingController skill4 = TextEditingController();

  @override
  void dispose() {
    phone.dispose();
    location.dispose();
    skill0.dispose();
    skill1.dispose();
    skill2.dispose();
    skill3.dispose();
    skill4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginNotifier> (
        builder: (context, loginNotifier, child) {
          return Form(
            key: loginNotifier.profileFormKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: "Personal Details", 
                      style: appstyle(35, Color(kDark.value), FontWeight.bold),),
                      Consumer<ImageUploader>(
                        builder: (context, imageUploader, child) {
                          return imageUploader.imageUrl.isEmpty
                              ? GestureDetector(
                                onTap: () {
                                  imageUploader.pickImage();
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(kLightBlue.value),
                                  //backgroundImage: ,
                                  child: const Center(
                                    child: Icon(Icons.photo_filter_rounded),
                                  ),
                                ),
                              )
                              : GestureDetector(
                                onTap: () {
                                  imageUploader.imageUrl.clear();
                                  setState(() {});
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(kLightBlue.value),
                                  backgroundImage: FileImage(File(imageUploader.imageUrl[0])),
                                ),
                              );
                        },
                      ),
                  ],
                ),

                const HeightSpacer(size: 20),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: location, 
                        hintText: "Location", 
                        keyboardType: TextInputType.text,
                        validator: (location) {
                          if(location!.isEmpty) {
                            return "Please Enter a valid location";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const HeightSpacer(size: 10),
                      CustomTextField(
                        controller: phone, 
                        hintText: "Phone Number", 
                        keyboardType: TextInputType.phone,
                        validator: (phone) {
                          if(phone!.isEmpty) {
                            return "Please Enter a valid Phone Number";
                          } else {
                            return null;
                          }
                        },
                      ),

                      const HeightSpacer(size: 10),
                      ReusableText(
                        text: "Professional Skills", 
                        style: appstyle(30, Color(kDark.value), FontWeight.bold)),
                        const HeightSpacer(size: 10),
                        CustomTextField(
                        controller: skill0, 
                        hintText: "Professional Skills", 
                        keyboardType: TextInputType.text,
                        validator: (skill0) {
                          if(skill0!.isEmpty) {
                            return "Please Enter a valid Skill";
                          } else {
                            return null;
                          }
                        },
                      ),

                      const HeightSpacer(size: 10),
                        CustomTextField(
                        controller: skill1, 
                        hintText: "Professional Skills", 
                        keyboardType: TextInputType.text,
                        validator: (skill1) {
                          if(skill1!.isEmpty) {
                            return "Please Enter a valid Skill";
                          } else {
                            return null;
                          }
                        },
                      ),

                      const HeightSpacer(size: 10),
                        CustomTextField(
                        controller: skill2, 
                        hintText: "Professional Skills", 
                        keyboardType: TextInputType.text,
                        validator: (skill2) {
                          if(skill2!.isEmpty) {
                            return "Please Enter a valid Skill";
                          } else {
                            return null;
                          }
                        },
                      ),

                      const HeightSpacer(size: 10),
                        CustomTextField(
                        controller: skill3, 
                        hintText: "Professional Skills", 
                        keyboardType: TextInputType.text,
                        validator: (skill3) {
                          if(skill3!.isEmpty) {
                            return "Please Enter a valid Skill";
                          } else {
                            return null;
                          }
                        },
                      ),

                      const HeightSpacer(size: 10),
                        CustomTextField(
                        controller: skill4, 
                        hintText: "Professional Skills", 
                        keyboardType: TextInputType.text,
                        validator: (skill4) {
                          if(skill4!.isEmpty) {
                            return "Please Enter a valid Skill";
                          } else {
                            return null;
                          }
                        },
                      ),

                      const HeightSpacer(size: 20),

                      Consumer<ImageUploader> (
                        builder: (context, imageUpload, child) {
                          return CustomButton(
                            onTap: () {
                              /*if(imageUpload.imageUrl.isEmpty /*&& imageUpload._imageFile == null*/) {
                                Get.snackbar(
                                  "Image Missing", "Please Upload an image to proceed",
                                  colorText: Color(kLight.value),
                                  backgroundColor: Color(kLightBlue.value),
                                  icon: const Icon(Icons.add_alert)
                                );
                              } else {
                                //ProfileUpdateReq model = 
                              }*/
                            },
                            text: "Update Profile");
                        }, 
                      ) 
                    ],
                  ),
                )
              ],
            ));
        },
      ),
    );
  }
}
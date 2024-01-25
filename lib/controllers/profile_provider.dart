import 'package:flutter/material.dart';
import 'package:job_hub/models/response/auth/profile_model.dart';
import 'package:job_hub/services/helpers/auth_helper.dart';

class ProfileNotifier extends ChangeNotifier {
  Future<ProfileRes>? profile;
  getProfile() async {
    profile = AuthHelper.getProfile();
  }
}

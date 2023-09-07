import 'package:flutter/material.dart';

import 'helperwidgets/profile_form_widget.dart';

class UserProfileDetails extends StatelessWidget {
  const UserProfileDetails({super.key, this.phoneNo, this.avatarUrl});

  final String? phoneNo;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 14.0,
              right: 14.0,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: ProfileDetails(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

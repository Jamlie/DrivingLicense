import 'package:flutter/material.dart';
import "package:license/view_model/payment_vm.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:license/res/colors.dart';
import 'package:license/res/textstyles.dart';

class DocumentUpload extends StatelessWidget {
  const DocumentUpload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: <Widget>[
          HeaderText(),
          FileSelectionContainer(),
          OrDivider(),
          CameraButton(),
          ContinueButton(),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(83);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Registration',
        style: AppTextStyles.headline,
      ),
      centerTitle: true,
      toolbarHeight: preferredSize.height,
    );
  }
}

class HeaderText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 12.5),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 335,
          child: Text(
            'Regulations require you to upload documents that are required for school enrollment. Don\'t worry, your data will remain secure and private.',
            textAlign: TextAlign.center,
            style: AppTextStyles.title,
          ),
        ),
      ),
    );
  }
}

class FileSelectionContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 12.5),
      child: GestureDetector(
        child: Container(
          width: 304,
          height: 159,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primary,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(32),
            color: Color(0xFFFAFAFA),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 23.3,
                height: 23.3,
                child: Icon(
                  Icons.insert_drive_file,
                  color: AppColors.primary,
                ),
              ),
              Text(
                'Select file',
                style: AppTextStyles.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Divider(
              color: Color(0xFFEEEEEE),
              height: 36,
            ),
          ),
        ),
        Text(
          "or",
          style: GoogleFonts.roboto(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF616161),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Divider(
              color: Color(0xFFEEEEEE),
              height: 36,
            ),
          ),
        ),
      ],
    );
  }
}

class CameraButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 12.5),
      child: SizedBox(
        width: 340,
        height: 56,
        child: FilledButton.tonal(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(AppColors.secondaryLightBlue),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt,
                size: 16,
                color: AppColors.primary,
              ),
              SizedBox(width: 8),
              Text(
                'Open Camera & Take Photo',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                  letterSpacing: 0.01,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final paymentViewModel = PaymentViewModel(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12.5),
      child: SizedBox(
        width: 110,
        height: 40,
        child: FilledButton(
          onPressed: () {
            paymentViewModel.initiatePayment();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.primary),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continue',
                style: AppTextStyles.labelLarge,
                selectionColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';
import 'UploadFotoForm.dart';

class UploadFotoComponent extends StatefulWidget {
  const UploadFotoComponent({Key? key}) : super(key: key);

  @override
  _UploadFotoComponent createState() => _UploadFotoComponent();
}

class _UploadFotoComponent extends State<UploadFotoComponent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "Please upload your selfie to make a pickup request",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                const UploadFotoForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

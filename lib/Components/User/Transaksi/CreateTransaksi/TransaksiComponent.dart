import 'package:flutter/material.dart';
import '../../../../size_config.dart';
import '../../../../utils/constans.dart';
import 'TransaksiForm.dart';

class TransaksiComponent extends StatefulWidget {
  const TransaksiComponent({Key? key}) : super(key: key);

  @override
  _TransaksiComponent createState() => _TransaksiComponent();
}

class _TransaksiComponent extends State<TransaksiComponent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(10)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    )),
                const SizedBox(
                  height: 20,
                ),
                const TransaksiForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

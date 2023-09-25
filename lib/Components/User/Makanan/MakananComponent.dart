import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../Api/configAPI.dart';
import '../../../Screens/User/Transaksi/TransaksiScreen.dart';
import '../../../size_config.dart';
import '../../../utils/constans.dart';

class MakananComponent extends StatefulWidget {
  const MakananComponent({Key? key}) : super(key: key);

  @override
  State<MakananComponent> createState() => _MakananComponent();
}

class _MakananComponent extends State<MakananComponent> {
  Response? response;
  var dio = Dio();
  var dataMobil;
  String filterValue = '';
  late String searchKeyword;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    getDataMobil();
    searchKeyword = '';
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<dynamic> get filteredData {
    if (dataMobil == null) {
      return [];
    } else {
      if (filterValue.isEmpty && searchKeyword.isEmpty) {
        return dataMobil.where((data) => data['verifikasi'] == 1).toList();
      } else {
        return dataMobil.where((data) {
          final bool isVerified = data['verifikasi'] == 1;
          final bool matchesFilter =
              filterValue.isEmpty || data['tipe'] == filterValue;
          final bool matchesSearch = searchKeyword.isEmpty ||
              data['nama'].toLowerCase().contains(searchKeyword.toLowerCase());

          return isVerified && matchesFilter && matchesSearch;
        }).toList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter Widget
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    Text(
                      'Filter: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    DropdownButton<String>(
                      value: filterValue,
                      onChanged: (newValue) {
                        setState(() {
                          filterValue = newValue!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: '',
                          child: Text('All'),
                        ),
                        DropdownMenuItem(
                          value: 'Ready to Eat',
                          child: Text('Ready to Eat'),
                        ),
                        DropdownMenuItem(
                          value: 'Fruits and Vegetables',
                          child: Text('Fruits and Vegetables'),
                        ),
                        DropdownMenuItem(
                          value: 'Instant or Packaged',
                          child: Text('Instant or Packaged'),
                        ),
                        DropdownMenuItem(
                          value: 'Snack',
                          child: Text('Snack'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Search Bar
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchKeyword = value;
                    });
                  },
                  decoration: InputDecoration(
                    // labelText: 'Search',
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: filteredData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return cardMakan(filteredData[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardMakan(data) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, TransaksiScreen.routeName,
            arguments: data);
      },
      child: Card(
        elevation: 15.0,
        margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // mengatur bayangan kartu
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 3.0, color: Colors.white24),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    '$baseUrl/${data['gambar']}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${data['nama']}",
                      style: TextStyle(
                        color: mTitleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "${data['tipe']}",
                      style: TextStyle(
                        color: mTitleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      "Receiver name :",
                      style: TextStyle(
                        color: mTitleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      "${data['uradmin']}",
                      style: TextStyle(
                        color: mTitleColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      "${data['porsi']}",
                      style: TextStyle(
                        color: mTitleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: mTitleColor,
                size: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getDataMobil() async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio.get(getAllMobil);

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        setState(() {
          dataMobil = response!.data['data'];
          print(dataMobil);
        });
      } else {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            title: 'Disclaimer',
            desc: '$msg',
            btnOkOnPress: () {
              utilsApps.hideDialog(context);
            }).show();
      }
    } catch (e) {
      print(e);
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Disclaimer',
          desc: 'An Error Occurred On The Server',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }
}

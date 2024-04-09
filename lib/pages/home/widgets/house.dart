import 'dart:math';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/models/house.dart';

final List<String> imagePaths = [
  'assets/images/gryffindor.png',
  'assets/images/hufflepuff.png',
  'assets/images/ravenclaw.png',
  'assets/images/slytherin.png',
  // เพิ่มรูปภาพตามความเหมาะสม
];

class HouseDetailDialog extends StatelessWidget {
  final HogwartsHouse house;

  const HouseDetailDialog({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color.fromARGB(255, 231, 189, 1),
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                house.unix ?? '',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Founder : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${house.symbol ?? ''}',
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Colors : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${house.open ?? ''}',
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Animal : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${house.high ?? ''}',
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween, // จัดปุ่มไปทางสองด้าน
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Color.fromARGB(255, 251, 250, 250),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 1, 1, 1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HouseTable extends StatefulWidget {
  const HouseTable({Key? key}) : super(key: key);

  @override
  State<HouseTable> createState() => _HouseTableState();
}

class _HouseTableState extends State<HouseTable> {
  List<HogwartsHouse> _houses = [];
  List<HogwartsHouse> _filteredhouses = [];

  @override
  void initState() {
    super.initState();
    _fetchHogwartsHouses();
  }

  Future<void> _fetchHogwartsHouses() async {
    try {
      var dio = Dio(BaseOptions(responseType: ResponseType.plain));
      var response = await dio.get(
          'https://script.googleusercontent.com/macros/echo?user_content_key=bM4iM0-SjLvT-zh95ji857HM64lwmTCr9DIb7sgYKNZnurvFL7W3PHD8NWSK_QYCGyGg4DEB-Vq-O56UVCHjtPx_SsQ-X9JTm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnKy84ldcVdMVLWSYkaL3N44C3QkhrrGaH9YiP7C2OtUOuQTJcVmkrPvyS3Va3VtODOdKcAsWrxUFrxjzGql_m1Epc98Fm9ReKNz9Jw9Md8uu&lib=MTGcpytpf0fhNWO9NlGwPl_K_1uMpn6gq');

      if (response.statusCode == 200) {
        var list = jsonDecode(response.data.toString()) as List<dynamic>;
        setState(() {
          _houses = list.map((item) => HogwartsHouse.fromJson(item)).toList();
          // Initialize _filteredPresidents with _presidents initially
          _filteredhouses = _houses;
        });
      } else {
        throw Exception('Failed to load presidents');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load presidents. Please try again later.'),
        ),
      );
    }
  }

  void _filterHouses(String text) {
    setState(() {
      // Filter _presidents list based on search text
      _filteredhouses = _houses
          .where((Book) =>
              Book.date.toLowerCase().contains(text.toLowerCase()) ||
              Book.unix.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              'Hogwarts Houses',
              style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: _filterHouses,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.search, color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: _filteredhouses.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _filteredhouses.length,
                  itemBuilder: (context, index) {
                    var house = _filteredhouses[index];
                    return ListTile(
                      title: Text(
                        house.unix ?? '',
                        style: TextStyle(
                          color: Color.fromARGB(255, 223, 201, 0),
                        ),
                      ),
                      subtitle: Text(
                        house.unix != null ? 'Symbol : ${house.date}' : '',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 254),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => HouseDetailDialog(house: house),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/models/character.dart';

class CharacterDetailDialog extends StatelessWidget {
  final HarryPotterCharacter character;

  const CharacterDetailDialog({Key? key, required this.character})
      : super(key: key);

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
                character.name ?? '',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Nickname : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${character.nickname ?? ''}',
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
                    text: 'House : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${character.house ?? ''}',
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
                    text: 'PortrayedBy : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${character.portrayedBy ?? ''}',
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
                    text: 'Children : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${character.relatives ?? ''}',
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
                    text: 'Birthdate : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${character.birthdate ?? ''}',
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Container(
                height: 500,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 1, 1, 1), // สีขอบ
                    width: 10, // ความหนาของขอบ
                  ),
                ),
                child: Image.network(
                  character.imageUrl ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Icon(
                      Icons.error,
                      color: Color.fromARGB(255, 253, 62, 3),
                    );
                  },
                ),
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

class AppCharacters extends StatefulWidget {
  const AppCharacters({Key? key}) : super(key: key);

  @override
  State<AppCharacters> createState() => _CharactersTableState();
}

class _CharactersTableState extends State<AppCharacters> {
  List<HarryPotterCharacter> _chars = [];
  List<HarryPotterCharacter> _filteredchars = [];

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
  }

  Future<void> _fetchCharacters() async {
    try {
      var dio = Dio(BaseOptions(responseType: ResponseType.plain));
      var response = await dio.get(
          'https://script.googleusercontent.com/macros/echo?user_content_key=5ykgW6EjnMOGQ6-6k3IKxAaqaEag3gh_2b-RDT_n9cXFXpASuznRgugxiqNIHFyE3e3xDsyJelAohDgmU1pCKQNz5V3HcsA1m5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnG-7vcViHCDfVszvyI7RyvP8i4yvmQhrzsiKg7bcn_BdkIVR6BbkbToJ_vya36VrLsV0_gxrcbzsC5h7p0ERI4XGmztKOAlBAQ&lib=MsKVpJdwFY4cJH6dBHY0ub5KFZfGZVUM9');

      if (response.statusCode == 200) {
        var list = jsonDecode(response.data.toString()) as List<dynamic>;
        setState(() {
          _chars =
              list.map((item) => HarryPotterCharacter.fromJson(item)).toList();
          // Initialize _filteredPresidents with _presidents initially
          _filteredchars = _chars;
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

  void _filterChars(String text) {
    setState(() {
      // Filter _presidents list based on search text
      _filteredchars = _chars
          .where((HarryPotterCharacter) =>
              HarryPotterCharacter.name
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              HarryPotterCharacter.house
                  .toLowerCase()
                  .contains(text.toLowerCase()))
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
              'Harry Potter Characters',
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
            onChanged: _filterChars,
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
          child: _filteredchars.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _filteredchars.length,
                  itemBuilder: (context, index) {
                    var charac = _filteredchars[index];
                    var imageURL = charac.imageUrl ?? '';
                    return ListTile(
                      title: Text(
                        charac.name ?? '',
                        style: TextStyle(
                          color: Color.fromARGB(255, 223, 201, 0),
                        ),
                      ),
                      subtitle: Text(
                        charac.house != null ? 'House : ${charac.house}' : '',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 254),
                        ),
                      ),
                      trailing: imageURL.isNotEmpty
                          ? SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.network(
                                imageURL,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Icon(Icons.error,
                                      color: Color.fromARGB(255, 245, 0, 0));
                                },
                              ),
                            )
                          : SizedBox.shrink(),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              CharacterDetailDialog(character: charac),
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

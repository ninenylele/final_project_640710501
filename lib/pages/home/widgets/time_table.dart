import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/models/book.dart';

class BookDetailDialog extends StatelessWidget {
  final Book book;

  const BookDetailDialog({Key? key, required this.book}) : super(key: key);

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
                book.date ?? '',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Number : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${book.unix ?? ''}',
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
                    text: 'OriginalTitle : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${book.symbol ?? ''}',
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
                    text: 'ReleaseDate : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${book.open ?? ''}',
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
                    text: 'Description : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${book.high ?? ''}',
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
                  book.close ?? '',
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
                ElevatedButton(
                  onPressed: () {
                    // รหัสที่ต้องการให้ปุ่มทำงาน
                  },
                  child: Text(
                    'Buy',
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

class TimeTable extends StatefulWidget {
  const TimeTable({Key? key}) : super(key: key);

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  List<Book> _books = [];
  List<Book> _filteredbooks = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    try {
      var dio = Dio(BaseOptions(responseType: ResponseType.plain));
      var response = await dio.get(
          'https://script.google.com/macros/s/AKfycbx__zhOPaFLpFuPpINdRbTEgpEHnmKPSwIgkgVrTIeW21eEotHg7wT4lyvw2VUkNIZd6Q/exec');

      if (response.statusCode == 200) {
        var list = jsonDecode(response.data.toString()) as List<dynamic>;
        setState(() {
          _books = list.map((item) => Book.fromJson(item)).toList();
          // Initialize _filteredPresidents with _presidents initially
          _filteredbooks = _books;
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

  void _filterBooks(String text) {
    setState(() {
      // Filter _presidents list based on search text
      _filteredbooks = _books
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
              'Harry Potter book store',
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
            onChanged: _filterBooks,
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
          child: _filteredbooks.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _filteredbooks.length,
                  itemBuilder: (context, index) {
                    var book = _filteredbooks[index];
                    var imageURL = book.close ?? '';
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            book.date ?? '',
                            style: TextStyle(
                              color: Color.fromARGB(255, 223, 201, 0),
                            ),
                          ),
                          imageURL.isNotEmpty
                              ? SizedBox(
                                  height: 300,
                                  width: 180,
                                  child: Image.network(
                                    imageURL,
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Icon(Icons.error,
                                          color:
                                              Color.fromARGB(255, 245, 0, 0));
                                    },
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                      subtitle: Text(
                        book.unix != null ? 'Number : ${book.unix}' : '',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 254),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => BookDetailDialog(book: book),
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

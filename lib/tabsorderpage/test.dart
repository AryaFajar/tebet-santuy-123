import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  TextEditingController textController = TextEditingController();
  String? selectedItem; // Variable to hold the selected item.

  List<Map<String, String>> itemList = [
    {
      "title": "Arya Fajar Pratama",
      "subtitle": "KELAS A",
      "imageUrl": "https://picsum.photos/seed/picsum/200/300",
    },
    {
      "title": "Azhar Syarif",
      "subtitle": "KELAS B",
      "imageUrl": "https://picsum.photos/seed/picsum/200/300",
    },
    {
      "title": "Yossy Febrianti",
      "subtitle": "KELAS C",
      "imageUrl": "https://picsum.photos/seed/picsum/200/300",
    },
    // Add more items to your list.
  ];

  List<String> searchSuggestions = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search Bar Example'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 58.0, right: 10, left: 10),
              child: AnimSearchBar(
                width: 400,
                textController: textController,
                onSuffixTap: () {
                  setState(() {
                    textController.clear();
                    searchSuggestions
                        .clear(); // Menghapus saran saat menghapus teks
                  });
                },
                onSubmitted: (query) {
                  setState(() {
                    selectedItem = query;
                    searchSuggestions
                        .clear(); // Menghapus saran saat item terpilih
                  });
                },
              ),
            ),
            _buildSelectedOrSuggestionItem(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      updateSearchSuggestions(textController.text);
    });
  }

  void updateSearchSuggestions(String query) {
    setState(() {
      searchSuggestions = itemList
          .where((item) =>
              item['title']!.toLowerCase().contains(query.toLowerCase()))
          .map((item) => item['title']!)
          .toList();
    });
  }

  Widget _buildSelectedOrSuggestionItem() {
    return Column(
      children: [
        if (searchSuggestions.isNotEmpty)
          Container(
            color: Colors.white, // Atur warna latar belakang
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: searchSuggestions.map((suggestion) {
                return ListTile(
                  title: Text(
                    suggestion,
                    style: TextStyle(
                      backgroundColor:
                          Colors.white, // Atur warna latar belakang teks
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      textController.text = suggestion;
                      selectedItem = suggestion;
                      searchSuggestions
                          .clear(); // Menghapus saran saat item terpilih
                    });
                  },
                );
              }).toList(),
            ),
          ),
        if (selectedItem != null) _buildListItem(selectedItem!),
      ],
    );
  }

  Widget _buildListItem(String selectedItem) {
    final item = itemList.firstWhere(
      (element) => element['title'] == selectedItem,
      orElse: () => {
        "title": "Item not found",
        "subtitle": "Item not found",
        "imageUrl":
            "", // Anda dapat menyediakan URL gambar default atau biarkan kosong.
      },
    );

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(item['imageUrl']!),
      ),
      title: Text(
        item['title']!,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        item['subtitle']!,
      ),
      trailing: Icon(Icons.add),
    );
  }
}

void main() {
  runApp(App());
}

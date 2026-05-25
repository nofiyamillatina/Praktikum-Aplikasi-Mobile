import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'item_model.dart';
import 'splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi List Item',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: SplashPage(),
    );
  }
}

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  List<ItemModel> _items = [];
  List<ItemModel> _filteredItems = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  //Data dummy awal
  final List<ItemModel> _dummyItems = [
    ItemModel(
      id: 1,
      name: 'LightStick',
      description: 'LightStick NCT Dream',
      image: 'images/Lightstick Dream.jpg',
    ),
    ItemModel(
      id: 2,
      name: 'Lightstick',
      description: 'Lightstick NCT 127',
      image: 'images/Lightstick 127.jpg',
    ),
    ItemModel(
      id: 3,
      name: 'Lightstick',
      description: 'Lightstick NCT Wish',
      image: 'images/Lightstick Wish.jpg',
    ),
    ItemModel(
      id: 4,
      name: 'Lightstick',
      description: 'Lightstick NCT WayV',
      image: 'images/Lightstick WayV.jpg',
    ),
    ItemModel(
      id: 5,
      name: 'Album',
      description: 'Album Dream Escape NCT Dream',
      image: 'images/Album Dream.jpg',
    ),
    ItemModel(
      id: 6,
      name: 'Album',
      description: 'Album NCT Dream Beat It Up',
      image: 'images/Album Dream2.jpg',
    ),
    ItemModel(
      id: 7,
      name: 'Poster',
      description: 'Poster Member NCT Dream',
      image: 'images/Poster Dream.jpg',
    ),
    ItemModel(
      id: 8,
      name: 'Poster',
      description: 'Poster Jaemin Beat It Up Version',
      image: 'images/Poster Jaemin.jpg',
    ),
    ItemModel(
      id: 9,
      name: 'Photocard',
      description: 'Photocard NCT Dream',
      image: 'images/PC Dream.jpg',
    ),
    ItemModel(
      id: 10,
      name: 'Photocard',
      description: 'Photocard Jaemin NCT',
      image: 'images/PC Jaemin.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Load data dari SharedPreferences
  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? itemsString = prefs.getString('items_list');

    if (itemsString != null) {
      List<dynamic> itemsJson = json.decode(itemsString);
      setState(() {
        _items = itemsJson.map((item) => ItemModel.fromMap(item)).toList();
        _filteredItems = List.from(_items);
      });
    } else {
      // Jika belum ada data, gunakan data dummy
      setState(() {
        _items = List.from(_dummyItems);
        _filteredItems = List.from(_items);
      });
      await _saveData(); // Simpan data dummy ke SharedPreferences
    }
  }

  // Simpan data ke SharedPreferences
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> itemsMap = _items
        .map((item) => item.toMap())
        .toList();
    String itemsString = json.encode(itemsMap);
    await prefs.setString('items_list', itemsString);
  }

  // Cari item
  void _searchItem(String keyword) {
    List<ItemModel> results = [];

    if (keyword.isEmpty) {
      results = List.from(_items);
    } else {
      results = _items.where((item) {
        return item.name.toLowerCase().contains(keyword.toLowerCase()) ||
            item.description.toLowerCase().contains(keyword.toLowerCase());
      }).toList();
    }
    setState(() {
      _filteredItems = results;
    });
  }

  // Tambah item baru
  Future<void> _addItem() async {
    if (_nameController.text.isEmpty || _descController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nama dan deskripsi tidak boleh kosong!')),
      );
      return;
    }
    int newId = _items.isNotEmpty ? _items.last.id + 1 : 1;
    ItemModel newItem = ItemModel(
      id: newId,
      name: _nameController.text,
      description: _descController.text,
      image: 'images/Default NCT.jpg', // Gambar default jika tidak diisi
    );
    setState(() {
      _items.add(newItem);
      _filteredItems.add(newItem);
    });
    await _saveData();
    _nameController.clear();
    _descController.clear();

    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Item berhasil ditambahkan!')));
  }

  // Update item
  Future<void> _editItem(ItemModel item) async {
    _nameController.text = item.name;
    _descController.text = item.description;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama Item'),
              ),
              TextField(
                controller: _descController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  item.name = _nameController.text;
                  item.description = _descController.text;
                  _filteredItems = _items;
                });

                await _saveData();

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Item berhasil diupdate!')),
                );
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  // Hapus Item Berdasarkan ID
  Future<void> _deleteItem(int id) async {
    setState(() {
      _items.removeWhere((item) => item.id == id);
      _filteredItems.removeWhere((item) => item.id == id);
    });
    await _saveData();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Item berhasil dihapus!')));
  }

  // Tampilkan dialog untuk menambah item baru
  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama Item'),
              ),
              TextField(
                controller: _descController,
                decoration: InputDecoration(labelText: 'Deskripsi Item'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            ElevatedButton(onPressed: _addItem, child: Text('Simpan')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5FFF6),
      appBar: AppBar(
        backgroundColor: Color(0xffF5FFF6),
        elevation: 0,
        centerTitle: true,

        title: Text(
          'NCT Merchandise List 💚',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _searchItem(value);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffFFFFFF),
                hintText: 'Cari item...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // LIST ITEM
          Expanded(
            child: _filteredItems.isEmpty
                ? Center(child: Text('Item tidak ditemukan'))
                : ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];

                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffEFE7FF), Color(0xffD7FFD9)],
                          ),
                          borderRadius: BorderRadius.circular(20),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],

                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              item.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            item.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          subtitle: Text(item.description),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // EDIT
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.orange),
                                onPressed: () {
                                  _editItem(item);
                                },
                              ),

                              // DELETE
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _deleteItem(item.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffB8F5B1),
        elevation: 10,
        onPressed: _showAddDialog,
        child: Icon(Icons.add, color: Colors.black, size: 30),
        tooltip: 'Tambah Item',
      ),
    );
  }
}

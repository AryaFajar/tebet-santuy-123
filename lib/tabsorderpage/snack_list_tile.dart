import 'package:flutter/material.dart';

class Snack {
  final int id;
  final String namaSnack;
  final String gambar;
  final String deskripsi;
  final int harga;
  bool isSelected; // Define the isSelected property

  Snack({
    required this.id,
    required this.namaSnack,
    required this.gambar,
    required this.deskripsi,
    required this.harga,
    this.isSelected = false, // Initialize isSelected to false
  });
  factory Snack.fromJson(Map<String, dynamic> json) {
    return Snack(
      id: json['id'],
      namaSnack: json['namaSnack'],
      gambar: json['gambar'],
      deskripsi: json['deskripsi'],
      harga: json['harga'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'namaSnack': namaSnack,
      'gambar': gambar,
      'deskripsi': deskripsi,
      'harga': harga,
    };
  }
}

class SnackListTile extends StatefulWidget {
  final String name;
  final String image;
  final String description;
  final int harga;
  final Function(int) onSnackAdded;
  final Function(int) onSnackRemoved;
  final Function(Snack, bool) onSnackSelected;
  final Snack snack; // Tambahkan variabel ini

  // Callback untuk pemilihan snack
  // Callback untuk menambah harga snack

  SnackListTile({
    required this.name,
    required this.image,
    required this.description,
    required this.harga,
    required this.onSnackAdded,
    required this.onSnackRemoved,
    required this.onSnackSelected,
    required this.snack, // Tambahkan di sini
  });

  @override
  State<SnackListTile> createState() => _SnackListTileState();
}

class _SnackListTileState extends State<SnackListTile> {
  bool isAdded = false; // Variabel status snack
  bool isDisabled = false; // Variabel status snack yang sudah dipilih

  @override
  void initState() {
    super.initState();
    // Periksa apakah snack sudah dipilih saat inisialisasi widget
    if (widget.snack.isSelected) {
      isAdded = true;
      isDisabled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            // Tinggi gambar
            child: Image.network(
              widget.image,
              fit: BoxFit.cover, // Atur penyesuaian gambar sesuai kebutuhan
            ),
          ),
          title: Text(
            widget.name,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            '\P${widget.harga.toString()}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isAdded &&
                  !isDisabled) // Hanya tampilkan tombol tambah jika snack belum ditambahkan dan belum dipilih
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      isAdded = true; // Tandai snack sebagai ditambahkan
                      isDisabled =
                          true; // Tandai snack sebagai tidak bisa ditambahkan lagi // Tandai snack sebagai ditambahkan
                      widget.onSnackSelected(widget.snack, true);
                    });
                    widget.onSnackAdded(widget.harga);
                  },
                ),
              if (isAdded) // Tampilkan tombol hapus jika snack sudah ditambahkan
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      isAdded = false; // Tandai snack sebagai tidak ditambahkan
                      isDisabled =
                          false; // Tandai snack sebagai bisa ditambahkan lagi
                      widget.onSnackSelected(widget.snack, false);
                    });
                    widget.onSnackRemoved(widget.harga);
                  },
                ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
        ),
      ],
    );
  }
}

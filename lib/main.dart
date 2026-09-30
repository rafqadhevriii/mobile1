import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biodata Mahasiswa',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E306E),
        ),
      ),
      home: const BiodataPage(),
    );
  }
}

class BiodataPage extends StatefulWidget {
  const BiodataPage({super.key});

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController npmController = TextEditingController();
  final TextEditingController jurusanController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  XFile? fotoProfile;

  String nama = '';
  String npm = '';
  String jurusan = '';

  Future<void> pilihFoto() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        fotoProfile = image;
      });
    }
  }

  void simpanData() {
    if (namaController.text.trim().isEmpty ||
        npmController.text.trim().isEmpty ||
        jurusanController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan lengkapi semua data terlebih dahulu.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      nama = namaController.text.trim();
      npm = npmController.text.trim();
      jurusan = jurusanController.text.trim();
    });

    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data berhasil disimpan ✓'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget tampilkanFoto({
    double ukuran = 120,
  }) {
    if (fotoProfile == null) {
      return CircleAvatar(
        radius: ukuran / 2,
        backgroundColor: const Color(0xFFE5EAF7),
        child: Icon(
          Icons.person,
          size: ukuran * 0.52,
          color: const Color(0xFF1E306E),
        ),
      );
    }

    return ClipOval(
      child: Image.network(
        fotoProfile!.path,
        width: ukuran,
        height: ukuran,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    npmController.dispose();
    jurusanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // =========================
              // HEADER
              // =========================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  25,
                  30,
                  25,
                  35,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF1E306E),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profil Mahasiswa',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      'Lengkapi data diri kamu di bawah ini',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // =========================
              // FOTO
              // =========================

              GestureDetector(
                onTap: pilihFoto,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [

                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: tampilkanFoto(
                        ukuran: 125,
                      ),
                    ),

                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E306E),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Tap untuk memilih foto profile',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 25),

              // =========================
              // FORM
              // =========================

              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      'Data Diri',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E306E),
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'Masukkan informasi mahasiswa',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // NAMA
                    const Text(
                      'Nama Lengkap',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: namaController,
                      textCapitalization:
                          TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: 'Masukkan nama lengkap',
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: Color(0xFF1E306E),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF7F8FC),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // NPM
                    const Text(
                      'NPM',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: npmController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Masukkan NPM',
                        prefixIcon: const Icon(
                          Icons.badge_outlined,
                          color: Color(0xFF1E306E),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF7F8FC),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // JURUSAN
                    const Text(
                      'Jurusan',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: jurusanController,
                      textCapitalization:
                          TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText:
                            'Contoh: Manajemen Informatika',
                        prefixIcon: const Icon(
                          Icons.school_outlined,
                          color: Color(0xFF1E306E),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF7F8FC),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // SAVE
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: simpanData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF1E306E),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save_outlined),
                            SizedBox(width: 10),
                            Text(
                              'Simpan Data',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =========================
              // HASIL DATA
              // =========================

              if (nama.isNotEmpty) ...[
                const SizedBox(height: 25),

                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1E306E),
                        Color(0xFF344F9C),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius:
                        BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E306E)
                            .withOpacity(0.25),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      const Row(
                        children: [
                          Icon(
                            Icons.verified,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Profil Tersimpan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      tampilkanFoto(
                        ukuran: 95,
                      ),

                      const SizedBox(height: 15),

                      Text(
                        nama,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        npm,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 13,
                        ),
                        decoration: BoxDecoration(
                          color:
                              Colors.white.withOpacity(0.12),
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.school_outlined,
                              color: Colors.white,
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Text(
                                jurusan,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}

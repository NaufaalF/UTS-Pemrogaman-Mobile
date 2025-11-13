import 'dart:io';
import 'dart:async';
import 'dart:math';
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
      title: 'UTS Pemrograman Mobile',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}

// ==================== SPLASH SCREEN ====================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Dashboard()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
              ),

              const SizedBox(height: 25),
              const Text(
                'UTS Pemrograman Mobile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Nama: Naufal Febrian',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                'NRP: 152023010',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== DASHBOARD (FRAGMENTS) ====================
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  // fragment list
  final List<Widget> _pages = [
    const BiodataFragment(),
    const KontakFragment(),
    const KalkulatorFragment(),
    const CuacaFragment(),
    const BeritaFragment(),
  ];

  final List<String> _titles = [
    "Biodata",
    "Kontak",
    "Kalkulator",
    "Cuaca",
    "Berita"
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Biodata'),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Kontak'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Kalkulator'),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Cuaca'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'Berita'),
        ],
      ),
    );
  }
}

// ==================== FRAGMENT 1: BIODATA ====================
class BiodataFragment extends StatefulWidget {
  const BiodataFragment({super.key});

  @override
  _BiodataFragmentState createState() => _BiodataFragmentState();
}

class _BiodataFragmentState extends State<BiodataFragment> {
  bool isEditing = false;

  String name = 'Naufal Febrian';
  String about = 'Mahasiswa informatika dari ITENAS semester 5';
  String phone = '085721621472';
  String gender = 'Laki-laki';
  DateTime? birthDate;
  File? profileImage;

  late TextEditingController nameController;
  late TextEditingController aboutController;
  late TextEditingController phoneController;
  late TextEditingController genderController;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: name);
    aboutController = TextEditingController(text: about);
    phoneController = TextEditingController(text: phone);
    genderController = TextEditingController(text: gender);
  }

  @override
  void dispose() {
    nameController.dispose();
    aboutController.dispose();
    phoneController.dispose();
    genderController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      if (isEditing) {
        name = nameController.text;
        about = aboutController.text;
        phone = phoneController.text;
        gender = genderController.text;
      }
      isEditing = !isEditing;
    });
  }

  Future<void> _pickImage() async {
    final XFile? picked =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (picked != null) {
      setState(() {
        profileImage = File(picked.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: birthDate ?? DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        birthDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // === CARD PROFIL ===
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3))
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: profileImage != null
                              ? FileImage(profileImage!)
                              : const AssetImage('assets/profile.jpg')
                                  as ImageProvider,
                        ),
                        if (isEditing)
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.lightBlueAccent.withOpacity(0.8),
                                shape: BoxShape.circle),
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt,
                                  color: Colors.white),
                              onPressed: _pickImage,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    isEditing
                        ? TextField(
                            controller: nameController,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Masukkan Nama',
                              hintStyle: TextStyle(color: Colors.white54),
                            ),
                          )
                        : Text(
                            name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                    const SizedBox(height: 6),
                    isEditing
                        ? TextField(
                            controller: aboutController,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Masukkan deskripsi...',
                                hintStyle: TextStyle(color: Colors.white54)),
                          )
                        : Text(
                            about,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: _toggleEdit,
                      child: Text(
                        isEditing ? 'Simpan Perubahan' : 'Edit Profil',
                        style: const TextStyle(
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // === INFO LAIN ===
              _buildInfoCard(Icons.phone, 'Nomor Telepon', phoneController,
                  enabled: isEditing, isNumber: true),

              // 🔹 Bagian Gender yang bisa diubah
              _buildGenderCard(),

              _buildInfoCard(
                  Icons.calendar_today,
                  'Tanggal Lahir',
                  TextEditingController(
                      text: birthDate == null
                          ? '-'
                          : '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}'),
                  enabled: false,
                  trailing: isEditing
                      ? IconButton(
                          icon: const Icon(Icons.date_range,
                              color: Colors.lightBlueAccent),
                          onPressed: () => _selectDate(context),
                        )
                      : null),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Widget untuk Gender
  Widget _buildGenderCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(0, 3))
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.wc, color: Colors.lightBlueAccent),
          const SizedBox(width: 16),
          Expanded(
            child: isEditing
                ? DropdownButtonFormField<String>(
                    value: gender,
                    dropdownColor: const Color(0xFF2A5298),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Laki-laki',
                        child: Text('Laki-laki'),
                      ),
                      DropdownMenuItem(
                        value: 'Perempuan',
                        child: Text('Perempuan'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          gender = val;
                          genderController.text = val;
                        });
                      }
                    },
                  )
                : Text(
                    gender,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    IconData icon,
    String title,
    TextEditingController controller, {
    bool enabled = false,
    bool isNumber = false,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(0, 3))
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.lightBlueAccent),
          const SizedBox(width: 16),
          Expanded(
            child: enabled
                ? TextField(
                    controller: controller,
                    keyboardType:
                        isNumber ? TextInputType.phone : TextInputType.text,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Masukkan data',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                  )
                : Text(
                    controller.text,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}

// ==================== FRAGMENT 2: KONTAK ====================
class KontakFragment extends StatelessWidget {
  const KontakFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> contacts = [
      {"nama": "Naufal Febrian", "nomor": "085721621472"},
      {"nama": "Budi Santoso", "nomor": "081234567890"},
      {"nama": "Siti Lestari", "nomor": "082134567890"},
      {"nama": "Andi Wijaya", "nomor": "083812345678"},
      {"nama": "Dewi Anggraini", "nomor": "081298765432"},
      {"nama": "Rina Wulandari", "nomor": "085612345678"},
      {"nama": "Ahmad Fauzan", "nomor": "087712345678"},
      {"nama": "Citra Maharani", "nomor": "089912345678"},
      {"nama": "Bayu Saputra", "nomor": "082212345678"},
      {"nama": "Putri Amelia", "nomor": "081345678901"},
      {"nama": "Rizky Ramadhan", "nomor": "083856789012"},
      {"nama": "Indah Permata", "nomor": "085634567890"},
      {"nama": "Fajar Pratama", "nomor": "089876543210"},
      {"nama": "Lina Kusuma", "nomor": "081267891234"},
      {"nama": "Tono Rahman", "nomor": "082189012345"},
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final c = contacts[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.lightBlueAccent.withOpacity(0.3),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                title: Text(
                  c["nama"]!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  c["nomor"]!,
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.phone, color: Colors.lightBlueAccent),
                  onPressed: () {
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ==================== FRAGMENT 3: KALKULATOR ====================
class KalkulatorFragment extends StatefulWidget {
  const KalkulatorFragment({super.key});

  @override
  _KalkulatorFragmentState createState() => _KalkulatorFragmentState();
}

class _KalkulatorFragmentState extends State<KalkulatorFragment> {
  String input = '';
  String result = '';
  bool isSqrtMode = false;

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '';
        isSqrtMode = false;
      } else if (value == '⌫') {
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
      } else if (value == '=') {
        try {
          result = _calculate(input);
        } catch (e) {
          result = 'Error';
        }
        isSqrtMode = false;
      } else if (value == 'x²') {
        input += '^2';
      } else if (value == '√') {
        isSqrtMode = true;
        input = '√';
      } else {
        input += value;
      }
    });
  }

  String _calculate(String rawExpr) {
    String expr = rawExpr.replaceAll('x', '*').replaceAll('÷', '/');
    expr = expr.replaceAllMapped(RegExp(r'√(-?\d+(\.\d+)?)'), (m) {
      final numStr = m.group(1)!;
      final num = double.parse(numStr);
      if (num < 0) throw Exception('sqrt negative');
      return _formatNumberDouble(sqrt(num));
    });

    final tokens = _tokenize(expr);
    if (tokens.isEmpty) throw Exception('empty');

    while (tokens.contains('^')) {
      int idx = tokens.lastIndexOf('^');
      final left = double.parse(tokens[idx - 1]);
      final right = double.parse(tokens[idx + 1]);
      final res = pow(left, right).toDouble();
      tokens.replaceRange(idx - 1, idx + 2, [_formatNumberDouble(res)]);
    }

    int i = 0;
    while (i < tokens.length) {
      if (tokens[i] == '*' || tokens[i] == '/') {
        final op = tokens[i];
        final left = double.parse(tokens[i - 1]);
        final right = double.parse(tokens[i + 1]);
        final res = (op == '*') ? left * right : left / right;
        tokens.replaceRange(i - 1, i + 2, [_formatNumberDouble(res)]);
        i = 0;
      } else {
        i++;
      }
    }

    double acc = double.parse(tokens[0]);
    i = 1;
    while (i < tokens.length) {
      final op = tokens[i];
      final val = double.parse(tokens[i + 1]);
      if (op == '+') acc += val;
      else if (op == '-') acc -= val;
      i += 2;
    }

    return _formatNumberDouble(acc);
  }

  List<String> _tokenize(String expr) {
    List<String> tokens = [];
    String numBuffer = '';
    for (int i = 0; i < expr.length; i++) {
      final ch = expr[i];
      if (_isDigit(ch) || ch == '.') {
        numBuffer += ch;
      } else if (_isOperatorChar(ch)) {
        if (ch == '-' && (numBuffer.isEmpty && (tokens.isEmpty || _isOperator(tokens.last)))) {
          numBuffer = '-';
        } else {
          if (numBuffer.isNotEmpty) {
            tokens.add(numBuffer);
            numBuffer = '';
          }
          tokens.add(ch);
        }
      }
    }
    if (numBuffer.isNotEmpty) tokens.add(numBuffer);
    return tokens;
  }

  bool _isDigit(String ch) => RegExp(r'[0-9]').hasMatch(ch);
  bool _isOperatorChar(String ch) => '+-*/^'.contains(ch);
  bool _isOperator(String s) => s.length == 1 && _isOperatorChar(s);

  String _formatNumberDouble(double v) {
    if (v.isInfinite || v.isNaN) throw Exception('math error');
    if (v % 1 == 0) return v.toInt().toString();
    String s = v.toStringAsFixed(6);
    s = s.replaceFirst(RegExp(r'0+$'), '');
    s = s.replaceFirst(RegExp(r'\.$'), '');
    return s;
  }

  final List<String> buttons = [
    'C', '⌫', 'x²', '÷',
    '7', '8', '9', 'x',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '√', '0', '.', '='
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 30),

            // === DISPLAY HASIL ===
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    result.isEmpty ? '' : '= $result',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // === GRID TOMBOL ===
            Expanded(
              flex: 0,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final value = buttons[index];
                  final isOperator = ['÷', 'x', '-', '+', '='].contains(value);
                  final isSpecial = ['C', '⌫', 'x²', '√'].contains(value);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => buttonPressed(value),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        backgroundColor: isOperator
                            ? const Color(0xFF4FC3F7)
                            : (isSpecial
                                ? const Color(0xFFBBDEFB)
                                : Colors.white.withOpacity(0.15)),
                        elevation: 4,
                      ),
                      child: Text(
                        value,
                        style: TextStyle(
                          color: isOperator
                              ? Colors.white
                              : (isSpecial
                                  ? Colors.blue.shade900
                                  : Colors.white),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// ==================== FRAGMENT 4: CUACA ====================
class CuacaFragment extends StatelessWidget {
  const CuacaFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return const WeatherScreen();
  }
}

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5A86E8),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF5A86E8),
                Color(0xFF90CAF9),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Text(
                      'Bojongsoang',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),

              // Forecast 24 jam
              const Forecast24Hours(),

              const SizedBox(height: 12),

              // Grid info cuaca
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.2,
                    children: const [
                      WeatherInfoCard(
                        title: 'UV',
                        value: 'Weak',
                        detail: '2',
                        icon: Icons.wb_sunny_outlined,
                        color: Colors.orange,
                      ),
                      WeatherInfoCard(
                        title: 'Humidity',
                        value: '82%',
                        icon: Icons.water_drop_outlined,
                        color: Colors.lightBlue,
                      ),
                      WeatherInfoCard(
                        title: 'Real feel',
                        value: '25°',
                        icon: Icons.thermostat_outlined,
                        color: Colors.redAccent,
                      ),
                      WeatherInfoCard(
                        title: 'West',
                        value: '11.0 km/h',
                        icon: Icons.explore_outlined,
                        color: Colors.blueGrey,
                      ),
                      WeatherInfoCard(
                        title: 'Sunset',
                        value: '17:46',
                        icon: Icons.wb_twilight_outlined,
                        color: Colors.deepOrange,
                      ),
                      WeatherInfoCard(
                        title: 'Pressure',
                        value: '1009 mbar',
                        icon: Icons.speed_outlined,
                        color: Colors.cyan,
                      ),
                    ],
                  ),
                ),
              ),

              // AQI footer
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.eco_outlined,
                            color: Colors.white, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'AQI 84',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Text(
                      'Full air quality forecast >',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Forecast24Hours extends StatelessWidget {
  const Forecast24Hours({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'time': 'Now', 'temp': 25, 'icon': Icons.cloud, 'wind': 11.0},
      {'time': '17:00', 'temp': 25, 'icon': Icons.sunny, 'wind': 11.1},
      {'time': '17:46', 'temp': 25, 'icon': Icons.nightlight_round, 'wind': 11.1},
      {'time': '18:00', 'temp': 24, 'icon': Icons.thunderstorm_outlined, 'wind': 9.3},
      {'time': '19:00', 'temp': 23, 'icon': Icons.nightlight_round, 'wind': 7.4},
      {'time': '20:00', 'temp': 22, 'icon': Icons.cloud_outlined, 'wind': 7.4},
      {'time': '21:00', 'temp': 22, 'icon': Icons.sunny, 'wind': 7.4},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '24-hour forecast',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = items[index];
                return HourlyForecastItem(
                  time: item['time'] as String,
                  temp: item['temp'] as int,
                  icon: item['icon'] as IconData,
                  windSpeed: item['wind'] as double,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final int temp;
  final IconData icon;
  final double windSpeed;

  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.temp,
    required this.icon,
    required this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$temp°',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(icon, color: Colors.white, size: 22),
          Text(
            time,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          Text(
            '${windSpeed.toStringAsFixed(1)} km/h',
            style: const TextStyle(color: Colors.white60, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class WeatherInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String? detail;
  final IconData icon;
  final Color color;

  const WeatherInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 28),
              if (detail != null)
                Text(detail!,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}

// ==================== FRAGMENT 5: BERITA ====================
class BeritaFragment extends StatelessWidget {
  const BeritaFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> beritaList = [
      {
        "judul":
            "Belajar Makin Interaktif, Sekolah di Solo Gunakan Layar Sentuh Digital",
        "deskripsi": "52 menit yang lalu",
        "gambar":
            "https://akcdn.detik.net.id/community/media/visual/2025/11/13/belajar-makin-interaktif-sekolah-di-solo-gunakan-layar-sentuh-digital-1763017684964_169.jpeg?w=750&q=90",
      },
      {
        "judul": "4 Fakta Terkini di Kasus Ledakan SMAN 72 Jakarta",
        "deskripsi": "2 jam yang lalu",
        "gambar":
            "https://akcdn.detik.net.id/community/media/visual/2025/11/10/kondisi-sman-72-kelapa-gading-usai-ledakan-aparat-masih-berjaga-pagi-ini-1762739114121_169.jpeg?w=700&q=90",
      },
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Berita Terkini',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          itemCount: beritaList.length,
          itemBuilder: (context, index) {
            final b = beritaList[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    child: Image.network(
                      b["gambar"]!,
                      width: 110,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            b["judul"]!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            b["deskripsi"]!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
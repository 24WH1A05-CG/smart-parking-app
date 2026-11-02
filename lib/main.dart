import 'package:flutter/material.dart';

void main() {
  runApp(const SmartParkingApp());
}

class AppColors {
  static const navy = Color(0xFF101B3D);
  static const blue = Color(0xFF3563F6);
  static const sky = Color(0xFF6EA8FF);
  static const background = Color(0xFFF4F7FC);
  static const text = Color(0xFF17233F);
  static const muted = Color(0xFF7B879D);
  static const green = Color(0xFF18A874);
  static const red = Color(0xFFE65B68);
}

class SmartParkingApp extends StatelessWidget {
  const SmartParkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Parking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.blue,
          primary: AppColors.blue,
          surface: Colors.white,
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.text,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: AppColors.text,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF7F9FD),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFFE7ECF4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFFE7ECF4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.blue, width: 1.5),
          ),
          labelStyle: const TextStyle(color: AppColors.muted),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blue,
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size(double.infinity, 54),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            textStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;

  void login() {
    final email = emailController.text.trim();
    if (email.isEmpty || !email.contains('@') || passwordController.text.isEmpty) {
      _message(context, 'Please enter a valid email and password.');
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _AuthBackdrop(),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(22),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(26, 30, 26, 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.navy.withOpacity(.12),
                        blurRadius: 35,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _BrandMark(),
                      const SizedBox(height: 25),
                      const Text(
                        'Welcome back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: 27,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Sign in to find your perfect parking spot.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.muted, height: 1.5),
                      ),
                      const SizedBox(height: 28),
                      const _FieldCaption('EMAIL ADDRESS'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'you@example.com',
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const _FieldCaption('PASSWORD'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: passwordController,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            onPressed: () =>
                                setState(() => hidePassword = !hidePassword),
                            icon: Icon(hidePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: login,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Sign in'),
                            SizedBox(width: 9),
                            Icon(Icons.arrow_forward_rounded, size: 19),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("New to SmartPark? ",
                              style: TextStyle(color: AppColors.muted)),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SignupPage()),
                            ),
                            child: const Text(
                              'Create account',
                              style: TextStyle(
                                color: AppColors.blue,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool hidePassword = true;

  void signup() {
    final email = emailController.text.trim();
    if (nameController.text.trim().isEmpty ||
        email.isEmpty ||
        !email.contains('@') ||
        passwordController.text.length < 6 ||
        passwordController.text != confirmController.text) {
      _message(context,
          'Check your details. Passwords must match and contain at least 6 characters.');
      return;
    }
    _message(context, 'Account created! Please sign in.');
    Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          const _AuthBackdrop(),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 25),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Container(
                  padding: const EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(27),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.navy.withOpacity(.10),
                        blurRadius: 30,
                        offset: const Offset(0, 14),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _BrandMark(),
                      const SizedBox(height: 22),
                      const Text(
                        'Create your account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: AppColors.text,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'A smarter parking experience starts here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.muted),
                      ),
                      const SizedBox(height: 25),
                      const _FieldCaption('FULL NAME'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: 'Your full name',
                          prefixIcon: Icon(Icons.person_outline_rounded),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const _FieldCaption('EMAIL ADDRESS'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'you@example.com',
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const _FieldCaption('PASSWORD'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: passwordController,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          hintText: 'At least 6 characters',
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            onPressed: () =>
                                setState(() => hidePassword = !hidePassword),
                            icon: Icon(hidePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const _FieldCaption('CONFIRM PASSWORD'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: confirmController,
                        obscureText: hidePassword,
                        decoration: const InputDecoration(
                          hintText: 'Re-enter your password',
                          prefixIcon: Icon(Icons.verified_user_outlined),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: signup,
                        child: const Text('Create account'),
                      ),
                      const SizedBox(height: 17),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Already have an account? Sign in'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.local_parking_rounded, color: AppColors.blue),
            SizedBox(width: 9),
            Text('SmartPark'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.navy, Color(0xFF254A9C), AppColors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blue.withOpacity(.22),
                      blurRadius: 22,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -8,
                      bottom: -18,
                      child: Icon(
                        Icons.local_parking_rounded,
                        size: 125,
                        color: Colors.white.withOpacity(.10),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 11, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.15),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'SMART PARKING SOLUTION',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(height: 19),
                        const Text(
                          'Parking made\nsimple.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            height: 1.12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Find a space. Book a spot. Get moving.',
                          style: TextStyle(
                            color: Colors.white.withOpacity(.78),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 22),
                        SizedBox(
                          width: 190,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.blue,
                              minimumSize: const Size(0, 48),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ParkingSlotsPage()),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Explore slots'),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward_rounded, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const _SectionHeading(
                title: 'Parking overview',
                subtitle: 'Live snapshot of your parking area',
              ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'Available',
                      count: '5',
                      icon: Icons.check_circle_outline_rounded,
                      color: AppColors.green,
                      tint: Color(0xFFE7F7F0),
                    ),
                  ),
                  SizedBox(width: 13),
                  Expanded(
                    child: _StatCard(
                      title: 'Occupied',
                      count: '3',
                      icon: Icons.directions_car_filled_rounded,
                      color: AppColors.red,
                      tint: Color(0xFFFFECEE),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const _SectionHeading(
                title: 'Quick access',
                subtitle: 'Everything you need in one place',
              ),
              const SizedBox(height: 14),
              _QuickAction(
                icon: Icons.grid_view_rounded,
                title: 'View parking slots',
                subtitle: 'Choose from the available spaces',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ParkingSlotsPage()),
                ),
              ),
              const SizedBox(height: 12),
              const _InfoCard(),
              const SizedBox(height: 22),
              const Center(
                child: Text(
                  'SMARTPARK  •  PARK SMARTER, MOVE FASTER',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 10,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ParkingSlotsPage extends StatefulWidget {
  const ParkingSlotsPage({super.key});

  @override
  State<ParkingSlotsPage> createState() => _ParkingSlotsPageState();
}

class _ParkingSlotsPageState extends State<ParkingSlotsPage> {
  final List<bool> occupied = [
    false, true, false, false,
    true, false, true, false,
  ];

  void bookSlot(int index) {
    setState(() => occupied[index] = true);
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                  color: Color(0xFFE7F7F0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded,
                    color: AppColors.green, size: 39),
              ),
              const SizedBox(height: 17),
              const Text(
                'You’re all set!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Parking slot P${index + 1} has been booked successfully.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.muted, height: 1.5),
              ),
              const SizedBox(height: 22),
              ElevatedButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableCount = occupied.where((slot) => !slot).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking spaces'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.navy, Color(0xFF254A9C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.14),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.local_parking_rounded,
                          color: Colors.white, size: 29),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Available right now',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 12),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '$availableCount of ${occupied.length} spaces',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.directions_car_rounded,
                        color: Colors.white70, size: 34),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  _LegendDot(color: AppColors.green, label: 'Available'),
                  const SizedBox(width: 22),
                  _LegendDot(color: AppColors.red, label: 'Occupied'),
                  const Spacer(),
                  Text(
                    '${occupied.length} TOTAL',
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 10,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 22),
                itemCount: occupied.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.18,
                ),
                itemBuilder: (context, index) {
                  final isOccupied = occupied[index];
                  final color = isOccupied ? AppColors.red : AppColors.green;
                  final tint =
                      isOccupied ? const Color(0xFFFFECEE) : const Color(0xFFE7F7F0);

                  return Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(21),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(21),
                      onTap: isOccupied ? null : () => bookSlot(index),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          border: Border.all(
                            color: color.withOpacity(.30),
                            width: 1.3,
                          ),
                        ),
                        padding: const EdgeInsets.all(13),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                color: tint,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                Icons.directions_car_filled_rounded,
                                color: color,
                                size: 27,
                              ),
                            ),
                            const SizedBox(height: 9),
                            Text(
                              'P${index + 1}',
                              style: const TextStyle(
                                color: AppColors.text,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: tint,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                isOccupied ? 'Occupied' : 'Tap to book',
                                style: TextStyle(
                                  color: color,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthBackdrop extends StatelessWidget {
  const _AuthBackdrop();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEAF1FF), Color(0xFFF6F8FD), Color(0xFFE9F4FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -100,
              right: -70,
              child: _GlowCircle(size: 250),
            ),
            Positioned(
              bottom: -110,
              left: -80,
              child: _GlowCircle(size: 260),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final double size;
  const _GlowCircle({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.sky.withOpacity(.12),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 68,
          width: 68,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.blue, AppColors.sky],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(21),
            boxShadow: [
              BoxShadow(
                color: AppColors.blue.withOpacity(.25),
                blurRadius: 16,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: const Icon(Icons.local_parking_rounded,
              color: Colors.white, size: 39),
        ),
        const SizedBox(height: 11),
        const Text(
          'SMARTPARK',
          style: TextStyle(
            color: AppColors.navy,
            fontSize: 12,
            letterSpacing: 2.5,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _FieldCaption extends StatelessWidget {
  final String text;
  const _FieldCaption(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.text,
        fontSize: 10,
        letterSpacing: 1.1,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionHeading({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(subtitle,
            style: const TextStyle(color: AppColors.muted, fontSize: 12)),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final Color color;
  final Color tint;

  const _StatCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    required this.tint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFECF0F6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 39,
            width: 39,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 21),
          ),
          const SizedBox(height: 13),
          Text(
            count,
            style: TextStyle(
                color: color, fontSize: 27, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 2),
          Text(title,
              style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(19),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(19),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                height: 47,
                width: 47,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF2FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: AppColors.blue, size: 25),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            color: AppColors.text,
                            fontWeight: FontWeight.w800,
                            fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: const TextStyle(
                            color: AppColors.muted, fontSize: 11)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded,
                  color: AppColors.muted, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF1FF),
        borderRadius: BorderRadius.circular(19),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline_rounded,
              color: AppColors.blue, size: 23),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick tip',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Green spaces are available to book. Red spaces are currently occupied.',
                  style: TextStyle(
                    color: Color(0xFF536481),
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 9,
          width: 9,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 7),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

void _message(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      ),
    );
}

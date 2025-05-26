import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controllers لتجميع القيم من الحقول
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Icon(Icons.arrow_back_ios, size: 20),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  "New Account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Full Name
              const Text("Full name",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              customTextField(
                  controller: fullNameController, hint: 'example@example.com'),

              const SizedBox(height: 16),

              // Password
              const Text("Password",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  customTextField(
                    controller: passwordController,
                    hint: '************',
                    obscure: !passwordVisible,
                  ),
                  IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Email
              const Text("Email",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              customTextField(
                  controller: emailController, hint: 'example@example.com'),

              const SizedBox(height: 16),

              // Mobile Number
              const Text("Mobile Number",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              customTextField(
                  controller: phoneController, hint: 'example@example.com'),

              const SizedBox(height: 16),

              // Date of Birth
              const Text("Date Of Birth",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _selectDate, // 📅 استدعاء DatePicker
                child: AbsorbPointer(
                  child: customTextField(
                    controller: dobController,
                    hint: 'DD / MM / YYYY',
                    hintColor: Colors.blue,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // شروط الاستخدام
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "By continuing, you agree to ",
                    children: [
                      TextSpan(
                        text: "Terms of Use ",
                        style: TextStyle(color: Colors.blue),
                      ),
                      TextSpan(text: "and "),
                      TextSpan(
                        text: "Privacy Policy.",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 24),

              // زر التسجيل
              Center(
                child: ElevatedButton(
                  onPressed: _signUpUser, // 🚀 استدعاء دالة التسجيل
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // رابط تسجيل الدخول
              Center(
                child: GestureDetector(
                  onTap: () {
                    // 👈 التنقل إلى شاشة تسجيل الدخول
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: "already have an account? ",
                      children: [
                        TextSpan(
                          text: "Log in",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // 📅 دالة اختيار التاريخ
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        dobController.text = "${picked.day.toString().padLeft(2, '0')} / "
            "${picked.month.toString().padLeft(2, '0')} / "
            "${picked.year}";
      });
    }
  }

  // 🚀 دالة تنفيذ التسجيل (ربطها مستقبلاً بـ Firebase أو API)
  void _signUpUser() {
    final fullName = fullNameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final dob = dobController.text.trim();

    // ✅ هنا يمكن إضافة التحقق من صحة البيانات أو الاتصال بالخادم
    print(
        "Name: $fullName, Email: $email, Phone: $phone, DOB: $dob, Password: $password");
  }

  // 🔧 عنصر قابل لإعادة الاستخدام لحقول الإدخال
  Widget customTextField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    Color hintColor = Colors.grey,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: hintColor),
        filled: true,
        fillColor: const Color(0xFFE9EEFF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

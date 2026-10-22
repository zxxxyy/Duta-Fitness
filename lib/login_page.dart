import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Halaman Login DutaSport.
class _L {
  _L._();
  static const pageBg = Color(0xFF111827);
  static const cardBg = Color(0xFF1F2937);
  static const cardBorder = Color(0xFF374151);
  static const inputBg = Color(0xFF374151);
  static const inputBorder = Color(0xFF4B5563);
  static const red = Color(0xFFDC2626);
  static const redLink = Color(0xFFF87171);
  static const white = Color(0xFFFFFFFF);
  static const label = Color(0xFFD1D5DB);
  static const muted = Color(0xFF9CA3AF);
  static const footer = Color(0xFF6B7280);
}

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    this.onSubmit,
    this.onForgotPassword,
    this.onRegister,
  });

  /// Aksi belum didefinisikan pada desain, jadi opsional.
  final void Function(String email, String password)? onSubmit;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onRegister;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _L.pageBg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _brand(),
                  const SizedBox(height: 24),
                  _card(),
                  const SizedBox(height: 24),
                  Text(
                    '© 2026 Duta Fitness Sport Center',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 12, height: 1.4, color: _L.footer),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Logo 95 x 85, judul, subjudul (referensi y 32-220).
  Widget _brand() {
    return Column(
      children: [
        SizedBox(
          width: 95,
          height: 85,
          child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
        ),
        const SizedBox(height: 24),
        Text(
          'Duta Fitness Sport Center',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              fontSize: 22,
              height: 32 / 22,
              fontWeight: FontWeight.w700,
              color: _L.white),
        ),
        const SizedBox(height: 24),
        Text(
          'Membership Gym & Sport Center',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              fontSize: 14, height: 23 / 14, color: _L.muted),
        ),
      ],
    );
  }

  Widget _card() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: _L.cardBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _L.cardBorder),
        boxShadow: const [
          BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 25),
              blurRadius: 50,
              spreadRadius: -12),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Masuk ke Akun Anda',
            style: GoogleFonts.inter(
                fontSize: 24,
                height: 35 / 24,
                fontWeight: FontWeight.w700,
                color: _L.white),
          ),
          Text(
            'Silakan login untuk melanjutkan\nbooking dan membership',
            style: GoogleFonts.inter(
                fontSize: 14, height: 26 / 14, color: _L.muted),
          ),
          const SizedBox(height: 32),
          _label('Email'),
          const SizedBox(height: 8),
          _field(
            controller: _email,
            hint: 'Masukkan email Anda',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),
          _label('Password'),
          const SizedBox(height: 8),
          _field(
            controller: _password,
            hint: 'Masukkan password Anda',
            obscure: _obscure,
            suffix: IconButton(
              onPressed: () => setState(() => _obscure = !_obscure),
              icon: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 20,
                  color: _L.muted),
            ),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: widget.onForgotPassword ?? () {},
              child: Text('Lupa password?',
                  style: GoogleFonts.inter(
                      fontSize: 14, height: 23 / 14, color: _L.redLink)),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: FilledButton(
              onPressed: () =>
                  widget.onSubmit?.call(_email.text, _password.text),
              style: FilledButton.styleFrom(
                backgroundColor: _L.red,
                foregroundColor: _L.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Masuk',
                  style: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('Belum punya akun? ',
                    style: GoogleFonts.inter(
                        fontSize: 14, height: 23 / 14, color: _L.muted)),
                InkWell(
                  onTap: widget.onRegister ?? () {},
                  child: Text('Daftar',
                      style: GoogleFonts.inter(
                          fontSize: 14, height: 23 / 14, color: _L.redLink)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String t) => Text(t,
      style: GoogleFonts.inter(
          fontSize: 14,
          height: 1.5,
          fontWeight: FontWeight.w500,
          color: _L.label));

  Widget _field({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    Widget? suffix,
    TextInputType? keyboardType,
  }) {
    OutlineInputBorder border() => OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _L.inputBorder),
        );
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: GoogleFonts.inter(fontSize: 16, color: _L.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: _L.inputBg,
          hintText: hint,
          hintStyle: GoogleFonts.inter(fontSize: 16, color: _L.white),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: suffix,
          enabledBorder: border(),
          focusedBorder: border().copyWith(
              borderSide: const BorderSide(color: _L.redLink)),
          border: border(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_page.dart';

/// Landing Page DutaSport.
void main() => runApp(const DutaSportApp());

// ---------------------------------------------------------------------------
// Design tokens (diambil dari referensi)
// ---------------------------------------------------------------------------
class DutaColors {
  DutaColors._();

  static const black = Color(0xFF000000);
  static const heroTint = Color(0x1AE31E24); // merah 10%
  static const red = Color(0xFFEF4444);
  static const redIconBox = Color(0xFF3C1E25);
  static const featureSectionBg = Color(0x4D111827); // #111827 @ 30%
  static const featureCardBg = Color(0xFF0F141D);
  static const secondaryButtonBg = Color(0xFF030508);
  static const secondaryButtonBorder = Color(0xFF374151);
  static const textPrimary = Color(0xFFFFFFFF);
  static const textHeroSub = Color(0xFFD1D5DB);
  static const textMuted = Color(0xFF9CA3AF);
  static const textFooter = Color(0xFF6B7280);
  static const iconBoxBorder = Color(0x33FFFFFF); // putih 20%
}

class DutaSportApp extends StatelessWidget {
  const DutaSportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DutaSport',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: DutaColors.black,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------
class LandingPage extends StatelessWidget {
  const LandingPage({
    super.key,
    this.onLogin,
    this.onViewFacilities,
    this.onAbout,
    this.onContact,
    this.onTerms,
  });

  /// Aksi tombol belum didefinisikan pada desain, jadi sengaja dibiarkan
  /// opsional (tanpa navigasi bawaan).
  final VoidCallback? onLogin;
  final VoidCallback? onViewFacilities;
  final VoidCallback? onAbout;
  final VoidCallback? onContact;
  final VoidCallback? onTerms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DutaColors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(
              onLogin: onLogin ??
                  () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LoginPage())),
              onViewFacilities: onViewFacilities,
            ),
            const FeaturesSection(),
            FooterSection(
              onAbout: onAbout,
              onContact: onContact,
              onTerms: onTerms,
            ),
          ],
        ),
      ),
    );
  }
}

/// Membatasi lebar konten agar tetap proporsional di layar lebar.
class _ContentBox extends StatelessWidget {
  const _ContentBox({required this.child, this.maxWidth = 960});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: child,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Hero (referensi: y 64-747)
// ---------------------------------------------------------------------------
class HeroSection extends StatelessWidget {
  const HeroSection({super.key, this.onLogin, this.onViewFacilities});

  final VoidCallback? onLogin;
  final VoidCallback? onViewFacilities;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: _ContentBox(
        maxWidth: 600,
        child: Column(
          children: [
            const _HeroImageCard(),
            const SizedBox(height: 32),
            // Judul: 2 baris @ 39px (referensi y 416-494).
            Text.rich(
              TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 28,
                  height: 1.4,
                  fontWeight: FontWeight.w700,
                  color: DutaColors.textPrimary,
                ),
                children: const [
                  TextSpan(text: 'Olahraga Jadi\n'),
                  TextSpan(
                    text: 'Lebih Mudah',
                    style: TextStyle(color: DutaColors.red),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Deskripsi: 2 baris @ ~24.5px (referensi y 510-559).
            Text(
              'Temukan fasilitas olahraga terbaik dan nikmati '
              'pengalaman fitness bersama Duta Sport Center',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                height: 1.75,
                color: DutaColors.textHeroSub,
              ),
            ),
            const SizedBox(height: 32),
            // Tombol: 56 + 12 + 56 (referensi y 591-715).
            _PrimaryButton(label: 'Login', onPressed: onLogin),
            const SizedBox(height: 12),
            _SecondaryButton(
              label: 'Lihat Fasilitas',
              onPressed: onViewFacilities,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

/// Kartu gambar hero: 343 x 320, radius 16, gradien gelap + tint merah 10%.
class _HeroImageCard extends StatelessWidget {
  const _HeroImageCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 320,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/hero_gym.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xB3000000), // hitam 70%
                    Color(0x99000000), // hitam 60%
                    Color(0xE60A0A0A), // #0A0A0A
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
            const ColoredBox(color: DutaColors.heroTint),
          ],
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        color: DutaColors.red,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40EF4444),
            offset: Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
          ),
          BoxShadow(
            color: Color(0x40EF4444),
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed ?? () {},
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: DutaColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        color: DutaColors.secondaryButtonBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: DutaColors.secondaryButtonBorder),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed ?? () {},
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: DutaColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Fitur: "Kenapa Duta Sport Center?" (referensi: y 747-1254)
// ---------------------------------------------------------------------------
class _Feature {
  const _Feature(this.icon, this.title, this.description);

  final IconData icon;
  final String title;
  final String description;
}

const _features = <_Feature>[
  _Feature(Icons.fitness_center, 'Gym Modern', 'Peralatan terbaru'),
  _Feature(Icons.sports_tennis, 'Pilihan Olahraga', 'Beragam Aktivitas Seru'),
  _Feature(Icons.badge, 'Membership', 'Pilihan Paket Fleksibel'),
  _Feature(Icons.event_available, 'Booking Praktis', 'Sewa Lapangan Instan'),
];

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: DutaColors.featureSectionBg,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: _ContentBox(
        child: Column(
          children: [
            Text(
              'Kenapa Duta Sport Center?',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 22,
                height: 1.6,
                fontWeight: FontWeight.w700,
                color: DutaColors.textPrimary,
              ),
            ),
            const SizedBox(height: 32),
            LayoutBuilder(
              builder: (context, constraints) {
                // Mobile: 2 kolom (sesuai referensi). Layar lebar: 4 kolom.
                final columns = constraints.maxWidth >= 640 ? 4 : 2;
                return _FeatureGrid(columns: columns);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid({required this.columns});

  final int columns;

  static const double _gap = 16;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < _features.length; i += columns) {
      final slice = _features.skip(i).take(columns).toList();
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var j = 0; j < columns; j++) ...[
                if (j > 0) const SizedBox(width: _gap),
                Expanded(
                  child: j < slice.length
                      ? _FeatureCard(feature: slice[j])
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ),
        ),
      );
      if (i + columns < _features.length) {
        rows.add(const SizedBox(height: _gap));
      }
    }
    return Column(children: rows);
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.feature});

  final _Feature feature;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      decoration: BoxDecoration(
        color: DutaColors.featureCardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Kotak ikon 48 x 48, radius 12 (border bagian dari desain).
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: DutaColors.redIconBox,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: DutaColors.iconBoxBorder),
            ),
            child: Icon(feature.icon, size: 22, color: DutaColors.red),
          ),
          const SizedBox(height: 20),
          Text(
            feature.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              height: 1.4,
              fontWeight: FontWeight.w700,
              color: DutaColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            feature.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              height: 1.4,
              color: DutaColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer (referensi: y 1254-1398)
// ---------------------------------------------------------------------------
class FooterSection extends StatelessWidget {
  const FooterSection({
    super.key,
    this.onAbout,
    this.onContact,
    this.onTerms,
  });

  final VoidCallback? onAbout;
  final VoidCallback? onContact;
  final VoidCallback? onTerms;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: DutaColors.black,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: _ContentBox(
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 32,
                runSpacing: 8,
                children: [
                  _FooterLink(label: 'Tentang Kami', onTap: onAbout),
                  _FooterLink(label: 'Kontak', onTap: onContact),
                  _FooterLink(label: 'Syarat & Ketentuan', onTap: onTerms),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                '© 2026 Duta Fitness Sport Center. All rights reserved.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  height: 1.5,
                  color: DutaColors.textFooter,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          height: 1.5,
          color: DutaColors.textMuted,
        ),
      ),
    );
  }
}

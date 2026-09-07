import 'dart:async';
import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flowee_app/models/promo_banner.dart';
import 'package:flowee_app/widgets/banner_slide.dart';
import 'package:flowee_app/widgets/carousel_dots.dart';
import 'package:flutter/material.dart';
/**
 * Instate sebelum perubahan dan set state itu setelah berubah
 */

// corousel abnner, akan bergeser otomatis setiap beberapa detik, untuk handling timer seperti ini, kita butuh peran stf untuk melakukan perubahan widget pada layar
class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key, required this.banners});

  final List<PromoBanner> banners;

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  /**
   * PageController --> mengatur slide mana yang sedang tampil di PageView (yang akan mengatur yang tampil banner kita)
   */

  late final PageController _controller = PageController();
  Timer? _timer;
  int _page = 0;

  @override
  void iniState() {
    super.initState();
    // Timer.periodic --> menjalankan fungsi didalannya secara BERULANG-ULANG
    _timer = Timer.periodic(Duration(seconds: 4), (_) {
      if (!mounted || widget.banners.isEmpty) return;
      final next = (_page + 1) % widget.banners.length;
      _controller.animateToPage(
        next,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic
      );
    }); 
  }

  @override
  /**
   * Timer HARUS dicancel saat widget dihancurkan (saat tidak tampil dilayar). Kalau lupa,
   * timer akan terus mencoba jalan dilatar belakang (background), walau carouselnya
   * tidak muncul dilayar, ini salah satu penyebab umum memory leak di Flutter.
   */

  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) return const SizedBox.shrink(); 
    return Column(
      children: [
        SizedBox(
          height: 168,
          child: PageView.builder(
            controller: _controller,
            // berapa banyak dia ditampilkan
            itemCount: widget.banners.length,
            /**
             * dipanggil juga saat pengguna swipe manual, bukan cuma saat 
             * digeser otomatis oleh Timer, supaya titik indikator dibawah selalu sinkron dengan slide yang bener-bener tampil
             */
            onPageChanged: (index) => setState(() => _page = index),
            // mau nampilin data yang ada banner slide dan diurutin berdasarkan index
            itemBuilder: (context, index) => BannerSlide(banner: widget.banners[index]),
          ),
        ),
        SizedBox(height: 10,),
        CarouselDots(
          count: widget.banners.length,
          activeIndex: _page,
          activeColor: widget.banners[_page].gradientColors.first,
        )
      ],
    );
  }
}
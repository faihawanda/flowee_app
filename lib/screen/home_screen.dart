import 'package:flowee_app/data/dummy_data.dart';
import 'package:flowee_app/models/flower.dart';
import 'package:flowee_app/screen/detail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _query = '';
  String _selectedCategory = 'Semua';

  // method getter
  List<String> get categories {
    final unique = <String>{'Semua', ...dummyFlowers.map((f) => f.category)};
    return unique.toList();
  }

  List<Flower> get _filteredFlower {
    return dummyFlowers.where((flower) {
      // biar bisa disearch lowercase atau punya huruf besar
      final matchesQuery = flower.name.toLowerCase().contains(_query.toLowerCase());
      final matchesCategory = _selectedCategory == 'Semua' || flower.category == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  void _openDetail(Flower flower) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => DetailScreen(flower: flower)));
  }

  @override
  Widget build(BuildContext context) {
    final flower = _filteredFlower;


    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: HomeHeader,
          )
        ],
      ),
    );
  }
}
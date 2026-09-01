import 'package:flutter/material.dart';

// untuk garis kecil abu di bagian atas atau sebuah sheet UI sebagai tanda bahwa screen/sheet tersebut bisa di drag diatas
class SheetDragHandle extends StatelessWidget {
  const SheetDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 44,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(3)
        ),
      ),
    );
  }
}
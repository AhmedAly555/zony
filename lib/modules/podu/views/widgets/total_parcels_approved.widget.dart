/*
import 'package:flutter/material.dart';

class TotalParcelsApproved extends StatefulWidget {

  final GlobalKey<TotalParcelsApprovedState> counterKey;
  final String title;

  const TotalParcelsApproved({super.key, required this.counterKey, required this.title});

  @override
  State<TotalParcelsApproved> createState() => TotalParcelsApprovedState();
}

class TotalParcelsApprovedState extends State<TotalParcelsApproved> {
  int _successCount = 0;


  void incrementCounter() {
    setState(() {
      _successCount++;
    });
  }
  int getCurrentCount() => _successCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16        ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: Color(0xFF929292),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),

          Text(
            '$_successCount',
            style: TextStyle(
              color: Color(0xFF49159B),
              fontSize: 45,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';

class TotalParcelsCounter extends StatelessWidget {

  final String title;
  final String value;

  const TotalParcelsCounter({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF929292),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              color: Color(0xFF49159B),
              fontSize: 45,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
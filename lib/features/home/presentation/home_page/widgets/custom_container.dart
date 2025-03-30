import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String time;
  final String status;
  final Widget icon;

  const CustomContainer({
    super.key,
    required this.time,
    required this.status,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                time,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Color(0xFFF2F4F8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: icon,
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            status,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF9E9E9E),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomLoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final Color? color;
  const CustomLoadingContainer({super.key,this.color,required this.isLoading,required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if(isLoading)
          Container(
            color:color?? Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.green,),
            ),
          )
      ],
    );
  }
}

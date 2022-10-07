import 'package:flutter/material.dart';

class RemoveIconWidget extends StatelessWidget {
  const RemoveIconWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black45),
        borderRadius: BorderRadius.circular(8),
        color: Color.fromARGB(255, 255, 199, 199),
      ),
      height: 40,
      width: 115,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.remove_circle_outline_rounded,
              color: Colors.red,
              size: 25,
            ),
            Text(
              "Remove",
              style: TextStyle(
                  fontSize: 16, color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

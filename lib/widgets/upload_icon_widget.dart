import 'package:flutter/material.dart';

class UploadIconWidget extends StatelessWidget {
  const UploadIconWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black45),
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue[50],
      ),
      height: 40,
      width: 105,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.upload,
              color: Colors.blue[600],
              size: 25,
            ),
            Text(
              "Upload",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue[600],
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

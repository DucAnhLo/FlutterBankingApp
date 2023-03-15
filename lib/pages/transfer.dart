import 'package:flutter/material.dart';

class Transfer extends StatelessWidget {
  final String qrCodeContent;
  const Transfer({super.key, required this.qrCodeContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200,),
            Text("Your are transfering"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("£"),
                Flexible(child: SizedBox(
                  width: 100,
                  child: TextFormField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'amount'
                    ),
                  ),
                ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("To"),
                SizedBox(width: 5,),
                Text("$qrCodeContent")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
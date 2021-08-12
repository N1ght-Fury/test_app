import 'package:flutter/material.dart';
import 'package:test_app/widgets/custom_network_image.dart';

class ProductCard extends StatelessWidget {
  final Map productData;
  const ProductCard({required this.productData});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 130,
      child: GestureDetector(
        onTap: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Scaffold(
                body: Center(
                  child: CustomNetworkImage(url: productData['picture']),
                ),
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(0),
          color: Colors.white,
          child: Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 12,
                ),
                Container(
                  height: 100,
                  width: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.7),
                          blurRadius: 1.0,
                          spreadRadius: 2.5,
                          offset: const Offset(
                            0.0,
                            0.0,
                          ),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        child: CustomNetworkImage(
                          url: productData['picture'],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  child: Text(
                    productData['name'],
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

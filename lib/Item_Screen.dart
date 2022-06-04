import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:toast/toast.dart';
import 'package:new_coffee_hub/CartScreen.dart';
import 'package:new_coffee_hub/Constants.dart';
import 'package:new_coffee_hub/Product.dart';

class ItemScreen extends StatefulWidget {
  Product product;
  int index;
  ItemScreen({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  List<String> MilkType = ["Oat Milk", "Soy Milk", "Almond Milk"];
  int _selectedMilk = -1;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
        backgroundColor: Color(0xFF1C161E),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image(
                          image: AssetImage(widget.product.image),
                          height: 380,
                          width: 340,
                          fit: BoxFit.cover,
                        ))),
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: CircleAvatar(
                    backgroundColor: Color(0xFF1C161E),
                    radius: 20,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color(0xffEFE3C8),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16.0),
              child: Text(
                CoffeeNames[widget.index],
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8.0),
                  child: Text(
                    widget.product.name.replaceAll("\n", " "),
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    maxLines: 1,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.star,
                  color: Colors.yellowAccent,
                  size: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 4.0),
                  child: Text(
                    widget.product.rate,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8.0),
              child: Text(
                widget.product.description,
                style: TextStyle(color: Colors.white, fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 12.0),
              child: Text(
                "Choice of Milk",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 10.0, right: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedMilk = index;
                        });
                      },
                      child: Container(
                          height: 10,
                          width: 100,
                          decoration: BoxDecoration(
                            color: index == _selectedMilk
                                ? Color(0xffEFE3C8)
                                : Colors.transparent,
                            border: Border.all(color: Color(0xffEFE3C8)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              MilkType[index],
                              style: TextStyle(
                                  color: index == _selectedMilk
                                      ? Color(0xFF1C161E)
                                      : Color(0xffEFE3C8)),
                            ),
                          )),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  width: 1,
                ),
                itemCount: MilkType.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 16.0, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      Text(
                        "\$ " + widget.product.price,
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 250,
                      height: 45,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_selectedMilk == -1) {
                       Toast.show("Please select milk type", duration:2);
                            } else {
                              if(CartProducts.contains(widget.product)){
                                int l=CartProducts.indexOf(widget.product);
                                Toast.show("Item Added to Cart",duration: 2);
                                CartProducts[l].count++;
                              }
                              else{
                                Toast.show("Item Added to Cart",duration: 2);
                                CartProducts.add(widget.product);
                                CartProductNames.add(CoffeeNames[widget.index]);
                              }
                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CartScreen(products: CartProducts,productstype: CartProductNames,)));
                            }
                          },
                          child: Text(
                            "BUY NOW",
                            style: TextStyle(
                                color: Color(0xFF1C161E), fontSize: 18),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xffEFE3C8)),
                          )),
                    ),
                  )
                ],
              ),
            )
          ],
        )));
  }
}

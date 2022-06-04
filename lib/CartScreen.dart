import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:new_coffee_hub/Constants.dart';
import 'package:new_coffee_hub/Product.dart';
import 'package:dotted_line/dotted_line.dart';

class CartScreen extends StatefulWidget {
  List<Product> products;
  List<String> productstype;

  CartScreen({
    Key? key,
    required this.products,
    required this.productstype,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int total = 0;
  double totalVat = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotal();
    getVat(total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C161E),
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Center(
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          'Cart',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      IconButton(onPressed: (){
                        setState(() {
                          widget.products.clear();
                          widget.productstype.clear();
                          total = 0;
                          totalVat = 0;
                        });
                      }, icon: Icon(Icons.clear,color: Colors.white,),)
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.58,
                child: ListView.separated(
                  itemCount: CartProducts.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 15,
                  ),
                  itemBuilder: (context, index) => Dismissible(
                    key: UniqueKey(),
                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        CartProducts.removeAt(index);
                        CartProductNames.removeAt(index);
                        getTotal();
                        getVat(total);
                      });
                    },
                    background: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
                      child: Container(
                        color: Colors.red,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
                      child:
                          CartItem(product: CartProducts[index], index: index),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              DottedLine(
                  dashColor: Colors.brown,
                  dashLength: 10,
                  lineLength: MediaQuery.of(context).size.width - 20,
                  lineThickness: 3),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery Charges",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      CartProducts.isEmpty ? "0" : "\$9",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "VAT",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      CartProducts.isEmpty
                          ? "0"
                          : "\$ " + totalVat.round().toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              DottedLine(
                  dashColor: Colors.brown,
                  dashLength: 10,
                  lineLength: MediaQuery.of(context).size.width - 20,
                  lineThickness: 1),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "GRAND TOTAL",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      CartProducts.isEmpty
                          ? "0"
                          : "\$ " + ((total + totalVat + 9).round().toString()),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                child: ElevatedButton(
                  onPressed: () {
                    Toast.show("Purchased successfully", duration:2);
                  },
                  child: Text(
                    "ORDER NOW",
                    style: TextStyle(
                        color: Color(0xFF1C161E),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
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
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CartItem({required Product product, index}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff362C36),
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width - 19,
      height: 100,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              width: 90,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                widget.productstype[index],
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                product.name.replaceAll("\n", " "),
                style: TextStyle(color: Colors.white,fontSize: 12),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "\$ " + product.price,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              width: 105,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xff463D46),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (CartProducts[index].count > 1) {
                          CartProducts[index].count--;
                          getTotal();
                          getVat(total);
                        }
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xffEFE3C8),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Icon(
                          Icons.remove,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    product.count.toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        CartProducts[index].count++;
                        getTotal();
                        getVat(total);
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xffEFE3C8),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int getTotal() {
    total = 0;
    for (int i = 0; i < CartProducts.length; i++) {
      total += CartProducts[i].count * int.parse(CartProducts[i].price);
    }
    return total;
  }

  double getVat(int total) {
    totalVat = total * (14 / 100);
    return (totalVat);
  }
}

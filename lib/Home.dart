import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:new_coffee_hub/Item_Screen.dart';
import 'package:new_coffee_hub/Product.dart';
import 'package:toast/toast.dart';

import 'CartScreen.dart';
import 'Constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

  bool itemClicked = false;


  List<double> offsetsx=[0,0,0,0,0,0];
  List<double> offsetsy=[0,0,0,0,0,0];
  bool ontap = true;
  initState() {
    super.initState();
  }

  int nameindex=0;


  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF1C161E),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "Menu",
                style: TextStyle(
                  color: Color(0xffEFE3C8),
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                height: 40,
                width: 343,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff171017),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                enabled: false,
                  style: TextStyle(
                    color: Color(0xffEFE3C8),
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    labelText: "Browse your favourite coffee",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xffEFE3C8).withOpacity(0.5),
                    ),
                    labelStyle:
                        TextStyle(color: Color(0xffEFE3C8).withOpacity(0.5)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              //528
              height: MediaQuery.of(context).size.height - (252 + 0.182 - 44),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(40)),
                        color: Color(0xff704341).withOpacity(0.3),
                      ),
                      height: MediaQuery.of(context).size.height -
                          (80 + 152.182 - 20),
                      width: 38,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ListView.builder(
                          itemBuilder: (context, index) {return
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0,left: 8),
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    nameindex= index;
                                  });

                                },
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    CoffeeNames[index],
                                    style: TextStyle(
                                      color: index == nameindex? Color(0xffEFE3C8):Color(0xffEFE3C8).withOpacity(0.5),
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: CoffeeNames.length,
                        ),
                      )),
                  Expanded(
                    child: GridView.builder(

                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.0,
                              mainAxisExtent: 250,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      padding: const EdgeInsets.only(
                          left: 15, top: 0, bottom: 10, right:10),
                      itemCount: 6,
                      itemBuilder: (BuildContext context, index) {
                        return Stack(
                          children: [
                            EmptyBox(),
                            GestureDetector(
                                onTapDown: (details){
                                  ontap=true;
                                setState(() {
                                  if(index==0||index==1){
                                index%2==0?    offsetsx[index]=10:offsetsx[index]=-10 ;
                                    offsetsy[index]=30;
                                  }
                                  else{
                                    index%2==0?    offsetsx[index]=10:offsetsx[index]=-10 ;
                                    offsetsy[index]=-30;
                                  }

                                });
                                print("down $ontap");
                                },
                              onTapUp: (details){
                                setState(() {
                                  offsetsx[index]=0;
                                  offsetsy[index]=0;
                                });
                           ontap=true;

                                print("Up $ontap");
                              },

                              onTapCancel: (){
                                  ontap=false;
                                setState(() {
                                  offsetsx[index]=0;
                                  offsetsy[index]=0;
                                });
                                print("Cancel $ontap");
                              },
                              onTap:(){
                               if(ontap){
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ItemScreen(product:products[index] ,index: nameindex,)));
                               }
                        },
                              child: ItemBox(
                                index: index,
                                width: 150,
                                height: 230,
                                image: products[index].image,
                                offsetx: offsetsx[index],
                                offsety: offsetsy[index],
                                onTap: () {
                                  if(CartProducts.contains(products[index])&&CartProductNames.contains(CoffeeNames[nameindex])){
                                    int l=CartProducts.indexOf(products[index]);
                                    int k=CartProductNames.indexOf(CoffeeNames[nameindex]);
                                    products[index].type=CartProductNames[k];
                                    Toast.show("Item Added to Cart",duration: 2);
                                    CartProducts[l].count++;
                                  }
                                  else{
                                    Toast.show("Item Added to Cart",duration: 2);
                                    CartProducts.add(products[index]);
                                    CartProductNames.add(CoffeeNames[nameindex]);
                                  }


                                },
                                name: products[index].name,
                                price: products[index].price,
                                rate: products[index].rate,
                                type: products[index].type,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Color(0xff22151F),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/images/Home.svg",
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CartScreen(products: CartProducts,productstype: CartProductNames,)));
                      },
                      icon: SvgPicture.asset(
                        "assets/images/Cart.svg",
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/images/Heart.svg",
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/images/Notification.svg",
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }



  Widget ItemBox(
      {required String name,
      required String price,
      required String image,
      required VoidCallback onTap,
      required String rate,
        required double width,
        required double height,
        required int index,
        required double offsetx,
        required double offsety,
        required String type
      }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
    transform: Matrix4.translationValues(offsetx, offsety, 0),
      width:width,
      height:height,
      decoration: BoxDecoration(
          color: Color(0xff362C36), borderRadius: BorderRadius.circular(10)),
      child:
      Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage("$image"),
                      fit: BoxFit.fill,
                      height: 110,
                      width: 120,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    width: 45,
                    height: 20,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.grey.withOpacity(0.7),
                              Colors.transparent.withOpacity(0.2)
                            ],
                            stops: [
                              10.10,
                              0.10
                            ]),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Icon(
                            Icons.star,
                            color: Colors.yellowAccent,
                            size: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            "$rate",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "$name",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: 111,
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xff463D46),
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: Text(
                        "\$ $price",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: onTap,
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
                    )
                  ],
                ),
              ),
            )
          ],
        ),

    );
  }
  Widget EmptyBox() {
    return Container(
        width:150,
        height: 230,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Box.png"),
            fit: BoxFit.fill,
          ),
        ));
  }
}

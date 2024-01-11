import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  Color color = Colors.black;
  late String text;
  double size = 13.0;
  FontWeight weight = FontWeight.normal;
  Text _text(text, color, size, weight) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(96, 136, 202, 1),
        title: _text("Thêm sản phẩm", Colors.white, 20.0, FontWeight.bold),
        leading: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.black,
                ),
                onPressed: () {
                  // do something
                },
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.manage_search_rounded,
              color: Colors.white,
              size: 40,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              color: Color.fromRGBO(208, 211, 240, 1),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo,
                          size: 30,
                        ),
                        _text("  Hình ảnh", color, 25.0, FontWeight.bold),
                      ],
                    ),
                  ),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: Container(
                        alignment: Alignment.center,
                        width: 250,
                        height: 175,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(248, 243, 232, 1),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black38,
                                offset: Offset(0, 0),
                                blurRadius: 10.0,
                              ),
                            ],
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: IconButton(
                            onPressed: () {},
                            icon: FaIcon(
                              FontAwesomeIcons.plus,
                              size: 40,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            //Sản Phẩm
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 5),
              width: 360,
              height: 50,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(4, 6),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nhập Tên Sản Phẩm';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(208, 211, 240, 1),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: FaIcon(
                      FontAwesomeIcons.boxesStacked,
                      color: Colors.black,
                    ),
                  ),
                  label: Center(child: const Text('Tên Sản Phẩm')),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                  hintText: 'Nhập Tên Sản Phẩm',
                  hintStyle: const TextStyle(
                    color: Colors.black26,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(96, 136, 202, 1),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(96, 136, 202, 1),
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            //Số lượng
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 5),
              width: 360,
              height: 50,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(4, 6),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nhập Số Lượng';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(208, 211, 240, 1),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: FaIcon(
                      FontAwesomeIcons.cube,
                      color: Colors.black,
                    ),
                  ),
                  label: Center(child: const Text('Số lượng')),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                  hintText: 'Nhập Số Lượng',
                  hintStyle: const TextStyle(
                    color: Colors.black26,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(96, 136, 202, 1),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(96, 136, 202, 1),
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            //Đơn giá
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 5),
              width: 360,
              height: 50,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(4, 6),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nhập Đơn giá';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(208, 211, 240, 1),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: FaIcon(
                      FontAwesomeIcons.dollarSign,
                      color: Colors.black,
                    ),
                  ),
                  label: Center(child: const Text('Đơn Giá')),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                  hintText: 'Nhập Đơn Giá',
                  hintStyle: const TextStyle(
                    color: Colors.black26,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(96, 136, 202, 1),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(96, 136, 202, 1),
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            //Loại Sản Phẩm
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 5),
              width: 360,
              height: 50,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(4, 6),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nhập Loại Sản Phẩm';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(208, 211, 240, 1),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: FaIcon(
                      FontAwesomeIcons.folder,
                      color: Colors.black,
                    ),
                  ),
                  label: Center(child: const Text('Loại Sản Phẩm')),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                  hintText: 'Nhập Loại Sản Phẩm',
                  hintStyle: const TextStyle(
                    color: Colors.black26,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(96, 136, 202, 1),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(96, 136, 202, 1),
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            //Giá Khuyến Mãi
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 5),
              width: 360,
              height: 50,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(4, 6),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nhập giá khuyến mãi';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(208, 211, 240, 1),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: FaIcon(
                      FontAwesomeIcons.noteSticky,
                      color: Colors.black,
                    ),
                  ),
                  label: Center(child: const Text('Giá Khuyến Mãi')),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                  hintText: 'Nhập giá khuyến mãi',
                  hintStyle: const TextStyle(
                    color: Colors.black26,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(96, 136, 202, 1),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(96, 136, 202, 1),
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: 380,
              height: 150,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 233, 233, 1),
                  borderRadius: BorderRadius.circular(30)),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Nhập mô tả ......',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(208, 211, 240, 1),
                    border: Border.all(
                      color: Color.fromRGBO(96, 136, 202, 1),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _text("Lưu", Color.fromRGBO(96, 136, 202, 1),
                            20.0, FontWeight.bold),
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.add,
                          color: Colors.black,
                        ),
                        onPressed: (() {}),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

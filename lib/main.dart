import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../widgets/product_card.dart';
import '../widgets/category_card.dart';

void main() {
  runApp(TestAapp());
}

class TestAapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  List? categories;

  String searchTerm = '';

  List json = [
    {"id": 1, "parentId": 2, "picture": "https://image.shutterstock.com/z/stock-photo-red-kitchen-stand-food-mixer-on-a-white-background-d-rendering-678892978.jpg", "name": "Hamur Yoğurucu"},
    {"id": 2, "parentId": null, "picture": "https://image.shutterstock.com/shutterstock/photos/636867466/display_1500/stock-photo--d-render-image-set-of-home-appliances-on-white-background-636867466.jpg", "name": "Mutfak Aletleri"},
    {"id": 3, "parentId": 2, "picture": "https://image.shutterstock.com/z/stock-photo-metal-electric-kettle-564327403.jpg", "name": "Kettle"},
    {"id": 4, "parentId": null, "picture": "https://image.shutterstock.com/image-illustration/home-appliances-group-white-refrigerator-600w-572500789.jpg", "name": "Beyaz Eşya"},
    {"id": 5, "parentId": 8, "picture": "https://image.shutterstock.com/shutterstock/photos/1713062818/display_1500/stock-photo-classic-armchair-art-deco-style-in-purple-velvet-with-wooden-legs-isolated-on-white-background-1713062818.jpg", "name": "Koltuk"},
    {"id": 6, "parentId": 4, "picture": "https://image.shutterstock.com/z/stock-photo-modern-silver-washing-machine-isolated-on-white-background-199882085.jpg", "name": "Çamaşır Makinesi"},
    {"id": 7, "parentId": 2, "picture": "https://image.shutterstock.com/z/stock-photo-red-electric-blender-d-rendering-isolated-on-white-background-702502408.jpg", "name": "Blender"},
    {"id": 8, "parentId": null, "picture": "https://image.shutterstock.com/z/stock-photo-interior-of-the-living-room-d-illustration-1899674929.jpg", "name": "Mobilya"},
    {"id": 9, "parentId": 12, "picture": "https://image.shutterstock.com/z/stock-photo-studio-shot-of-a-wheelbarrow-full-of-dirt-isolated-on-white-background-417857257.jpg", "name": "El Arabası"},
    {"id": 10, "parentId": 2, "picture": "https://image.shutterstock.com/z/stock-photo-closeup-of-a-black-hand-blender-on-a-white-background-702833776.jpg", "name": "El Blender"},
    {"id": 11, "parentId": null, "picture": "https://image.shutterstock.com/z/stock-photo-modern-student-home-with-diy-furniture-and-colorful-decorations-503193214.jpg", "name": "Ev Dekorasyon"},
    {"id": 12, "parentId": null, "picture": "https://image.shutterstock.com/z/stock-photo-essential-realistic-gardening-tools-colorful-set-isolated-on-white-445805392.jpg", "name": "Bahçe Aletleri"},
    {"id": 13, "parentId": 2, "picture": "https://image.shutterstock.com/z/stock-photo-electric-hand-mixer-is-a-kitchen-appliance-intended-for-mixing-isolated-on-white-background-1254771280.jpg", "name": "Mikser"},
    {"id": 14, "parentId": 4, "picture": "https://image.shutterstock.com/z/stock-photo-image-of-the-microwave-oven-on-a-white-background-83809138.jpg", "name": "Mikrodalga Fırın"},
    {"id": 15, "parentId": 12, "picture": "https://image.shutterstock.com/z/stock-photo-garden-shovel-isolated-on-white-background-616690754.jpg", "name": "Bahçe Küreği"},
    {"id": 16, "parentId": 8, "picture": "https://image.shutterstock.com/z/stock-photo-place-setting-in-an-expensive-haute-cuisine-restaurant-97121126.jpg", "name": "Yemek Masası"},
    {"id": 17, "parentId": 11, "picture": "https://image.shutterstock.com/z/stock-vector-old-antique-wall-clock-198638246.jpg", "name": "Duvar Saati"},
    {"id": 18, "parentId": 12, "picture": "https://image.shutterstock.com/shutterstock/photos/1279154596/display_1500/stock-vector-garden-rake-icon-sketch-style-illustration-of-garden-tools-1279154596.jpg", "name": "Tırmık"},
    {"id": 19, "parentId": 4, "picture": "https://image.shutterstock.com/z/stock-photo-top-mount-fridge-isolated-on-white-background-side-view-of-stainless-steel-double-door-1306270882.jpg", "name": "Buzdolabı"},
    {"id": 20, "parentId": 12, "picture": "https://image.shutterstock.com/image-photo/watering-can-600w-476991820.jpg", "name": "Sulama Kabı"},
    {"id": 21, "parentId": 11, "picture": "https://image.shutterstock.com/z/stock-photo-sitting-black-monkey-bibelot-on-the-white-background-thinking-monkey-1921966451.jpg", "name": "Biblo"},
    {"id": 22, "parentId": 11, "picture": "https://image.shutterstock.com/z/stock-photo-home-deco-indoor-with-candle-holder-and-light-bulbs-cozy-blanket-and-faux-fur-cozy-winter-interior-747191389.jpg", "name": "Mumluk"},
    {"id": 23, "parentId": 8, "picture": "https://image.shutterstock.com/z/stock-photo-interior-walk-in-closet-simple-classic-style-d-rendering-d-illustration-1097501066.jpg", "name": "Dolap"},
    {"id": 24, "parentId": 11, "picture": "https://image.shutterstock.com/z/stock-photo-chinese-antique-vase-on-the-plain-back-ground-374237656.jpg", "name": "Vazo"},
    {"id": 25, "parentId": 8, "picture": "https://image.shutterstock.com/z/stock-photo-modern-coffee-table-520100755.jpg", "name": "Sehpa"},
    {"id": 26, "parentId": 8, "picture": "https://image.shutterstock.com/z/stock-photo-cabinet-in-modern-empty-room-minimal-design-d-rendering-1935946810.jpg", "name": "TV Ünitesi"}
  ];

  @override
  void initState() {
    super.initState();
    categories = json.where((element) => element['parentId'] == null).toList();
  }

  Widget blueArea() {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * .35,
          color: Colors.blue,
        ),
      ],
    );
  }

  Widget textField() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * .1,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 5),
                  width: 20,
                  height: 25,
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          searchTerm = value;
                        });
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Ara...',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      textCapitalization: TextCapitalization.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget categoryCards() {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .25,
      ),
      child: Container(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories!.length,
          itemBuilder: (context, index) => CategoryCard(
            categoryData: categories![index],
            onTap: () {
              itemScrollController.scrollTo(
                index: index,
                duration: Duration(seconds: 2),
                curve: Curves.easeInOutCubic,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget productList() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .45 + 20,
      ),
      child: ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemCount: categories!.length,
        itemBuilder: (context, index) {
          String categoryName = categories![index]['name'];
          List products = json.where((element) => element['parentId'] != null && element['parentId'] == categories![index]['id']).toList();

          if (searchTerm != '') {
            products = products.where((element) => (element['name'] as String).toLowerCase().contains(searchTerm.toLowerCase())).toList();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 5, left: 20),
                child: Text(
                  categoryName,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              for (var i = 0; i < products.length; i++)
                ProductCard(
                  productData: products[i],
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
        },
        child: Stack(
          children: <Widget>[
            blueArea(),
            textField(),
            categoryCards(),
            productList(),
          ],
        ),
      ),
    );
  }
}

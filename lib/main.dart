import 'package:flutter/material.dart';

void main() {
  runApp(FoodCustomizationApp());
}

class FoodCustomizationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Customization Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<FoodItem> foodItems = [
    FoodItem(
      name: 'Aloo Paratha',
      image: 'assets/download1.png',
      ingredients: [
        'Potato roasted',
        'Potato boiled',
        'Onion',
        'Green Chili',
        'Coriander',
        'Garlic'
      ],
    ),
    FoodItem(
      name: 'Pizza',
      image: 'assets/download2.png',
      ingredients: [
        'Cheese',
        'Chicken',
        'Paneer',
        'Tomato',
        'Mushrooms',
        'Pepperoni',
        'Olives'
      ],
    ),
    FoodItem(
      name: 'Burger',
      image: 'assets/images3.png',
      ingredients: [
        'Aloo Patty',
        'Chicken Patty',
        'Tomato',
        'Onion',
        'Pickles'
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zomato Home Page'),
      ),
      body: ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodCustomizationPage(foodItems[index]),
                ),
              );
            },
            child: Card(
              child: ListTile(
                title: Text(foodItems[index].name),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(foodItems[index].image),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FoodCustomizationPage extends StatefulWidget {
  final FoodItem foodItem;

  FoodCustomizationPage(this.foodItem);

  @override
  _FoodCustomizationPageState createState() => _FoodCustomizationPageState();
}

class _FoodCustomizationPageState extends State<FoodCustomizationPage> {
  List<String> selectedIngredients = [];

  void toggleIngredient(String ingredient) {
    setState(() {
      if (selectedIngredients.contains(ingredient)) {
        selectedIngredients.remove(ingredient);
      } else {
        selectedIngredients.add(ingredient);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.foodItem.name} Customization'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(widget.foodItem.name),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(widget.foodItem.image),
                  ),
                  subtitle: Text('Selected Food Item'),
                  trailing: Icon(Icons.restaurant_menu),
                ),
                ListTile(
                  title: Text('Additional Ingredients'),
                  subtitle: Text('Select ingredients to add or remove:'),
                ),
                for (String ingredient in widget.foodItem.ingredients)
                  CheckboxListTile(
                    title: Text(ingredient),
                    value: selectedIngredients.contains(ingredient),
                    onChanged: (value) => toggleIngredient(ingredient),
                  ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PaymentPage(widget.foodItem, selectedIngredients),
                ),
              );
            },
            child: Text('Proceed to Payment'),
          ),
        ],
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  final FoodItem foodItem;
  final List<String> selectedIngredients;

  PaymentPage(this.foodItem, this.selectedIngredients);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadioListTile(
              title: Text('Paytm'),
              value: 'Paytm',
              groupValue: selectedPaymentOption,
              onChanged: (value) {
                setState(() {
                  selectedPaymentOption = value as String?;
                });
              },
            ),
            RadioListTile(
              title: Text('PhonePe'),
              value: 'PhonePe',
              groupValue: selectedPaymentOption,
              onChanged: (value) {
                setState(() {
                  selectedPaymentOption = value as String?;
                });
              },
            ),
            RadioListTile(
              title: Text('Card'),
              value: 'Card',
              groupValue: selectedPaymentOption,
              onChanged: (value) {
                setState(() {
                  selectedPaymentOption = value as String?;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedPaymentOption != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderPlacementPage(
                          widget.foodItem, widget.selectedIngredients),
                    ),
                  );
                } else {
                  // Show error message or handle accordingly
                }
              },
              child: Text('Complete Payment'),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderPlacementPage extends StatelessWidget {
  final FoodItem foodItem;
  final List<String> selectedIngredients;

  OrderPlacementPage(this.foodItem, this.selectedIngredients);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Order Placed!', style: TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodItem {
  final String name;
  final String image;
  final List<String> ingredients;

  FoodItem(
      {required this.name, required this.image, required this.ingredients});
}

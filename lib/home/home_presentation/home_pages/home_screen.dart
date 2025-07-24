import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fedis_mockup_demo/themes/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String userName = "User"; // Default

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  /// Load user name from SharedPreferences
  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('userName') ?? "User";
    print("🔍 Loaded User Name: $name");
    setState(() {
      userName = name;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double topMargin = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      // ✅ Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.outlineVariant,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: topMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 10),
            const CustomText(hint: "Search Your Food or Restaurant"),
            const SizedBox(height: 15),
            _buildPromoBanner(context),
            const SizedBox(height: 20),
            _buildSectionHeader(context, "Categories"),
            const SizedBox(height: 5),
            _buildCategories(),
            const SizedBox(height: 10),
            _buildSectionHeader(context, "Restaurant"),
            Expanded(child: _buildRestaurantList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Hi, $userName!",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: lightColorScheme.shadow,
              ),
            ),
            Icon(Icons.notifications,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.location_pin, color: Theme.of(context).colorScheme.onSurface),
            const SizedBox(width: 8),
            Text("Location, New Cairo",
              style: TextStyle(color: Theme.of(context).colorScheme.outlineVariant),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPromoBanner(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset("assets/images/burger.png")),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Get Special Discount",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: lightColorScheme.outlineVariant,
                ),
              ),
              const SizedBox(height: 25),
              Text("up to 75%",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: lightColorScheme.background),
              ),
              const SizedBox(height: 40),
              const CardButton()
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        separatorBuilder: (context, index) => const SizedBox(width: 25),
        itemBuilder: (context, index) => const CategoryCircle(title: "Pizza"),
      ),
    );
  }

  Widget _buildRestaurantList() {
    return ListView.separated(
      itemBuilder: (context, index) => const FoodItemWidget(),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: 5,
      scrollDirection: Axis.vertical,
    );
  }

  Padding _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: lightColorScheme.shadow,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Text("Show all",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: lightColorScheme.secondary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Supporting Widgets remain unchanged
class FoodItemWidget extends StatelessWidget {
  const FoodItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 2,
        color: lightColorScheme.onPrimary,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: lightColorScheme.onPrimary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/BK.jpeg",
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Burger King",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Row(
                    children: const [
                      Icon(Icons.star_rate, color: Colors.yellowAccent, size: 16),
                      SizedBox(width: 4),
                      Text("5.0"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.timer, color: lightColorScheme.outlineVariant, size: 16),
                      Text("20-25 mins  • 7 km")
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCircle extends StatelessWidget {
  const CategoryCircle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(color: lightColorScheme.shadow,
              shape: BoxShape.circle,
              image: const DecorationImage(
                  image: AssetImage("assets/images/pizza.jpeg"),
                  fit: BoxFit.cover)
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: lightColorScheme.shadow,
          ),
        ),
      ],
    );
  }
}

class CardButton extends StatelessWidget {
  const CardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child: Text(
          "Claim Voucher",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: lightColorScheme.shadow,
          ),
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({super.key, this.hint});
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.outlineVariant,
            offset: Offset(0, 0),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.onPrimary,
          hintText: hint,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}

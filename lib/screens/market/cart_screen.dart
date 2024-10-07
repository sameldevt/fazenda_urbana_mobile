import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/service/cart_service.dart';
import 'package:verdeviva/service/user_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();
  final Set<ProductToCart> _products = {};

  Future<void> _loadProducts() async {
    Set<ProductToCart> products = await _cartService.getProducts();
    setState(() {
      _products.addAll(products);
    });
  }

  void onChanged(ProductToCart product, String change) {
    setState(() {
      switch (change) {
        case 'remove':
          _cartService.removeProduct(product.id);
          _products.remove(product);
          break;
        case 'update':
          _products.remove(product);
          _products.add(product);
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //_cartService.clearCart();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Carrinho',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: _products.isEmpty
          ? const _EmptyCartWidget()
          : Padding(
              padding: const EdgeInsets.all(appPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _Header(),
                  _CartItemsSection(
                    products: _products,
                    onChanged: onChanged,
                  ),
                  _ContinuePurchaseSection(
                      products: _products, onChanged: onChanged),
                ],
              ),
            ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Produtos',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _CartItemsSection extends StatefulWidget {
  final Set<ProductToCart> products;
  final Function(ProductToCart product, String change) onChanged;

  const _CartItemsSection({required this.products, required this.onChanged});

  @override
  State<_CartItemsSection> createState() => _CartItemsSectionState();
}

class _CartItemsSectionState extends State<_CartItemsSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.60,
            child: ListView.separated(
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                // Converte o Set em uma lista
                var productList = widget.products.toList();
                var product = productList[index]; // Acesse pelo índice
                return _CartItemCard(
                  product: product,
                  onChanged: widget.onChanged,
                );
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: 0.5,
                indent: 10.0,
                endIndent: 10.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItemCard extends StatefulWidget {
  final ProductToCart product;
  final Function(ProductToCart product, String change) onChanged;

  const _CartItemCard({required this.product, required this.onChanged});

  @override
  State<_CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<_CartItemCard> {
  final List<int> _quantities = [
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900,
    1,
    2,
    3,
    4,
    5
  ];
  int _selectedQuantity = 0;

  void _updateItemPrice(ProductToCart product, int selectedQuantity) {
    product.totalPrice = selectedQuantity > 5
        ? product.basePrice * (selectedQuantity / 1000)
        : product.basePrice * selectedQuantity;

    widget.onChanged(product, 'update');
  }

  void _removeProduct(ProductToCart product) {
    widget.onChanged(product, 'remove');
  }

  @override
  Widget build(BuildContext context) {
    _selectedQuantity = widget.product.quantity;

    return Card(
      color: Colors.white,
      elevation: 0.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            widget.product.imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.scaleDown,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Container(
                width: 100,
                height: 100,
                color: Colors.transparent,
              );
            },
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis, // Evita overflow de texto
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quantidade',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<int>(
                      value: _selectedQuantity,
                      onChanged: (int? newValue) {
                        _selectedQuantity = newValue!;
                        widget.product.quantity = _selectedQuantity;
                        _updateItemPrice(widget.product, _selectedQuantity);
                      },
                      items:
                          _quantities.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(
                            '${value.toString()} ${value < 100 ? 'kg' : 'g'}',
                          ),
                        );
                      }).toList(),
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 40,
                ),
                onPressed: () {
                  _removeProduct(widget.product);
                },
              ),
              Text(
                'R\$ ${widget.product.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContinuePurchaseSection extends StatefulWidget {
  final Set<ProductToCart> products;
  final Function(ProductToCart product, String change) onChanged;

  const _ContinuePurchaseSection(
      {required this.products, required this.onChanged});

  @override
  State<_ContinuePurchaseSection> createState() =>
      _ContinuePurchaseSectionState();
}

class _ContinuePurchaseSectionState extends State<_ContinuePurchaseSection> {
  String calculateTotalPrice() {
    double total = widget.products
        .fold(0.0, (total, product) => total + product.totalPrice);

    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Produtos (${widget.products.length})',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                'R\$ ${calculateTotalPrice()}',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'R\$ ${calculateTotalPrice()}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  String route = '';
                  User.fromSharedPreferences().then((value) {
                    value == null
                        ? Navigator.pushNamed(context, 'not-logged')
                        : Navigator.pushNamed(context, 'address');
                  });
                },
                child: const ActionPrimaryButton(
                  buttonText: "Continuar a compra",
                  buttonTextSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCartWidget extends StatelessWidget {
  const _EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.06; // 5% do tamanho da altura

    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: verticalPadding,
            ),
            Container(
              child: Column(
                children: [
                  Image.asset(
                    'assets/empty-cart.png',
                    height: 400,
                    width: 400,
                  ),
                  const Text(
                    "Seu carrinho está vazío!",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 39,
                  ),
                  SizedBox(
                    height: verticalPadding,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'home');
                    },
                    child: const ActionPrimaryButton(
                        buttonText: "Buscar produtos", buttonTextSize: 18),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

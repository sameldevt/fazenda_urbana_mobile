import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/screens/market/product_info_screen.dart';
import 'package:verdeviva/screens/market/widgets/product_card.dart';
import 'package:verdeviva/service/cart_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();
  final List<ProductToCart> _products = [];

  Future<void> _loadProducts() async {
    List<ProductToCart> products = await _cartService.getProducts();
    setState(() {
      _products.addAll(products);
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
      body: Padding(
        padding: const EdgeInsets.all(appPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _Header(),
            _CartItemsSection(products: _products,),
            _ContinuePurchaseSection(products: _products,),
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
  final List<ProductToCart> products;

  const _CartItemsSection({required this.products});

  @override
  State<_CartItemsSection> createState() => _CartItemsSectionState();
}

class _CartItemsSectionState extends State<_CartItemsSection> {
  final CartService _cartService = CartService();

  void _removeProduct(ProductToCart product) {
    setState(() {
      _cartService.removeProduct(product.id);
      widget.products.remove(product);
    });
  }

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
                final product = widget.products[index];
                return _CartItemCard(
                    product: product,
                    onDelete: _removeProduct,
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
  final Function(ProductToCart) onDelete;

  const _CartItemCard({required this.product, required this.onDelete});

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

  void updateItemPrice(ProductToCart product, int selectedQuantity){
    product.totalPrice = selectedQuantity > 5
        ? product.basePrice * (selectedQuantity / 1000)
        : product.basePrice * selectedQuantity;
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
                        setState(() {
                          _selectedQuantity = newValue!;
                          widget.product.quantity = _selectedQuantity;
                          updateItemPrice(widget.product, _selectedQuantity);
                        });
                      },
                      items:
                          _quantities.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text( '${value.toString()} ${value < 100
                              ? 'kg'
                              : 'g'}',),
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
                  setState(() {
                    widget.onDelete(widget.product);
                  });
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
  final List<ProductToCart> products;
  const _ContinuePurchaseSection({required this.products});

  @override
  State<_ContinuePurchaseSection> createState() =>
      _ContinuePurchaseSectionState();
}

class _ContinuePurchaseSectionState extends State<_ContinuePurchaseSection> {
  String calculateTotalPrice(){
    double total = widget.products.fold(0.0, (total, product) => total + product.totalPrice);

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
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                'R\$ ${calculateTotalPrice()}',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'R\$ ${calculateTotalPrice()}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Center(
              child: NavigationPrimaryButton(
                route: 'address',
                buttonText: 'Continuar a compra',
                buttonTextSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/providers/cart_provider.dart';
import 'package:verdeviva/service/cart_service.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/screens/market/widgets/product_card.dart';
import 'package:verdeviva/service/product_service.dart';

class ProductInfoScreen extends StatefulWidget {
  final Product product;

  const ProductInfoScreen({super.key, required this.product});

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;
    final productToCart = new ProductToCart();

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Detalhes',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(appPadding),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _Header(product: widget.product),
                      const SizedBox(
                        height: 8,
                      ),
                      _ProductPriceSection(
                          product: widget.product, productToCart: productToCart),
                      const SizedBox(
                        height: 16,
                      ),
                      _Buttons(
                        productToCart: productToCart,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const _SeeTooSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final Product product;

  const _Header({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final questionMarkColor = theme.colorScheme.primary.withOpacity(0.5);

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            product.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Image.network(
            product.imageUrl,
            width: 300,
            height: 300,
            fit: BoxFit.scaleDown,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Container(
                width: 300,
                height: 300,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/sad-face-2.png", height: 150, width: 150, color: questionMarkColor,),
                    const SizedBox(height: 30,),
                    Text("Imagem indisponível", style: TextStyle(color: questionMarkColor, fontSize: 30),),
                    //Icon(Icons.question_mark_rounded, size: 80, color: questionMarkColor,),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ProductPriceSection extends StatefulWidget {
  final Product product;
  final ProductToCart productToCart;

  const _ProductPriceSection({required this.product, required this.productToCart});

  @override
  State<_ProductPriceSection> createState() => _ProductPriceSectionState();
}

class _ProductPriceSectionState extends State<_ProductPriceSection> {
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

  int _selectedQuantity = 1;
  double itemPrice = 0;

  void updateProductToCart(){
    widget.productToCart.id = widget.product.id;
    widget.productToCart.name = widget.product.name;
    widget.productToCart.description = widget.product.description;
    widget.productToCart.basePrice = widget.product.pricePerKilo;
    widget.productToCart.totalPrice = itemPrice;
    widget.productToCart.quantity = _selectedQuantity;
    widget.productToCart.imageUrl = widget.product.imageUrl;
  }

  void updateItemPrice(Product product, int selectedQuantity){
    itemPrice = _selectedQuantity > 5
        ? widget.product.pricePerKilo * (_selectedQuantity / 1000)
        : widget.product.pricePerKilo * _selectedQuantity;
  }

  @override
  Widget build(BuildContext context) {
    updateItemPrice(widget.product, _selectedQuantity);
    updateProductToCart();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'R\$ ${itemPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'em 3x R\$ ${(itemPrice / 3).toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: 379,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.0),
                      ),
                    ),
                    showDragHandle: true,
                    builder: (BuildContext context) {
                      return Container(
                        height: 300,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Escolha uma opção',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Expanded(
                              child: ListView.separated(
                                itemCount: _quantities.length,
                                itemBuilder: (BuildContext context, int index) {
                                  int value = _quantities[index];
                                  return ListTile(
                                    title: Center(
                                      child: Text(
                                        '${value.toString()} ${value < 100
                                            ? 'kg'
                                            : 'g'}',
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _selectedQuantity = value;
                                        updateItemPrice(widget.product, _selectedQuantity);
                                      });

                                      Navigator.pop(context);
                                    },
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider(
                                    color: Colors.grey,
                                    thickness: 0.5,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quantidade: ${_selectedQuantity < 100
                          ? ' ${_selectedQuantity.toString()} kg'
                          : ' ${_selectedQuantity.toString()} g'}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Icon(Icons.arrow_forward_ios,
                        color: Colors.lightGreen),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class _Buttons extends StatefulWidget {
  final ProductToCart productToCart;

  const _Buttons({required this.productToCart});

  @override
  State<_Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<_Buttons> {
  final CartService _cartService = CartService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: InkWell(
            onTap: () {
              Provider.of<CartProvider>(context, listen: false).addProduct(widget.productToCart);
              Navigator.pushNamed(context, 'cart');
            },
            child: const ActionPrimaryButton(
              buttonText: 'Comprar agora',
              buttonTextSize: 20,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Center(
          child: InkWell(
            onTap: () {
              Provider.of<CartProvider>(context, listen: false).addProduct(widget.productToCart);
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                ),
                showDragHandle: true,
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 220,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  // Define a borda circular
                                  border: Border.all(
                                    color: Colors.green, // Cor da borda
                                    width: 3.0, // Largura da borda
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    widget.productToCart.imageUrl,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.transparent,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: 260,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Item adicionado!',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.productToCart.name,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      widget.productToCart.description,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      'R\$ ${widget.productToCart.totalPrice.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, 'cart');
                                  },
                                  child: const ActionPrimaryButton(
                                    buttonText: 'Ir para o carrinho',
                                    buttonTextSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const ActionSecondaryButton(
                                    buttonText: 'Continuar comprando',
                                    buttonTextSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: const ActionSecondaryButton(
              buttonText: 'Adicionar ao carrinho',
              buttonTextSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

class _SeeTooSection extends StatefulWidget {
  const _SeeTooSection();

  @override
  State<_SeeTooSection> createState() => _SeeTooSectionState();
}

class _SeeTooSectionState extends State<_SeeTooSection> {
  final ProductService _productService = ProductService();
  final List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _productService.getAll().then((result) {
      setState(() {
        _products.addAll(result);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Veja também',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 240,
            viewportFraction: 0.6,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            initialPage: 0,
            animateToClosest: true,
            scrollDirection: Axis.horizontal,
          ),
          items: _products.map((product) {
            return Builder(
              builder: (BuildContext context) {
                return ProductCard(
                  product: product,
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

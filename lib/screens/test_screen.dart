import 'package:flutter/material.dart';
import 'package:verdeviva/screens/access/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final List<Map<String, String>> products = [
    {
      "name": "Banana",
      "price": "7.99",
      "image": "https://rb.gy/2xfabn",
      "description": "Banana madura e doce, ideal para lanches e smoothies."
    },
    {
      "name": "Maçã",
      "price": "6.49",
      "image": "https://rb.gy/8ly4oc",
      "description":
          "Maçã crocante e suculenta, perfeita para uma alimentação saudável."
    },
    {
      "name": "Couve",
      "price": "5.99",
      "image": "https://rb.gy/s2fpd2",
      "description":
          "Couve fresca, rica em nutrientes e ideal para sucos verdes."
    },
    {
      "name": "Cenoura",
      "price": "4.99",
      "image": "https://rb.gy/0fiy0z",
      "description":
          "Cenoura crocante e adocicada, ótima para saladas e petiscos."
    },
    {
      "name": "Batata",
      "price": "3.99",
      "image": "https://rb.gy/2ot2ch",
      "description": "Batata versátil, ideal para fritar, assar ou cozinhar."
    },
    {
      "name": "Batata doce",
      "price": "4.49",
      "image": "https://t.ly/obCYL",
      "description":
          "Batata doce nutritiva e adocicada, excelente para receitas saudáveis."
    },
    {
      "name": "Beterraba",
      "price": "5.49",
      "image": "https://t.ly/-YCSe",
      "description": "Beterraba rica em ferro, ótima para saladas e sucos."
    },
    {
      "name": "Manga",
      "price": "6.99",
      "image": "https://t.ly/WGNKn",
      "description": "Manga suculenta e doce, perfeita para sobremesas e sucos."
    },
    {
      "name": "Alface",
      "price": "4.49",
      "image": "https://t.ly/kGI0v",
      "description": "Alface fresca e crocante, ideal para saladas."
    },
    {
      "name": "Pêra",
      "price": "7.49",
      "image": "https://t.ly/QM99N",
      "description": "Pêra doce e suculenta, ótima para lanches e sobremesas."
    },
    {
      "name": "Laranja",
      "price": "5.99",
      "image": "https://l1nq.com/nmBNt",
      "description":
          "Laranja refrescante e rica em vitamina C, perfeita para sucos."
    },
    {
      "name": "Alho",
      "price": "1.99",
      "image": "https://l1nq.com/7cqrk",
      "description":
          "Alho aromático e saboroso, essencial para temperar pratos."
    },
    {
      "name": "Cebola",
      "price": "6,49",
      "image": "https://l1nq.com/f4Mkz",
      "description":
          "Cebola versátil e essencial na cozinha, ideal para diversos pratos."
    },
    {
      "name": "Tomate",
      "price": "7.49",
      "image": "https://encurtador.com.br/kAgBR",
      "description":
          "Tomate maduro e suculento, excelente para saladas e molhos."
    },
    {
      "name": "Salsa",
      "price": "3.99",
      "image": "https://encurtador.com.br/LbyRY",
      "description":
          "Salsa fresca e aromática, ideal para temperar e enfeitar pratos."
    }
  ];

  int onSelected(int value) {
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background = theme.colorScheme.surface;
    final appBarColor = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: background,
      body: ApiTestScreen(),
    );
  }
}

class ApiTestScreen extends StatefulWidget {
  @override
  _ApiTestScreenState createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  String _response = '';

  // Função para fazer requisições GET
  Future<void> _makeGetRequest() async {
    final response = await http.get(Uri.parse('http://18.191.183.78:8080/verdeviva/cliente/buscar-todos'));
    setState(() {
      _response = response.body;
    });
  }

  // Função para fazer requisições POST
  Future<void> _makePostRequest() async {
    final response = await http.post(
      Uri.parse('https://suaapi.com/post-endpoint'),
      body: {'key': 'value'},
    );
    setState(() {
      _response = response.body;
    });
  }

  // Função para fazer requisições PUT
  Future<void> _makePutRequest() async {
    final response = await http.put(
      Uri.parse('https://suaapi.com/put-endpoint'),
      body: {'key': 'updatedValue'},
    );
    setState(() {
      _response = response.body;
    });
  }

  // Função para fazer requisições DELETE
  Future<void> _makeDeleteRequest() async {
    final response = await http.delete(Uri.parse('https://suaapi.com/delete-endpoint'));
    setState(() {
      _response = response.body;
    });
  }

  // Função para fazer requisições PATCH
  Future<void> _makePatchRequest() async {
    final response = await http.patch(
      Uri.parse('https://suaapi.com/patch-endpoint'),
      body: {'key': 'patchedValue'},
    );
    setState(() {
      _response = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('API Tester'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _makeGetRequest,
              child: Text('GET Request'),
            ),
            ElevatedButton(
              onPressed: _makePostRequest,
              child: Text('POST Request'),
            ),
            ElevatedButton(
              onPressed: _makePutRequest,
              child: Text('PUT Request'),
            ),
            ElevatedButton(
              onPressed: _makeDeleteRequest,
              child: Text('DELETE Request'),
            ),
            ElevatedButton(
              onPressed: _makePatchRequest,
              child: Text('PATCH Request'),
            ),
            SizedBox(height: 20),
            Text(
              'Response:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_response),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


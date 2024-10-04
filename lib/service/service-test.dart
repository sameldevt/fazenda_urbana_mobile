import 'package:http/http.dart' as http;
import 'dart:convert';

void fetchData() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

  // Fazendo a requisição GET
  final response = await http.get(url);

  // Verifica se a resposta foi bem-sucedida
  if (response.statusCode == 200) {
    // Decodifica o JSON
    final List<dynamic> data = jsonDecode(response.body);
    print('Data recebida: $data');
  } else {
    print('Erro na requisição: ${response.statusCode}');
  }
}

void postData() async {
  final url = Uri.parse('https://localhost:7016/verdeviva/gestao/produtos/listar-todos');

  final Map<String, dynamic> body = {
    'title': 'foo',
    'body': 'bar',
    'userId': 1,
  };

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode(body),
  );

  // Verifica se a requisição foi bem-sucedida
  if (response.statusCode == 201) {
    final data = jsonDecode(response.body);
    print('Data enviada com sucesso: $data');
  } else {
    print('Erro ao enviar dados: ${response.statusCode}');
  }
}
// category_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'catalog_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Map<String, List<String>> categoriasPorGrupo = {};
  String? tipoSeleccionado;

  @override
  void initState() {
    super.initState();
    _cargarCategorias();
  }

  Future<void> _cargarCategorias() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('categoria').get();
    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      final Map<String, List<String>> temp = {};
      data.forEach((key, value) {
        if (value is List) temp[key] = List<String>.from(value);
      });
      setState(() => categoriasPorGrupo = temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tipos = categoriasPorGrupo.keys.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child:
            tipoSeleccionado == null
                ? GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children:
                      tipos.map((tipo) {
                        return ElevatedButton(
                          onPressed:
                              () => setState(() => tipoSeleccionado = tipo),
                          child: Text(tipo, textAlign: TextAlign.center),
                        );
                      }).toList(),
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categorías de "$tipoSeleccionado"',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          categoriasPorGrupo[tipoSeleccionado]!
                              .map(
                                (cat) => ActionChip(
                                  label: Text(cat),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => CatalogScreen(
                                              categoriaPreseleccionada: cat,
                                            ),
                                      ),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 20),
                    TextButton.icon(
                      onPressed: () => setState(() => tipoSeleccionado = null),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Volver a tipos'),
                    ),
                  ],
                ),
      ),
    );
  }
}

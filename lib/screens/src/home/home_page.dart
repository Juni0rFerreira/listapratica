import 'package:flutter/material.dart';
import 'package:listapratica/dummy_listmarketplace.dart';
import 'package:listapratica/widget/liststile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final listsmarketplace = {...DUMMY_LISTMARKETPLACE};
    return Scaffold(
      drawer: NavigationDrawer(
        onDestinationSelected: (index) {
          if (index == 1) {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/config');
          }
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 28, 16, 16),
            child: Text(
              'Opção',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          NavigationDrawerDestination(
            icon: const Icon(Icons.sync),
            label: Row(
              children: [
                const Text('Sincronizar'),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '20/11/2023 às 12:12',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.settings),
            label: Text('Configurações'),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('ListaPrática'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                child: const Text('A'),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/edit');
        },
        icon: const Icon(Icons.edit),
        label: const Text("Nova Lista"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SegmentedButton<int>(
                segments: const [
                  ButtonSegment(
                    value: 0,
                    label: Text('Todos'),
                  ),
                  ButtonSegment(
                    value: 1,
                    label: Text('Pendentes'),
                  ),
                  ButtonSegment(
                    value: 2,
                    label: Text('Concluidas'),
                  ),
                  ButtonSegment(
                    value: 3,
                    label: Text('Desativadas'),
                  ),
                ],
                selected: const {0},
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 500,
              child: ListView.builder(
                itemCount: listsmarketplace.length,
                itemBuilder: (ctx, i) => ListsTile(listMarketplace: listsmarketplace.values.elementAt(i)),

                  
                ),
              ),
            
          ],
        ),
      ),
    );
  }
}

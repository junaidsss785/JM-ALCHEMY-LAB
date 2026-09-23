import 'package:flutter/material.dart';
import '../data/chemistry_database.dart';

class CodexBottomSheet extends StatelessWidget {
  final Set<String> unlockedIds;

  const CodexBottomSheet({super.key, required this.unlockedIds});

  @override
  Widget build(BuildContext context) {
    final totalCount = JMAlchemyDatabase.elements.length;
    final unlockedCount = unlockedIds.length;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Chemistry Codex ($unlockedCount/$totalCount)',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00B4D8),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white70),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(color: Colors.white12),
          Expanded(
            child: ListView.builder(
              itemCount: totalCount,
              itemBuilder: (context, index) {
                final item = JMAlchemyDatabase.elements.values.elementAt(index);
                final isUnlocked = unlockedIds.contains(item.id);

                if (isUnlocked) {
                  String recipeStr = item.isBaseElement
                      ? 'Base Element'
                      : 'Recipe: ${JMAlchemyDatabase.elements[item.recipe![0]]?.name} + ${JMAlchemyDatabase.elements[item.recipe![1]]?.name}';

                  return Card(
                    color: const Color(0xFF1E2530),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: item.themeColor.withOpacity(0.2),
                        child: Text(item.iconSymbol, style: const TextStyle(fontSize: 18)),
                      ),
                      title: Text(
                        item.name,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Formula: ${item.formula} | $recipeStr\nUse: ${item.realWorldUse}',
                        style: const TextStyle(color: Colors.white60, fontSize: 12),
                      ),
                    ),
                  );
                } else {
                  String hintStr = '???';
                  if (item.recipe != null && item.recipe!.length == 2) {
                    final e1 = JMAlchemyDatabase.elements[item.recipe![0]];
                    final e2 = JMAlchemyDatabase.elements[item.recipe![1]];
                    hintStr = '${e1?.formula ?? "?"} + ${e2?.formula ?? "?"} = ?';
                  }

                  return Card(
                    color: const Color(0xFF161B22),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.white10,
                        child: Icon(Icons.lock, color: Colors.white38, size: 20),
                      ),
                      title: const Text(
                        '??? Locked ???',
                        style: TextStyle(color: Colors.white38, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Hint: $hintStr',
                        style: const TextStyle(color: Color(0xFFFFD166), fontSize: 12),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

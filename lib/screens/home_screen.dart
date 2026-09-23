import 'package:flutter/material.dart';
import '../data/chemistry_database.dart';
import '../models/element_model.dart';
import '../widgets/workspace_slot.dart';
import '../widgets/element_card.dart';
import '../widgets/codex_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ElementModel? slotA;
  ElementModel? slotB;

  final Set<String> unlockedIds = {'h2', 'o2', 'c', 'n2', 'fe', 'na', 'cl2'};

  void _onElementTap(ElementModel element) {
    setState(() {
      if (slotA == null) {
        slotA = element;
      } else if (slotB == null) {
        slotB = element;
      }
    });
  }

  void _clearSlot(ElementModel element) {
    setState(() {
      if (slotA?.id == element.id) {
        slotA = null;
      } else if (slotB?.id == element.id) {
        slotB = null;
      }
    });
  }

  void _clearAllSlots() {
    setState(() {
      slotA = null;
      slotB = null;
    });
  }

  void _combineSlots() {
    if (slotA == null || slotB == null) return;

    final result = JMAlchemyDatabase.combineElements(slotA!.id, slotB!.id);

    if (result != null) {
      final isAlreadyUnlocked = unlockedIds.contains(result.id);

      if (isAlreadyUnlocked) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFFFFB703),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Text(
              '⚠️ Already Discovered: ${result.name} (${result.formula}) is already in your inventory!',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        );
      } else {
        setState(() {
          unlockedIds.add(result.id);
          slotA = result;
          slotB = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF06D6A0),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Text(
              '🎉 NEW DISCOVERY: ${result.name} (${result.formula}) unlocked!',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFFE63946),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: const Text(
            '❌ No chemical reaction between these two elements.',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      );
    }
  }

  void _openCodex() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F141C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => CodexBottomSheet(unlockedIds: unlockedIds),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unlockedElements = JMAlchemyDatabase.elements.values
        .where((e) => unlockedIds.contains(e.id))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F141C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161B22),
        elevation: 0,
        title: const Text(
          'JM Alchemy Lab',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_book_rounded, color: Color(0xFF00B4D8)),
            onPressed: _openCodex,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WorkspaceSlot(
                        element: slotA,
                        label: 'Slot A',
                        onClearTap: _clearSlot,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        style: TextStyle(fontSize: 24, color: Colors.white38, fontWeight: FontWeight.bold),
                        child: Text('+'),
                      ),
                      WorkspaceSlot(
                        element: slotB,
                        label: 'Slot B',
                        onClearTap: _clearSlot,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00B4D8),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _combineSlots,
                        icon: const Icon(Icons.science, color: Colors.black),
                        label: const Text(
                          'COMBINE',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white30),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _clearAllSlots,
                        child: const Text('Clear', style: TextStyle(color: Colors.white70)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.white12, height: 1),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(12),
              color: const Color(0xFF161B22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Unlocked Elements (${unlockedElements.length})',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: unlockedElements.length,
                      itemBuilder: (context, index) {
                        return ElementCard(
                          element: unlockedElements[index],
                          onTap: () => _onElementTap(unlockedElements[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

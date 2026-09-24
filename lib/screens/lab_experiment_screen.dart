import 'package:flutter/material.dart';

class LabExperimentScreen extends StatefulWidget {
  const LabExperimentScreen({super.key});

  @override
  State<LabExperimentScreen> createState() => _LabExperimentScreenState();
}

class _LabExperimentScreenState extends State<LabExperimentScreen> {
  String statusMessage = 'ایک ایلیمنٹ کو دوسرے پر ڈریگ (Drag) کر کے رکھیں۔';
  String reactionResult = '';

  // 118 Elements List
  final List<Map<String, dynamic>> allElements = const [
    {'name': 'Hydrogen', 'symbol': 'H', 'number': 1},
    {'name': 'Helium', 'symbol': 'He', 'number': 2},
    {'name': 'Lithium', 'symbol': 'Li', 'number': 3},
    {'name': 'Beryllium', 'symbol': 'Be', 'number': 4},
    {'name': 'Boron', 'symbol': 'B', 'number': 5},
    {'name': 'Carbon', 'symbol': 'C', 'number': 6},
    {'name': 'Nitrogen', 'symbol': 'N', 'number': 7},
    {'name': 'Oxygen', 'symbol': 'O', 'number': 8},
    {'name': 'Fluorine', 'symbol': 'F', 'number': 9},
    {'name': 'Neon', 'symbol': 'Ne', 'number': 10},
    {'name': 'Sodium', 'symbol': 'Na', 'number': 11},
    {'name': 'Magnesium', 'symbol': 'Mg', 'number': 12},
    {'name': 'Aluminum', 'symbol': 'Al', 'number': 13},
    {'name': 'Silicon', 'symbol': 'Si', 'number': 14},
    {'name': 'Phosphorus', 'symbol': 'P', 'number': 15},
    {'name': 'Sulfur', 'symbol': 'S', 'number': 16},
    {'name': 'Chlorine', 'symbol': 'Cl', 'number': 17},
    {'name': 'Argon', 'symbol': 'Ar', 'number': 18},
    {'name': 'Potassium', 'symbol': 'K', 'number': 19},
    {'name': 'Calcium', 'symbol': 'Ca', 'number': 20},
    {'name': 'Scandium', 'symbol': 'Sc', 'number': 21},
    {'name': 'Titanium', 'symbol': 'Ti', 'number': 22},
    {'name': 'Vanadium', 'symbol': 'V', 'number': 23},
    {'name': 'Chromium', 'symbol': 'Cr', 'number': 24},
    {'name': 'Manganese', 'symbol': 'Mn', 'number': 25},
    {'name': 'Iron', 'symbol': 'Fe', 'number': 26},
    {'name': 'Cobalt', 'symbol': 'Co', 'number': 27},
    {'name': 'Nickel', 'symbol': 'Ni', 'number': 28},
    {'name': 'Copper', 'symbol': 'Cu', 'number': 29},
    {'name': 'Zinc', 'symbol': 'Zn', 'number': 30},
    {'name': 'Gallium', 'symbol': 'Ga', 'number': 31},
    {'name': 'Germanium', 'symbol': 'Ge', 'number': 32},
    {'name': 'Arsenic', 'symbol': 'As', 'number': 33},
    {'name': 'Selenium', 'symbol': 'Se', 'number': 34},
    {'name': 'Bromine', 'symbol': 'Br', 'number': 35},
    {'name': 'Krypton', 'symbol': 'Kr', 'number': 36},
    {'name': 'Rubidium', 'symbol': 'Rb', 'number': 37},
    {'name': 'Strontium', 'symbol': 'Sr', 'number': 38},
    {'name': 'Yttrium', 'symbol': 'Y', 'number': 39},
    {'name': 'Zirconium', 'symbol': 'Zr', 'number': 40},
    {'name': 'Niobium', 'symbol': 'Nb', 'number': 41},
    {'name': 'Molybdenum', 'symbol': 'Mo', 'number': 42},
    {'name': 'Technetium', 'symbol': 'Tc', 'number': 43},
    {'name': 'Ruthenium', 'symbol': 'Ru', 'number': 44},
    {'name': 'Rhodium', 'symbol': 'Rh', 'number': 45},
    {'name': 'Palladium', 'symbol': 'Pd', 'number': 46},
    {'name': 'Silver', 'symbol': 'Ag', 'number': 47},
    {'name': 'Cadmium', 'symbol': 'Cd', 'number': 48},
    {'name': 'Indium', 'symbol': 'In', 'number': 49},
    {'name': 'Tin', 'symbol': 'Sn', 'number': 50},
    {'name': 'Antimony', 'symbol': 'Sb', 'number': 51},
    {'name': 'Tellurium', 'symbol': 'Te', 'number': 52},
    {'name': 'Iodine', 'symbol': 'I', 'number': 53},
    {'name': 'Xenon', 'symbol': 'Xe', 'number': 54},
    {'name': 'Cesium', 'symbol': 'Cs', 'number': 55},
    {'name': 'Barium', 'symbol': 'Ba', 'number': 56},
    {'name': 'Lanthanum', 'symbol': 'La', 'number': 57},
    {'name': 'Cerium', 'symbol': 'Ce', 'number': 58},
    {'name': 'Praseodymium', 'symbol': 'Pr', 'number': 59},
    {'name': 'Neodymium', 'symbol': 'Nd', 'number': 60},
    {'name': 'Promethium', 'symbol': 'Pm', 'number': 61},
    {'name': 'Samarium', 'symbol': 'Sm', 'number': 62},
    {'name': 'Europium', 'symbol': 'Eu', 'number': 63},
    {'name': 'Gadolinium', 'symbol': 'Gd', 'number': 64},
    {'name': 'Terbium', 'symbol': 'Tb', 'number': 65},
    {'name': 'Dysprosium', 'symbol': 'Dy', 'number': 66},
    {'name': 'Holmium', 'symbol': 'Ho', 'number': 67},
    {'name': 'Erbium', 'symbol': 'Er', 'number': 68},
    {'name': 'Thulium', 'symbol': 'Tm', 'number': 69},
    {'name': 'Ytterbium', 'symbol': 'Yb', 'number': 70},
    {'name': 'Lutetium', 'symbol': 'Lu', 'number': 71},
    {'name': 'Hafnium', 'symbol': 'Hf', 'number': 72},
    {'name': 'Tantalum', 'symbol': 'Ta', 'number': 73},
    {'name': 'Tungsten', 'symbol': 'W', 'number': 74},
    {'name': 'Rhenium', 'symbol': 'Re', 'number': 75},
    {'name': 'Osmium', 'symbol': 'Os', 'number': 76},
    {'name': 'Iridium', 'symbol': 'Ir', 'number': 77},
    {'name': 'Platinum', 'symbol': 'Pt', 'number': 78},
    {'name': 'Gold', 'symbol': 'Au', 'number': 79},
    {'name': 'Mercury', 'symbol': 'Hg', 'number': 80},
    {'name': 'Thallium', 'symbol': 'Tl', 'number': 81},
    {'name': 'Lead', 'symbol': 'Pb', 'number': 82},
    {'name': 'Bismuth', 'symbol': 'Bi', 'number': 83},
    {'name': 'Polonium', 'symbol': 'Po', 'number': 84},
    {'name': 'Astatine', 'symbol': 'At', 'number': 85},
    {'name': 'Radon', 'symbol': 'Rn', 'number': 86},
    {'name': 'Francium', 'symbol': 'Fr', 'number': 87},
    {'name': 'Radium', 'symbol': 'Ra', 'number': 88},
    {'name': 'Actinium', 'symbol': 'Ac', 'number': 89},
    {'name': 'Thorium', 'symbol': 'Th', 'number': 90},
    {'name': 'Protactinium', 'symbol': 'Pa', 'number': 91},
    {'name': 'Uranium', 'symbol': 'U', 'number': 92},
    {'name': 'Neptunium', 'symbol': 'Np', 'number': 93},
    {'name': 'Plutonium', 'symbol': 'Pu', 'number': 94},
    {'name': 'Americium', 'symbol': 'Am', 'number': 95},
    {'name': 'Curium', 'symbol': 'Cm', 'number': 96},
    {'name': 'Berkelium', 'symbol': 'Bk', 'number': 97},
    {'name': 'Californium', 'symbol': 'Cf', 'number': 98},
    {'name': 'Einsteinium', 'symbol': 'Es', 'number': 99},
    {'name': 'Fermium', 'symbol': 'Fm', 'number': 100},
    {'name': 'Mendelevium', 'symbol': 'Md', 'number': 101},
    {'name': 'Nobelium', 'symbol': 'No', 'number': 102},
    {'name': 'Lawrencium', 'symbol': 'Lr', 'number': 103},
    {'name': 'Rutherfordium', 'symbol': 'Rf', 'number': 104},
    {'name': 'Dubnium', 'symbol': 'Db', 'number': 105},
    {'name': 'Seaborgium', 'symbol': 'Sg', 'number': 106},
    {'name': 'Bohrium', 'symbol': 'Bh', 'number': 107},
    {'name': 'Hassium', 'symbol': 'Hs', 'number': 108},
    {'name': 'Meitnerium', 'symbol': 'Mt', 'number': 109},
    {'name': 'Darmstadtium', 'symbol': 'Ds', 'number': 110},
    {'name': 'Roentgenium', 'symbol': 'Rg', 'number': 111},
    {'name': 'Copernicium', 'symbol': 'Cn', 'number': 112},
    {'name': 'Nihonium', 'symbol': 'Nh', 'number': 113},
    {'name': 'Flerovium', 'symbol': 'Fl', 'number': 114},
    {'name': 'Moscovium', 'symbol': 'Mc', 'number': 115},
    {'name': 'Livermorium', 'symbol': 'Lv', 'number': 116},
    {'name': 'Tennessine', 'symbol': 'Ts', 'number': 117},
    {'name': 'Oganesson', 'symbol': 'Og', 'number': 118},
  ];

  // Specific Chemical Reactions Database
  final Map<String, String> specificReactions = const {
    'H+O': 'Water (H₂O)',
    'H+F': 'Hydrogen Fluoride (HF)',
    'H+Cl': 'Hydrochloric Acid (HCl)',
    'H+Br': 'Hydrogen Bromide (HBr)',
    'H+I': 'Hydrogen Iodide (HI)',
    'H+N': 'Ammonia (NH₃)',
    'H+C': 'Methane (CH₄)',
    'H+S': 'Hydrogen Sulfide (H₂S)',
    'Na+Cl': 'Sodium Chloride / Table Salt (NaCl)',
    'K+Cl': 'Potassium Chloride (KCl)',
    'Li+Cl': 'Lithium Chloride (LiCl)',
    'Na+F': 'Sodium Fluoride (NaF)',
    'K+F': 'Potassium Fluoride (KF)',
    'Na+I': 'Sodium Iodide (NaI)',
    'K+I': 'Potassium Iodide (KI)',
    'C+O': 'Carbon Dioxide (CO₂)',
    'S+O': 'Sulfur Dioxide (SO₂)',
    'N+O': 'Nitric Oxide (NO)',
    'P+O': 'Phosphorus Pentoxide (P₂O₅)',
    'Mg+O': 'Magnesium Oxide (MgO)',
    'Ca+O': 'Calcium Oxide / Lime (CaO)',
    'Fe+O': 'Iron Oxide / Rust (Fe₂O₃)',
    'Cu+O': 'Copper Oxide (CuO)',
    'Zn+O': 'Zinc Oxide (ZnO)',
    'Al+O': 'Aluminum Oxide / Alumina (Al₂O₃)',
    'Ag+S': 'Silver Sulfide / Tarnish (Ag₂S)',
    'Fe+S': 'Iron Sulfide / Fool\'s Gold (FeS)',
    'Zn+S': 'Zinc Sulfide (ZnS)',
    'Cu+S': 'Copper Sulfide (CuS)',
    'Na+H': 'Sodium Hydride (NaH)',
    'Ca+H': 'Calcium Hydride (CaH₂)',
    'Mg+Cl': 'Magnesium Chloride (MgCl₂)',
    'Ca+Cl': 'Calcium Chloride (CaCl₂)',
    'Fe+Cl': 'Ferric Chloride (FeCl₃)',
    'Cu+Cl': 'Copper Chloride (CuCl₂)',
    'Al+Cl': 'Aluminum Chloride (AlCl₃)',
    'Zn+Cl': 'Zinc Chloride (ZnCl₂)',
    'Pb+S': 'Lead Sulfide / Galena (PbS)',
    'Hg+S': 'Mercury Sulfide / Cinnabar (HgS)',
  };

  void _handleReaction(Map<String, dynamic> dragged, Map<String, dynamic> target) {
    if (dragged['symbol'] == target['symbol']) return;

    String s1 = dragged['symbol'];
    String s2 = target['symbol'];
    String key1 = "$s1+$s2";
    String key2 = "$s2+$s1";

    setState(() {
      if (specificReactions.containsKey(key1)) {
        statusMessage = 'Reaction Successful! 🎉';
        reactionResult = '${dragged['name']} + ${target['name']}\n➜ ${specificReactions[key1]}';
      } else if (specificReactions.containsKey(key2)) {
        statusMessage = 'Reaction Successful! 🎉';
        reactionResult = '${dragged['name']} + ${target['name']}\n➜ ${specificReactions[key2]}';
      } else {
        // Generates dynamic scientific formulas for rest of combinations
        String product = _generateDynamicReaction(dragged, target);
        statusMessage = 'Reaction Formed! 🧪';
        reactionResult = '${dragged['name']} + ${target['name']}\n➜ $product';
      }
    });
  }

  String _generateDynamicReaction(Map<String, dynamic> e1, Map<String, dynamic> e2) {
    String sym1 = e1['symbol'];
    String sym2 = e2['symbol'];
    
    // Noble gases check
    if (['He', 'Ne', 'Ar', 'Kr', 'Xe', 'Rn', 'Og'].contains(sym1) ||
        ['He', 'Ne', 'Ar', 'Kr', 'Xe', 'Rn', 'Og'].contains(sym2)) {
      return 'Inert Mixture (Noble Gas - No Bond Formed)';
    }

    // Dynamic Compound Generator for 500+ possibilities
    return '$sym1$sym2 Binary Compound (${e1['name']} ${e2['name']} Complex)';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alchemy Lab Bench (${allElements.length} Elements)'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top Status Display Box
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.cyanAccent),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      statusMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.cyanAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (reactionResult.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        reactionResult,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: allElements.length,
                itemBuilder: (context, index) {
                  final item = allElements[index];

                  return DragTarget<Map<String, dynamic>>(
                    onAcceptWithDetails: (details) {
                      _handleReaction(details.data, item);
                    },
                    builder: (context, candidateData, rejectedData) {
                      final isHovered = candidateData.isNotEmpty;

                      return Draggable<Map<String, dynamic>>(
                        data: item,
                        feedback: Material(
                          color: Colors.transparent,
                          child: _buildElementBox(item, isDragging: true),
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.3,
                          child: _buildElementBox(item),
                        ),
                        child: _buildElementBox(
                          item,
                          isHighlighted: isHovered,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildElementBox(Map<String, dynamic> item, {bool isDragging = false, bool isHighlighted = false}) {
    return Container(
      width: isDragging ? 90 : null,
      height: isDragging ? 90 : null,
      decoration: BoxDecoration(
        color: isHighlighted
            ? Colors.cyanAccent.withOpacity(0.4)
            : (isDragging ? Colors.cyanAccent.withOpacity(0.8) : Colors.white.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlighted || isDragging ? Colors.cyanAccent : Colors.white24,
          width: isHighlighted || isDragging ? 2 : 1,
        ),
        boxShadow: isDragging
            ? [
                BoxShadow(
                  color: Colors.cyanAccent.withOpacity(0.5),
                  blurRadius: 15,
                  spreadRadius: 2,
                )
              ]
            : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item['symbol'] ?? '?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDragging ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item['name'] ?? '',
            style: TextStyle(
              fontSize: 11,
              color: isDragging ? Colors.black87 : Colors.white70,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

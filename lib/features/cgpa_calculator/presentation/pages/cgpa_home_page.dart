import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../shared/models/semester.dart';
import 'cgpa_calculator_page.dart';
import 'cgpa_analytics_page.dart';

class CgpaHomePage extends StatefulWidget {
  const CgpaHomePage({super.key});

  @override
  State<CgpaHomePage> createState() => _CgpaHomePageState();
}

class _CgpaHomePageState extends State<CgpaHomePage>
    with TickerProviderStateMixin {
  List<String> semesterKeys = [];
  double cumulativeCgpa = 0.0;
  int totalCredits = 0;
  int totalSubjects = 0;
  bool isLoading = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _loadSemesters();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadSemesters() async {
    setState(() => isLoading = true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs
        .getKeys()
        .where((key) => key.startsWith('semester_') || key.startsWith('year_'))
        .toList();

    keys.sort(); // Sort semester keys

    // Calculate cumulative CGPA
    double totalGradePoints = 0.0;
    int totalCreditHours = 0;
    int totalSubjectCount = 0;

    for (String key in keys) {
      final semester = await Semester.fromSharedPref(key);
      if (semester != null && semester.subjects.isNotEmpty) {
        double sgpa = semester.calculateSGPA();
        int semesterCredits = semester.calculateTotalCreditHours();

        totalGradePoints += sgpa * semesterCredits;
        totalCreditHours += semesterCredits;
        totalSubjectCount += semester.calculateTotalSubjects();
      }
    }

    setState(() {
      semesterKeys = keys;
      cumulativeCgpa = totalCreditHours > 0
          ? totalGradePoints / totalCreditHours
          : 0.0;
      totalCredits = totalCreditHours;
      totalSubjects = totalSubjectCount;
      isLoading = false;
    });

    _animationController.forward();
  }

  Future<void> _addNewSemester() async {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Add New Semester',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Semester Name',
                hintText: 'e.g., Semester 1, Year 1',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.school),
              ),
              autofocus: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.trim().isNotEmpty) {
                String key =
                    'semester_${DateTime.now().millisecondsSinceEpoch}';

                // Create empty semester
                final semester = Semester(
                  semesterName: nameController.text.trim(),
                  subjects: [],
                );
                await semester.toSharedPref(key);

                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CgpaCalculatorPage(semesterKey: key),
                  ),
                ).then((_) => _loadSemesters());
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteSemester(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    _loadSemesters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'CGPA Calculator',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      onPressed: semesterKeys.isNotEmpty
                          ? () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CgpaAnalyticsPage(
                                  semesterKeys: semesterKeys,
                                  cumulativeCgpa: cumulativeCgpa,
                                ),
                              ),
                            )
                          : null,
                      icon: Icon(
                        Icons.analytics_rounded,
                        color: semesterKeys.isNotEmpty
                            ? Colors.white
                            : Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),

              // Stats Cards
              if (!isLoading)
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        _buildStatCard(
                          'CGPA',
                          cumulativeCgpa.toStringAsFixed(2),
                          Icons.trending_up,
                        ),
                        const SizedBox(width: 12),
                        _buildStatCard(
                          'Credits',
                          totalCredits.toString(),
                          Icons.credit_score,
                        ),
                        const SizedBox(width: 12),
                        _buildStatCard(
                          'Subjects',
                          totalSubjects.toString(),
                          Icons.subject,
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              // Content Area
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your Semesters',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            Text(
                              '${semesterKeys.length} semester${semesterKeys.length != 1 ? 's' : ''}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      if (isLoading)
                        const Expanded(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else if (semesterKeys.isEmpty)
                        Expanded(child: _buildEmptyState())
                      else
                        Expanded(child: _buildSemestersList()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewSemester,
        backgroundColor: const Color(0xFF6C5CE7),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Semester'),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 24),
          Text(
            'No Semesters Yet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first semester to start calculating your CGPA',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _addNewSemester,
            icon: const Icon(Icons.add),
            label: const Text('Add Your First Semester'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSemestersList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: semesterKeys.length,
      itemBuilder: (context, index) {
        String key = semesterKeys[index];
        return FutureBuilder<Semester?>(
          future: Semester.fromSharedPref(key),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Card(child: ListTile(title: Text('Loading...')));
            }

            final semester = snapshot.data;
            if (semester == null) return const SizedBox.shrink();

            double sgpa = semester.calculateSGPA();
            int credits = semester.calculateTotalCreditHours();
            int subjects = semester.calculateTotalSubjects();

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                title: Text(
                  semester.semesterName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text('SGPA: ${sgpa.toStringAsFixed(2)}'),
                    Text('Credits: $credits • Subjects: $subjects'),
                  ],
                ),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 20, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) async {
                    if (value == 'edit') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CgpaCalculatorPage(semesterKey: key),
                        ),
                      ).then((_) => _loadSemesters());
                    } else if (value == 'delete') {
                      _showDeleteConfirmation(key, semester.semesterName);
                    }
                  },
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CgpaCalculatorPage(semesterKey: key),
                  ),
                ).then((_) => _loadSemesters()),
              ),
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmation(String key, String semesterName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Semester'),
        content: Text(
          'Are you sure you want to delete "$semesterName"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteSemester(key);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

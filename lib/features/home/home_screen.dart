import 'package:flutter/material.dart';
import '../../core/widgets/app_section_header.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/utils/copy_bank.dart';
import '../../data/repositories/content_repository.dart';
import '../../data/models/area.dart';
import 'widgets/area_grid.dart';
import 'widgets/my_kit_preview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Area>> _areasFuture;

  @override
  void initState() {
    super.initState();
    _areasFuture = ContentRepository().getAreas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Futly Prime', showBack: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Áreas de apoio',
              subtitle: CopyBank.homeSubtitle,
            ),
            const SizedBox(height: 16),
            FutureBuilder<List<Area>>(
              future: _areasFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Erro ao carregar áreas: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Nenhuma área disponível'),
                  );
                }
                return AreaGrid(areas: snapshot.data!);
              },
            ),
            const SizedBox(height: 32),
            const MyKitPreview(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

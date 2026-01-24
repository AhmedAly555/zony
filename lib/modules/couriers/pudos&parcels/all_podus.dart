import 'package:flutter/material.dart';
import 'package:zony/views/widgets/default_appbar.dart';
import 'package:zony/generated/l10n.dart';
import 'package:zony/views/widgets/loading.widget.dart';

import '../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../models/my_pudos_response.dart';
import '../../../services/get_courier_pudos_service.dart';
import '../../../services/navigator.services/app_navigator.services.dart';
import '../../../views/widgets/notifacation_item.dart';
import 'podu_details_and_parcels/podu_details_and_parcels.screen.dart';

class AllPODUsScreen extends StatefulWidget {
  const AllPODUsScreen({super.key});

  @override
  State<AllPODUsScreen> createState() => _AllPODUsScreenState();
}

class _AllPODUsScreenState extends State<AllPODUsScreen> {
  late Future<MyPudosResponse> _MypudosFuture;

  @override
  void initState() {
    super.initState();
    _MypudosFuture = GetCourierPudosService.instance.getAllPudos();
  }

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarHaveArrow(title: S.of(context).myPodus),
            const SizedBox(height: 28),
            // Search Row with TextField
            TextField(
              decoration: InputDecoration(
                hintText: S.of(context).allParcels,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF49159B),
                  size: 24,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 24),
            // Expanded to make the list scrollable
            Expanded(
              child: FutureBuilder<MyPudosResponse>(
                future: _MypudosFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: LoadingWidget());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text("${S.of(context).error}${snapshot.error}"),
                    );
                  }

                  final pudos = snapshot.data?.pudos ?? [];

                  if (pudos.isEmpty) {
                    return Center(child: Text(S.of(context).noPodusFound));
                  }

                  return ListView.separated(
                    itemCount: pudos.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final pudo = pudos[index];
                      return GestureDetector(
                        onTap: () {
                          AppNavigator.navigateTo(
                            context,
                            () => PudoDetailsAndParceis(
                              pudoId: pudo.id.toString(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: NotificationItem(
                            title: pudo.name,
                            subtitle: pudo.address.isEmpty
                                ? S.of(context).noAddressAvailable
                                : pudo.address,
                            time: '150 m',
                          ),
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
}

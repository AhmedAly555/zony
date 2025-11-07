import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zony/modules/couriers/podus&parcels/podu_details_and_parcels/podu_details_and_parcels.screen.dart';
import 'package:zony/views/widgets/default_appbar.dart';
import 'package:zony/generated/l10n.dart';

import '../../../../services/size_config.dart';
import '../../../../views/widgets/bottom_sheet/pickup_point_bottom_sheet.dart';
import '../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../models/my_pudos_response.dart';
import '../../../services/get_my_pudos_service.dart';
import '../../../services/navigator.services/app_navigator.services.dart';
import '../../../views/widgets/notifacation_item.dart';
import 'podu_details_and_parcels/podu_details.dart';

class AllPODUsScreen extends StatefulWidget {
  const AllPODUsScreen({super.key});

  @override
  State<AllPODUsScreen> createState() => _AllPODUsScreenState();
}

class _AllPODUsScreenState extends State<AllPODUsScreen> {

   late Future<MyPudosResponse> _MypudosFuture;


  void initState() {
    super.initState();
    _MypudosFuture = GetMyPudosService.instance.getAllPudos();
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
            SizedBox(height: 28,),
            // Search Row with TextField and Map Button
            Row(
              children: [
                // Search TextField
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: S.of(context).allParcels,
                      prefixIcon: Icon(Icons.search, color: Color(0xFF49159B),size: 24,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                // Map Button
                GestureDetector(
                  onTap: (){
                    showPickupPointBottomSheet(context);
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFF49159B),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SvgPicture.asset(
                      'assets/svgs/podus_location.svg',
                      //color: Theme.of(context).primaryColor,
                      width: 24,
                      height: 24,

                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24,),
            // Container with notifications
            Expanded(
              child: Container(
                //margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Unread Text
                    Text(
                      S.of(context).unread,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),

                    // Divider
                    Divider(
                      color: Color(0xFFF4F4F4),
                      //color: Colors.black,
                      thickness: 1,
                    ),
                    SizedBox(height: 8),

                    Expanded(
                      child: FutureBuilder<MyPudosResponse>(
                        future: _MypudosFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError) {
                            return Center(child: Text(S.of(context).error + '${snapshot.error}'));
                          }

                          final pudos = snapshot.data?.pudos ?? [];

                          if (pudos.isEmpty) {
                            return Center(child: Text(S.of(context).noPodusFound));
                          }

                          return ListView.separated(
                            itemCount: pudos.length,
                            separatorBuilder: (_, __) => const Divider(color: Color(0xFFF4F4F4)),
                            itemBuilder: (context, index) {
                              final pudo = pudos[index];
                              return GestureDetector(
                                onTap: (){
                                  AppNavigator.navigateTo(
                                    context,
                                        () => PDOUDetailsAndParceis(pudoId: pudo.id.toString()),
                                  );
                                },
                                child: NotificationItem(
                                  title: pudo.name,
                                  subtitle: pudo.address.isEmpty ? S.of(context).noAddressAvailable : pudo.address,
                                  time: '', // ممكن تضيف الوقت لو حبيت
                                  isLast: index == pudos.length - 1,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  // Notifications List
                  /*Column(
                    children: [
                      NotificationItem(
                        title: 'PODU Giza',
                        subtitle: 'Your shipment has been successfully received',
                        time: '3:14 PM',
                      ),
                      NotificationItem(
                        title: 'PODU Giza',
                        subtitle: 'Your shipment has been successfully received',
                        time: '3:14 PM',
                      ),
                      NotificationItem(
                        title: 'PODU Giza',
                        subtitle: 'Your shipment has been successfully received',
                        time: '3:14 PM',
                      ),
                      NotificationItem(
                        title: 'PODU Giza',
                        subtitle: 'Your shipment has been successfully received',
                        time: '3:14 PM',
                      ),
                      NotificationItem(
                        title: 'PODU Giza',
                        subtitle: 'Your shipment has been successfully received',
                        time: '3:14 PM',
                      ),
                      NotificationItem(
                        title: 'PODU Giza',
                        subtitle: 'Your shipment has been successfully received',
                        time: '3:14 PM',
                      ),
                      NotificationItem(
                        title: 'PODU Giza',
                        subtitle: 'Your shipment has been successfully received',
                        time: '3:14 PM',
                        isLast: true,
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
            ),
            //SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

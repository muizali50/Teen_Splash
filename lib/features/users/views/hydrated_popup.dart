import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/model/water_sponsor_model.dart';
import 'package:teen_splash/utils/gaps.dart';

class HydratedPopup extends StatefulWidget {
  const HydratedPopup({
    super.key,
  });

  @override
  State<HydratedPopup> createState() => _HydratedPopupState();
}

class _HydratedPopupState extends State<HydratedPopup> {
  late final AdminBloc adminBloc;
  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.waterSponsors.isEmpty) {
      adminBloc.add(
        GetWaterSponsor(),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topRight,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            height: 250,
            width: 286,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                final latestWaterSponsor = adminBloc.waterSponsors.lastWhere(
                  (sponsor) => sponsor.status == 'Active',
                  orElse: () =>
                      WaterSponsorModel(), // Returns null if no active sponsor is found
                );
      
                if (state is GettingWaterSponsor) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetWaterSponsorFailed) {
                  return Center(
                    child: Text(state.message),
                  );
                }
      
                // Check if no valid sponsor data
                if ((latestWaterSponsor.title ?? '').isEmpty &&
                    (latestWaterSponsor.description ?? '').isEmpty) {
                  return const Center(
                    child: Text('No active water sponsor available'),
                  );
                }
      
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if ((latestWaterSponsor.image ?? '').isNotEmpty)
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              latestWaterSponsor.image ?? '',
                            ),
                          ),
                        ),
                      )
                    else
                      const SizedBox(
                          height: 80), // Placeholder height if no image
                    Gaps.hGap10,
                    Text(
                      latestWaterSponsor.title ?? 'No title',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Gaps.hGap10,
                    Text(
                      latestWaterSponsor.description ?? 'No description',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            right: -10,
            top: -10,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    size: 20,
                    CupertinoIcons.multiply,
                    color: Color(0xFFffffff),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

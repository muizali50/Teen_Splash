import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';

class CountryGroups extends StatefulWidget {
  const CountryGroups({super.key});

  @override
  State<CountryGroups> createState() => _CountryGroupsState();
}

class _CountryGroupsState extends State<CountryGroups> {
  late final AdminBloc adminBloc;
  late final UserBloc userBloc;
  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.coupons.isEmpty) {
      adminBloc.add(
        GetCoupon(),
      );
    }
    userBloc = context.read<UserBloc>();
    if (userBloc.users.isEmpty) {
      userBloc.add(
        GetAllUsers(),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        Map<String, int> countUsersByRegion() {
          // Combine all userIds from all coupons into a set to remove duplicates
          final Set<String> userIdsUsingCoupons = adminBloc.coupons
              .expand((coupon) => coupon.userIds ?? [])
              .cast<String>()
              .toSet();

          // Filter users who used any coupon
          final usersUsingCoupons = userBloc.users.where((user) {
            return userIdsUsingCoupons.contains(user.uid);
          });

          // Group users by region and count them
          final regionCounts = <String, int>{};
          for (var user in usersUsingCoupons) {
            final region = user.country ??
                'Unknown'; // Replace 'country' with 'region' if applicable
            regionCounts[region] = (regionCounts[region] ?? 0) + 1;
          }

          return regionCounts;
        }

        final regionCounts = countUsersByRegion();

        if (state is GetAllUsersFailed) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is GettingAllUsers) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return DataTable(
          headingTextStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(
              0xFF131313,
            ),
          ),
          dataTextStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(
              0xFF131313,
            ),
          ),
          columns: const [
            DataColumn(
              label: Text('Country'),
            ),
            DataColumn(
              label: Text('Count'),
            ),
          ],
          rows: regionCounts.entries
              .map(
                (entry) => DataRow(
                  cells: [
                    DataCell(
                      Text(entry.key),
                    ),
                    DataCell(
                      Text(
                        '${entry.value}',
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        );
      },
    );
  }
}

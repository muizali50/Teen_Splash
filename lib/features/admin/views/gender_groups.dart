import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';

class GenderGroups extends StatefulWidget {
  const GenderGroups({super.key});

  @override
  State<GenderGroups> createState() => _GenderGroupsState();
}

class _GenderGroupsState extends State<GenderGroups> {
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
        Map<String, int> countUsersByGender() {
          // Combine all userIds from all coupons into a set to remove duplicates
          final Set<String> userIdsUsingCoupons = adminBloc.coupons
              .expand((coupon) => coupon.userIds ?? [])
              .cast<String>()
              .toSet();

          // Filter users who used any coupon
          final usersUsingCoupons = userBloc.users.where((user) {
            return userIdsUsingCoupons.contains(user.uid);
          });

          // Count male and female users
          final maleCount = usersUsingCoupons
              .where((user) =>
                  user.gender != null && user.gender!.toLowerCase() == 'male')
              .length;

          final femaleCount = usersUsingCoupons
              .where((user) =>
                  user.gender != null && user.gender!.toLowerCase() == 'female')
              .length;

          return {
            'Male': maleCount,
            'Female': femaleCount,
          };
        }

        final genderCounts = countUsersByGender();

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
              label: Text('Gender'),
            ),
            DataColumn(
              label: Text('Count'),
            ),
          ],
          rows: genderCounts.entries
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

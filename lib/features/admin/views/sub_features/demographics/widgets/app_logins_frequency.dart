import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';

class AppLoginsFrequency extends StatefulWidget {
  const AppLoginsFrequency({super.key});

  @override
  State<AppLoginsFrequency> createState() => _AppLoginsFrequencyState();
}

class _AppLoginsFrequencyState extends State<AppLoginsFrequency> {
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
        int getTotalLogins() {
          // Aggregate total logins
          return userBloc.users.fold(
            0,
            (sum, user) => sum + user.loginFrequency!.toInt(),
          );
        }

        final totalLogins = getTotalLogins();

        int getTotalCouponsRedeemed() {
          // Sum up the length of userIds in all coupons
          return adminBloc.coupons.fold(
            0,
            (sum, coupon) => sum + (coupon.userIds?.length ?? 0),
          );
        }

        final totalCouponsRedeemed = getTotalCouponsRedeemed();

        int getTotalCouponsViews() {
          // Sum up the length of userIds in all coupons
          return adminBloc.coupons.fold(
            0,
            (sum, coupon) => sum + (coupon.views?.length ?? 0),
          );
        }

        final totalCouponsViews = getTotalCouponsViews();

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
              label: Text('Metric'),
            ),
            DataColumn(
              label: Text('Value'),
            ),
          ],
          rows: [
            DataRow(
              cells: [
                const DataCell(
                  Text('Total App Logins'),
                ),
                DataCell(
                  Text('$totalLogins'),
                ),
              ],
            ),
            DataRow(
              cells: [
                const DataCell(
                  Text('Total Coupons Redeemed'),
                ),
                DataCell(
                  Text('$totalCouponsRedeemed'),
                ),
              ],
            ),
            DataRow(
              cells: [
                const DataCell(
                  Text('Total Coupons Views'),
                ),
                DataCell(
                  Text('$totalCouponsViews'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';

class ConversionRate extends StatefulWidget {
  const ConversionRate({super.key});

  @override
  State<ConversionRate> createState() => _ConversionRateState();
}

class _ConversionRateState extends State<ConversionRate> {
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
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        int getTotalRedeemed() {
          // Total number of userIds collectively
          return adminBloc.coupons.fold(
            0,
            (sum, coupon) => sum + (coupon.userIds?.length ?? 0),
          );
        }

        int getTotalViews() {
          // Total number of views collectively
          return adminBloc.coupons.fold(
            0,
            (sum, coupon) => sum + (coupon.views?.length ?? 0),
          );
        }

        double getConversionRate() {
          final totalRedeemed = getTotalRedeemed();
          final totalViews = getTotalViews();
          if (totalViews == 0) return 0; // Avoid division by zero
          return (totalRedeemed / totalViews) * 100;
        }

        final conversionRate = getConversionRate();

        if (state is GetCouponFailed) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is GettingCoupon) {
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
                  Text('Conversion Rate'),
                ),
                DataCell(
                  Text('${conversionRate.toStringAsFixed(2)}%'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

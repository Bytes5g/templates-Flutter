/// الجزيئات - OfflineBanner: شريط التنبيه عند انقطاع الإنترنت
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/ui_constants.dart';
import '../../bloc/network_cubit.dart';
import '../atoms/app_text.dart';

/// جزيء شريط الإشعار عند العمل دون اتصال
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCubit, NetworkStatus>(
      buildWhen: (prev, curr) => prev != curr,
      builder: (context, status) {
        if (status == NetworkStatus.online) return const SizedBox.shrink();

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spaceMd,
            vertical: AppDimensions.spaceSm,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFF39C12),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                color: Colors.white,
                size: AppDimensions.iconSm,
              ),
              const SizedBox(width: AppDimensions.spaceSm),
              const Expanded(
                child: AppText(
                  'لا يوجد اتصال بالإنترنت. يتم عرض البيانات المحفوظة.',
                  variant: AppTextVariant.bodySmall,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

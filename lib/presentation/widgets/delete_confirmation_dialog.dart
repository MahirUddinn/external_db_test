import 'package:external_db_test/core/constants/app_dimensions.dart';
import 'package:external_db_test/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radius20),
      ),
      elevation: AppDimensions.elevation0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.mp24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radius20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppDimensions.icon80,
              height: AppDimensions.icon80,
              decoration: BoxDecoration(
                color: Colors.red[50],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline,
                size: AppDimensions.icon40,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: AppDimensions.mp20),
            Text(
              AppStrings.deleteItemTitle,
              style: TextStyle(
                fontSize: AppDimensions.font22,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: AppDimensions.mp12),
            Text(
              AppStrings.deleteItemConfirmation,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppDimensions.font14,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppDimensions.mp24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.mp16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radius12,
                        ),
                      ),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      AppStrings.cancel,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.mp16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.mp16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radius12,
                        ),
                      ),
                      elevation: AppDimensions.elevation0,
                    ),
                    child: const Text(
                      AppStrings.delete,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

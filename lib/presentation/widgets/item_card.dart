import 'package:external_db_test/core/constants/app_dimensions.dart';
import 'package:external_db_test/core/constants/app_strings.dart';
import 'package:external_db_test/domain/entities/item.dart';
import 'package:external_db_test/presentation/cubit/item_cubit.dart';
import 'package:external_db_test/presentation/views/item_detail_page.dart';
import 'package:external_db_test/presentation/widgets/delete_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: AppDimensions.elevation1,
      borderRadius: BorderRadius.circular(AppDimensions.radius16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radius16),
          border: Border.all(color: Colors.grey[100]!),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemDetailPage(item: item),
              ),
            );
          },
          borderRadius: BorderRadius.circular(AppDimensions.radius16),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.mp16),
            child: Row(
              children: [
                Container(
                  width: AppDimensions.mp48,
                  height: AppDimensions.mp48,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(AppDimensions.radius12),
                  ),
                  child: const Icon(
                    Icons.inventory_2,
                    color: Colors.blue,
                    size: AppDimensions.icon24,
                  ),
                ),
                const SizedBox(width: AppDimensions.mp16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.itemName,
                        style: const TextStyle(
                          fontSize: AppDimensions.font16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: AppDimensions.lines1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppDimensions.mp4),
                      Text(
                        '${AppStrings.codePrefix}${item.itemCode}',
                        style: TextStyle(
                          fontSize: AppDimensions.font13,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: AppDimensions.mp8),
                      Row(
                        children: [
                          _buildInfoChip(
                            icon: Icons.attach_money,
                            text:
                                '${AppStrings.currencySymbol}${item.itemSalesPrice}',
                            color: Colors.green[100]!,
                            textColor: Colors.green[800]!,
                          ),
                          const SizedBox(width: AppDimensions.mp8),
                          _buildInfoChip(
                            icon: Icons.inventory,
                            text: '${item.itemStock}${AppStrings.unitsSuffix}',
                            color: Colors.blue[100]!,
                            textColor: Colors.blue[800]!,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(AppDimensions.mp8),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radius10,
                      ),
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      size: AppDimensions.icon20,
                      color: Colors.red[600],
                    ),
                  ),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => const DeleteConfirmationDialog(),
                    );

                    if (confirm == true && context.mounted) {
                      // Show deleting indicator
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Row(
                            children: [
                              SizedBox(
                                width: AppDimensions.icon20,
                                height: AppDimensions.icon20,
                                child: CircularProgressIndicator(
                                  strokeWidth: AppDimensions.stroke2,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: AppDimensions.mp12),
                              Text(AppStrings.deletingItem),
                            ],
                          ),
                          backgroundColor: Colors.blue[600],
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radius12,
                            ),
                          ),
                        ),
                      );

                      context.read<ItemCubit>().removeItem(item.id!);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.mp8,
        vertical: AppDimensions.mp4,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppDimensions.radius8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppDimensions.icon12, color: textColor),
          const SizedBox(width: AppDimensions.mp4),
          Text(
            text,
            style: TextStyle(
              fontSize: AppDimensions.font11,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

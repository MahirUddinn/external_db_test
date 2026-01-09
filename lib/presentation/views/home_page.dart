import 'package:external_db_test/core/constants/app_dimensions.dart';
import 'package:external_db_test/core/constants/app_strings.dart';
import 'package:external_db_test/presentation/cubit/item_cubit.dart';
import 'package:external_db_test/presentation/cubit/item_state.dart';
import 'package:external_db_test/presentation/views/item_detail_page.dart';
import 'package:external_db_test/presentation/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ItemCubit>().fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.homeTitle,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: AppDimensions.font22,
          ),
        ),
        centerTitle: true,
        elevation: AppDimensions.elevation0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue[800],
        surfaceTintColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ItemDetailPage()),
          ).then((_) {
            if (context.mounted) {
              context.read<ItemCubit>().fetchItems();
            }
          });
        },
        icon: const Icon(Icons.add),
        label: const Text(AppStrings.addItemButton),
        backgroundColor: Colors.blue[600],
        elevation: AppDimensions.elevation4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radius16),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.grey[50]!],
          ),
        ),
        child: BlocConsumer<ItemCubit, ItemState>(
          listener: (context, state) {
            if (state.status == ItemStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.white),
                      const SizedBox(width: AppDimensions.mp8),
                      Expanded(
                        child: Text(
                          '${AppStrings.errorPrefix}${state.errorMessage}',
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.red[600],
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radius12),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.status == ItemStatus.loading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: AppDimensions.mp60,
                      height: AppDimensions.mp60,
                      child: CircularProgressIndicator(
                        strokeWidth: AppDimensions.stroke4,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.blue[600]!,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.mp20),
                    Text(
                      AppStrings.loadingItems,
                      style: TextStyle(
                        fontSize: AppDimensions.font16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.status == ItemStatus.success) {
              if (state.items.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: AppDimensions.icon80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: AppDimensions.mp20),
                      Text(
                        AppStrings.noItemsFound,
                        style: TextStyle(
                          fontSize: AppDimensions.font20,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.mp10),
                      Text(
                        AppStrings.addFirstItemHint,
                        style: TextStyle(
                          fontSize: AppDimensions.font14,
                          color: Colors.grey[500],
                        ),
                      ),
                      const SizedBox(height: AppDimensions.mp30),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ItemDetailPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: const Text(AppStrings.addFirstItemButton),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.mp24,
                            vertical: AppDimensions.mp12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radius12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<ItemCubit>().fetchItems();
                },
                color: Colors.blue[600],
                backgroundColor: Colors.white,
                child: ListView.separated(
                  padding: const EdgeInsets.all(AppDimensions.mp16),
                  itemCount: state.items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppDimensions.mp12),
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return ItemCard(item: item);
                  },
                ),
              );
            } else if (state.status == ItemStatus.failure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: AppDimensions.icon64,
                      color: Colors.red[400],
                    ),
                    const SizedBox(height: AppDimensions.mp20),
                    Text(
                      AppStrings.failedToLoad,
                      style: TextStyle(
                        fontSize: AppDimensions.font20,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.mp10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.mp32,
                      ),
                      child: Text(
                        '${AppStrings.errorPrefix}${state.errorMessage}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: AppDimensions.font14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.mp30),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ItemCubit>().fetchItems();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text(AppStrings.tryAgain),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.mp24,
                          vertical: AppDimensions.mp12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radius12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('Initial State'));
          },
        ),
      ),
    );
  }
}

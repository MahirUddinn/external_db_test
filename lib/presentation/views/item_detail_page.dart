import 'package:external_db_test/core/constants/app_dimensions.dart';
import 'package:external_db_test/core/constants/app_strings.dart';
import 'package:external_db_test/domain/entities/item.dart';
import 'package:external_db_test/presentation/cubit/item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemDetailPage extends StatefulWidget {
  final Item? item;

  const ItemDetailPage({super.key, this.item});

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _codeController;
  late TextEditingController _barcodeController;
  late TextEditingController _nameController;
  late TextEditingController _nameBnController;
  late TextEditingController _descriptionController;
  late TextEditingController _stockController;
  late TextEditingController _priceController;
  late TextEditingController _generalDiscountController;
  late TextEditingController _purPriceController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.item?.itemCode ?? '');
    _barcodeController = TextEditingController(
      text: widget.item?.itemBarcode ?? '',
    );
    _nameController = TextEditingController(text: widget.item?.itemName ?? '');
    _nameBnController = TextEditingController(
      text: widget.item?.itemNameBn ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.item?.itemDes ?? '',
    );
    _stockController = TextEditingController(
      text: widget.item?.itemStock.toString() ?? '0',
    );
    _priceController = TextEditingController(
      text: widget.item?.itemSalesPrice.toString() ?? '0',
    );
    _generalDiscountController = TextEditingController(
      text: widget.item?.itemGeneralDiscount?.toString() ?? '0',
    );
    _purPriceController = TextEditingController(
      text: widget.item?.itemPurPrice?.toString() ?? '0',
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _barcodeController.dispose();
    _nameController.dispose();
    _nameBnController.dispose();
    _descriptionController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    _generalDiscountController.dispose();
    _purPriceController.dispose();
    super.dispose();
  }

  void _incrementStock() {
    final currentStock = num.tryParse(_stockController.text) ?? 0;
    _stockController.text = (currentStock + 1).toString();
  }

  void _decrementStock() {
    final currentStock = num.tryParse(_stockController.text) ?? 0;
    if (currentStock > 0) {
      _stockController.text = (currentStock - 1).toString();
    }
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      final item = Item(
        id: widget.item?.id,
        itemCode: _codeController.text,
        itemBarcode: _barcodeController.text.isEmpty
            ? null
            : _barcodeController.text,
        itemName: _nameController.text,
        itemNameBn: _nameBnController.text.isEmpty
            ? null
            : _nameBnController.text,
        itemDes: _descriptionController.text.isEmpty
            ? null
            : _descriptionController.text,
        itemStock: num.tryParse(_stockController.text) ?? 0,
        itemSalesPrice: num.tryParse(_priceController.text) ?? 0,
        itemGeneralDiscount: num.tryParse(_generalDiscountController.text) ?? 0,
        itemPurPrice: num.tryParse(_purPriceController.text) ?? 0,
      );

      if (widget.item == null) {
        context.read<ItemCubit>().createItem(item);
      } else {
        context.read<ItemCubit>().editItem(item);
      }

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: AppDimensions.mp8),
              Text(
                widget.item == null
                    ? AppStrings.itemCreatedSuccess
                    : AppStrings.itemUpdatedSuccess,
              ),
            ],
          ),
          backgroundColor: Colors.green[600],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radius12),
          ),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.item != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? AppStrings.editItemTitle : AppStrings.addItemTitle,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue[800],
        surfaceTintColor: Colors.transparent,
        elevation: AppDimensions.elevation0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFF8FAFF)],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.mp24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSectionHeader('Item Information'),
                  const SizedBox(height: AppDimensions.mp16),

                  _buildTextField(
                    controller: _codeController,
                    label: AppStrings.itemCodeLabel,
                    icon: Icons.qr_code,
                    validator: (value) =>
                        value!.isEmpty ? AppStrings.enterItemCode : null,
                  ),
                  const SizedBox(height: AppDimensions.mp16),

                  _buildTextField(
                    controller: _barcodeController,
                    label: AppStrings.itemBarcodeLabel,
                    icon: Icons.barcode_reader,
                  ),
                  const SizedBox(height: AppDimensions.mp16),

                  _buildTextField(
                    controller: _nameController,
                    label: AppStrings.itemNameLabel,
                    icon: Icons.inventory_2,
                    validator: (value) =>
                        value!.isEmpty ? AppStrings.enterItemName : null,
                  ),
                  const SizedBox(height: AppDimensions.mp16),

                  _buildTextField(
                    controller: _nameBnController,
                    label: AppStrings.itemNameBnLabel,
                    icon: Icons.language,
                  ),
                  const SizedBox(height: AppDimensions.mp16),

                  _buildTextField(
                    controller: _descriptionController,
                    label: AppStrings.descriptionLabel,
                    icon: Icons.description,
                    maxLines: AppDimensions.lines3,
                  ),

                  const SizedBox(height: AppDimensions.mp24),
                  _buildSectionHeader('Pricing & Stock'),
                  const SizedBox(height: AppDimensions.mp16),

                  Container(
                    padding: const EdgeInsets.all(AppDimensions.mp16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radius16,
                      ),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.stockLevelLabel,
                          style: TextStyle(
                            fontSize: AppDimensions.font14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.mp8),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _stockController,
                                decoration: InputDecoration(
                                  hintText: AppStrings.stockHint,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppDimensions.radius12,
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppDimensions.radius12,
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppDimensions.radius12,
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.blue[400]!,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: AppDimensions.mp16,
                                    vertical: 14,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => value!.isEmpty
                                    ? AppStrings.enterStock
                                    : null,
                              ),
                            ),
                            const SizedBox(width: AppDimensions.mp12),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radius12,
                                ),
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.grey[700],
                                    ),
                                    onPressed: _decrementStock,
                                  ),
                                  Container(
                                    width: AppDimensions.stroke1,
                                    height: AppDimensions.mp24,
                                    color: Colors.grey[200],
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.blue[600],
                                    ),
                                    onPressed: _incrementStock,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppDimensions.mp16),

                  Row(
                    children: [
                      Expanded(
                        child: _buildPriceField(
                          controller: _priceController,
                          label: AppStrings.salesPriceLabel,
                          icon: Icons.attach_money,
                          validator: (value) =>
                              value!.isEmpty ? AppStrings.enterPrice : null,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.mp16),
                      Expanded(
                        child: _buildPriceField(
                          controller: _purPriceController,
                          label: AppStrings.purchasePriceLabel,
                          icon: Icons.shopping_cart,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppDimensions.mp16),

                  _buildPriceField(
                    controller: _generalDiscountController,
                    label: AppStrings.generalDiscountLabel,
                    icon: Icons.discount,
                  ),

                  const SizedBox(height: AppDimensions.mp32),

                  ElevatedButton(
                    onPressed: _saveItem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.mp16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radius12,
                        ),
                      ),
                      elevation: AppDimensions.elevation2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(isEditing ? Icons.save : Icons.add_circle),
                        const SizedBox(width: AppDimensions.mp8),
                        Text(
                          isEditing
                              ? AppStrings.updateItemButton
                              : AppStrings.createItemButton,
                          style: const TextStyle(
                            fontSize: AppDimensions.font16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: AppDimensions.mp4,
          height: AppDimensions.mp20,
          decoration: BoxDecoration(
            color: Colors.blue[600],
            borderRadius: BorderRadius.circular(AppDimensions.radius2),
          ),
        ),
        const SizedBox(width: AppDimensions.mp12),
        Text(
          title,
          style: TextStyle(
            fontSize: AppDimensions.font18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    int maxLines = AppDimensions.lines1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radius16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.mp2),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: Colors.grey[600]),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.mp16,
              vertical: AppDimensions.mp16,
            ),
          ),
          maxLines: maxLines,
          validator: validator,
        ),
      ),
    );
  }

  Widget _buildPriceField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radius16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.mp2),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: Colors.grey[600]),
            suffixText: label.contains('Price')
                ? AppStrings.currencySymbol
                : AppStrings.percentSymbol,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.mp16,
              vertical: AppDimensions.mp16,
            ),
          ),
          keyboardType: TextInputType.number,
          validator: validator,
        ),
      ),
    );
  }
}

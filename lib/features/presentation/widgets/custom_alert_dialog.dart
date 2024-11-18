import 'package:dairy_track/core/validations/validations.dart';
import 'package:dairy_track/features/data/models/delivery_model.dart';
import 'package:dairy_track/features/presentation/getx/map_data_controller.dart';
import 'package:dairy_track/features/presentation/widgets/custom_dropdown.dart';
import 'package:dairy_track/features/presentation/widgets/custom_snackbar.dart';
import 'package:dairy_track/features/presentation/widgets/custom_textformfiled.dart';
import 'package:dairy_track/features/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showStatuUpdationDialog(DeliveryModel model, String shopId) {
  final MapController mapController = Get.put(MapController());
  final TextEditingController controller = TextEditingController();
  String currentStatus = 'Delivered';
  List<String> status = ['Delivered', 'Cancelled'];
  controller.text = '0';
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 16.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText(),
            const Gap(),
            _textField(controller),
            const Gap(),
            _dropDown(currentStatus, status),
            const Gap(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _cancelButton(),
                _updateButton(
                    mapController, controller, model, shopId, currentStatus),
              ],
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

Obx _updateButton(MapController mapController, TextEditingController controller,
    DeliveryModel model, String shopId, String currentStatus) {
  return Obx(() {
    if (mapController.loading.value) {
      return const ElevatedButton(
          onPressed: null, child: CircularProgressIndicator());
    } else {
      return ElevatedButton(
        onPressed: () {
          final quantity = double.tryParse(controller.text.trim());
          if (quantity == null) {
            showCustomSnackbar(
                title: 'Error',
                message: 'Quantity should be a number',
                isSuccess: false);
          } else {
            final quantity = double.tryParse(controller.text) ?? 0.0;

            if (quantity > model.remainingStock) {
              showCustomSnackbar(
                  title: 'Error',
                  message:
                      'Please enter a valid quantity .Stock is not available',
                  isSuccess: false);
            } else {
              for (var element in model.shops) {
                if (shopId == element.shopModel.id) {
                  element.deliveredQuantity =
                      double.tryParse(controller.text) ?? 0.0;
                  element.dateTime = DateTime.now();
                  element.status = currentStatus;
                }
              }
              model.remainingStock = model.initialStock - quantity;
              model.deliveredStock = model.deliveredStock + quantity;
              mapController.deliveredStatusUpdate(id: model.id, model: model);
            }
          }
        },
        child: const Text('Update'),
      );
    }
  });
}

TextButton _cancelButton() {
  return TextButton(
    onPressed: () {
      Get.back();
    },
    child: const Text('Cancel'),
  );
}

StatefulBuilder _dropDown(String currentStatus, List<String> status) {
  return StatefulBuilder(
    builder: (context, setState) => CustomDropdownFormField(
      labelText: "Status",
      value: currentStatus,
      items: status,
      onChanged: (value) {
        if (value != null) {
          setState(
            () => currentStatus = value,
          );
        }
      },
    ),
  );
}

CustomTextFormField _textField(TextEditingController controller) {
  return CustomTextFormField(
    keyboardType: TextInputType.number,
    validator: Validations.validateNumber,
    controller: controller,
    labelText: 'Devivered Quantity',
  );
}

Text titleText() {
  return const Text(
    'Update Status',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );
}

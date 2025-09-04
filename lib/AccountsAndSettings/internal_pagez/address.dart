import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Components/InputFields.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Theme/FontSize.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  int _selectedIndex = 0;

  List<Map<String, String>> addresses = [
    {
      "label": "Home",
      "name": "John Doe",
      "address":
          "123 Garden Avenue Apt 4B\nSan Francisco, CA 94107\nUnited States",
      "phone": "(555) 123-4567",
    },
    {
      "label": "Work",
      "name": "John Doe",
      "address":
          "456 Business Park Suite 202\nSan Francisco, CA 94108\nUnited States",
      "phone": "(555) 987-6543",
    },
  ];

  void _openAddressDialog({int? editIndex}) {
    final isEditing = editIndex != null;
    final address =
        isEditing
            ? addresses[editIndex]
            : {"label": "", "name": "", "address": "", "phone": ""};

    final labelController = TextEditingController(text: address["label"]);
    final nameController = TextEditingController(text: address["name"]);
    final addrController = TextEditingController(text: address["address"]);
    final phoneController = TextEditingController(text: address["phone"]);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 750, // ⬅️ Adjust width as per your need
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isEditing ? "Edit Address" : "Add New Address",
                      style: TextStyle(
                        color: AppColors.green,
                        fontSize: primary(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    labelText("Label"),
                    CustomInputField(
                      labelText: "Label (e.g., Home/Work)",
                      controller: labelController,
                    ),
                    const SizedBox(height: 10),
                    labelText("Name"),
                    CustomInputField(
                      labelText: "Name",
                      controller: nameController,
                    ),
                    const SizedBox(height: 10),
                    labelText("Address"),
                    CustomInputField(
                      labelText: "Address",
                      controller: addrController,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10),
                    labelText("Phone Number"),
                    CustomInputField(
                      controller: phoneController,
                      allowedType: AllowedType.phone,
                      labelText: '',
                    ),
                    const SizedBox(height: 20),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        const SizedBox(width: 8),
                        CustomButton(
                          text: isEditing ? "Save" : "Add",
                          variant: ButtonVariant.filled,
                          onPressed: () {
                            setState(() {
                              if (isEditing) {
                                addresses[editIndex!] = {
                                  "label": labelController.text,
                                  "name": nameController.text,
                                  "address": addrController.text,
                                  "phone": phoneController.text,
                                };
                              } else {
                                addresses.add({
                                  "label": labelController.text,
                                  "name": nameController.text,
                                  "address": addrController.text,
                                  "phone": phoneController.text,
                                });
                              }
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _deleteAddress(int index) {
    setState(() {
      addresses.removeAt(index);
      if (_selectedIndex >= addresses.length) {
        _selectedIndex = addresses.isEmpty ? 0 : addresses.length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: KCenteredActionsAppBar(title: "Shipping Address"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shipping Address",
                  style: TextStyle(
                    fontSize: secondary(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => _openAddressDialog(),
                  child: Text(
                    "Add New",
                    style: TextStyle(
                      fontSize: secondary(),
                      fontWeight: FontWeight.w500,
                      color: AppColors.green,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // List of Addresses
            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  final isSelected = _selectedIndex == index;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color:
                            isSelected ? AppColors.green : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Radio Button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 4, right: 12),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.green,
                                width: 2,
                              ),
                            ),
                            child:
                                isSelected
                                    ? Center(
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.green,
                                        ),
                                      ),
                                    )
                                    : null,
                          ),
                        ),

                        // Address Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                address["label"] ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(address["name"] ?? ""),
                              Text(address["address"] ?? ""),
                              Text(address["phone"] ?? ""),
                            ],
                          ),
                        ),

                        // Edit + Delete
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed:
                                  () => _openAddressDialog(editIndex: index),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: AppColors.red,
                              ),
                              onPressed: () => _deleteAddress(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

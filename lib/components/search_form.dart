import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'or_divider.dart';

class SearchForm extends StatelessWidget {
  final TextEditingController cityController;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final Function() onSearch;
  final String? Function(String?)? validator;

  const SearchForm({
    super.key,
    required this.cityController,
    required this.formKey,
    required this.isLoading,
    required this.onSearch,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter a city name',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: cityController,
            style: const TextStyle(fontSize: 18),
            validator: validator,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red[300]!,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red[300]!,
                ),
              ),
              hintText: 'E.g., New York, London, Tokyo',
              labelStyle: const TextStyle(fontSize: 18),
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              errorStyle: TextStyle(
                color: Colors.red[300],
                fontSize: 14,
                height: 1,
              ),
              errorMaxLines: 1,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: isLoading ? null : onSearch,
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
          ),
          const SizedBox(height: 24),
          const OrDivider(),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gray,
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: isLoading ? null : () {},
            child: const Text(
              'Use current location',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 
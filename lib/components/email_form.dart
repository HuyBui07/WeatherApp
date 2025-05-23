import 'package:flutter/material.dart';
import 'package:weather_app/theme/app_colors.dart';
import 'package:weather_app/services/subscription_service.dart';
import 'package:weather_app/utils/responsive.dart';

class EmailForm extends StatelessWidget {
  const EmailForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();

    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter an email';
      }
      if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
          .hasMatch(value)) {
        return 'Please enter a valid email';
      }
      return null;
    }

    void onCancel() {
      Navigator.pop(context);
    }

    void onSubmit() {
      if (formKey.currentState!.validate()) {
        WeatherSubscriptionService()
            .subscribeToWeatherUpdates(emailController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Subscription successful'),
          ),
        );
        Navigator.pop(context);
      }
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(Responsive.getPadding(context)),
        width: Responsive.isMobile(context)
            ? MediaQuery.of(context).size.width * 0.9
            : MediaQuery.of(context).size.width * 0.3,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Subscribe to Weather Updates',
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 18 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Responsive.getPadding(context)),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: validateEmail,
              ),
              SizedBox(height: Responsive.getPadding(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: Size(
                        Responsive.isMobile(context) ? 80 : 100,
                        Responsive.isMobile(context) ? 40 : 60,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: onCancel,
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: Responsive.isMobile(context) ? 14 : 16,
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.getPadding(context) / 2),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: Size(
                        Responsive.isMobile(context) ? 80 : 100,
                        Responsive.isMobile(context) ? 40 : 60,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: onSubmit,
                    child: Text(
                      'Subscribe',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.isMobile(context) ? 14 : 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

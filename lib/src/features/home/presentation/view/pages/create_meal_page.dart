import 'package:flutter/material.dart';
import 'package:macros_app/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

class CreateMealPage extends StatefulWidget {
  const CreateMealPage({super.key});

  static const routeName = '/create-meal';

  @override
  State<CreateMealPage> createState() => _CreateMealPageState();
}

class _CreateMealPageState extends State<CreateMealPage> {
  _showTimePicker(BuildContext context) async {
    final response = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                onSurface: Theme.of(context).colorScheme.onBackground),
          ),
          child: child!,
        );
      },
    );

    if (response != null) {
      setState(() {
        time = response;
      });
    }
  }

  TimeOfDay time = TimeOfDay(hour: 8, minute: 0);
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  String? errorText;

  bool validText() {
    setState(() {
      errorText = null;
    });

    if (nameController.text == '' || nameController.text.length > 30) {
      setState(() {
        errorText = 'Nome inválido';
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Criar refeição'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                validText();
              },
              controller: nameController,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                labelText: 'Nome',
                errorText: errorText,
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Horário:'),
                TextButton.icon(
                  onPressed: () async => _showTimePicker(context),
                  label: time.minute < 10
                      ? Text(
                          '${time.hour}:0${time.minute}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )
                      : Text(
                          '${time.hour}:${time.minute}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                  icon: const Icon(Icons.access_time),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: isLoading
                    ? _loadingIndicator(context)
                    : Text(
                        'Adicionar',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  if (errorText != null) {
                    setState(() {
                      isLoading = false;
                    });
                    return;
                  }

                  await context
                      .read<MealViewmodel>()
                      .addMeal(
                        nameController.text,
                        time,
                      )
                      .then(
                    (value) {
                      Navigator.pop(context);
                      setState(() {
                        isLoading = false;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _loadingIndicator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }
}

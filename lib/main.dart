import 'package:flutter/material.dart';

void main() {
  runApp(const SemanticTestApp());
}

class SemanticTestApp extends StatelessWidget {
  const SemanticTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semantic Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: FirstPage.routeName,
      routes: {
        FirstPage.routeName: (_) => const FirstPage(),
        SecondPage.routeName: (_) => const SecondPage(),
      },
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  static const routeName = '/';

  @override
  State<FirstPage> createState() => _FirstPageState();
}

enum RadioGroupValue { optionA, optionB, optionC }

class _FirstPageState extends State<FirstPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  bool _agreeToTerms = false;
  RadioGroupValue _groupValue = RadioGroupValue.optionA;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _goToSecondPage() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    Navigator.of(context).pushNamed(SecondPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('QA Semantic Controls'),
      ),
      body: SafeArea(
        child: Semantics(
          container: true,
          label: 'First page form controls',
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Semantics(
                  header: true,
                  label: 'Form fields section header',
                  child: Text(
                    'Text fields (with validation)',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 12),
                Semantics(
                  textField: true,
                  label: 'Name text field',
                  hint: 'Required. Minimum 3 characters.',
                  child: TextFormField(
                    key: const Key('textfield_name'),
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'e.g. Taylor',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final trimmed = (value ?? '').trim();
                      if (trimmed.isEmpty) return 'Name is required.';
                      if (trimmed.length < 3) {
                        return 'Name must be at least 3 characters.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Semantics(
                  textField: true,
                  label: 'Email text field',
                  hint: 'Required. Must be a valid email.',
                  child: TextFormField(
                    key: const Key('textfield_email'),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'e.g. taylor@example.com',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final trimmed = (value ?? '').trim();
                      if (trimmed.isEmpty) return 'Email is required.';
                      final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                      if (!emailRegex.hasMatch(trimmed)) {
                        return 'Enter a valid email.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Semantics(
                  header: true,
                  label: 'Checkbox section header',
                  child: Text(
                    'Checkbox',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 8),
                Semantics(
                  label: 'Agree to terms checkbox',
                  hint: 'Double tap to toggle',
                  toggled: _agreeToTerms,
                  child: CheckboxListTile(
                    key: const Key('checkbox_agree'),
                    value: _agreeToTerms,
                    title: const Text('I agree to the terms'),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value ?? false;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Semantics(
                  header: true,
                  label: 'Radio group section header',
                  child: Text(
                    'Grouped radio buttons',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 8),
                Semantics(
                  container: true,
                  label: 'Radio button group',
                  child: RadioGroup<RadioGroupValue>(
                    groupValue: _groupValue,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _groupValue = value;
                      });
                    },
                    child: Column(
                      children: [
                        Semantics(
                          label: 'Radio option A',
                          child: RadioListTile<RadioGroupValue>(
                            key: const Key('radio_option_a'),
                            title: const Text('Option A'),
                            value: RadioGroupValue.optionA,
                          ),
                        ),
                        Semantics(
                          label: 'Radio option B',
                          child: RadioListTile<RadioGroupValue>(
                            key: const Key('radio_option_b'),
                            title: const Text('Option B'),
                            value: RadioGroupValue.optionB,
                          ),
                        ),
                        Semantics(
                          label: 'Radio option C',
                          child: RadioListTile<RadioGroupValue>(
                            key: const Key('radio_option_c'),
                            title: const Text('Option C'),
                            value: RadioGroupValue.optionC,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Semantics(
                  button: true,
                  label: 'Go to second page button',
                  hint: 'Validates form and navigates',
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      key: const Key('button_go_second'),
                      onPressed: _goToSecondPage,
                      child: const Text('Go to second screen'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  static const routeName = '/second';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Second Screen'),
      ),
      body: SafeArea(
        child: Semantics(
          container: true,
          label: 'Second page',
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  header: true,
                  label: 'Second screen header',
                  child: Text(
                    'Second screen (for navigation test)',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 12),
                Semantics(
                  label: 'Second screen description text',
                  child: Text(
                    'This screen exists to validate navigation and basic semantics.',
                  ),
                ),
                const Spacer(),
                Semantics(
                  button: true,
                  label: 'Back button',
                  hint: 'Returns to first page',
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      key: const Key('button_back_first'),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Back'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../../providers/notes_provider.dart';

class EditCategoriesScreen extends StatelessWidget {
  const EditCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final provider = context.watch<NotesProvider>();
    final categories = provider.categories;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.editCategoriesTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ListTile(
              leading: const Icon(Icons.add),
              title: Text(
                tr.addCategory,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () => _showAddCategoryDialog(context),
            );
          }

          final category = categories[index - 1];

          return ListTile(
            leading: IconButton(
              icon: const Icon(Icons.label_outline),
              onPressed: () {},
            ),
            title: Text(category.name),
            trailing: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(tr.devlopment)));
              },
              icon: Icon(Icons.edit),
            ),
          );
        },
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(tr.addCategory),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: tr.categoryNameHint),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ctx.read<NotesProvider>().addCategory(
                  controller.text.trim(),
                  '111111',
                );
                Navigator.pop(ctx);
              }
            },
            child: Text(tr.add),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(tr.cancel),
          ),
        ],
      ),
    );
  }
}

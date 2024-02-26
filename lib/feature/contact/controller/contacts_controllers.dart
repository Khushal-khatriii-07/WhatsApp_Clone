import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clonee/feature/contact/repository/contact_repository.dart';

final contactControllerProvider = FutureProvider((ref) {
  final contactRepository = ref.watch(ContactsRepositoryProvider);
  return contactRepository.getAllContacts();
});
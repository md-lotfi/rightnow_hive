import 'package:hive/hive.dart';
import 'package:rightnow/models/form_entry.dart';

class FormEntryDao {
  Future<Box<FormEntry>> getFormEntryDb() async {
    return await Hive.openBox<FormEntry>('FormEntry');
  }

  //@Query("delete from FormEntry")
  Future<void> removeAllFormEntry() async {
    var r = await getFormEntryDb();
    await r.clear();
  }

  //@Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormEntry(List<FormEntry> formEntries) async {
    var r = await getFormEntryDb();
    await r.addAll(formEntries);
  }

  Future<void> setFormEntries(List<FormEntry> formEntries) async {
    await removeAllFormEntry();
    await insertFormEntry(formEntries);
  }
}

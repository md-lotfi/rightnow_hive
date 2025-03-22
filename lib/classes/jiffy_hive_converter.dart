import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/components/common_widgets.dart';

class JiffyAdapter extends TypeAdapter<Jiffy> {
  @override
  final typeId = 36;

  @override
  Jiffy read(BinaryReader reader) {
    final micros = reader.readInt();
    try {
      return Jiffy.parseFromMillisecondsSinceEpoch(micros);
    } catch (e) {
      return dateParser(null);
    }
    //.dateTime.fromMicrosecondsSinceEpoch(micros);
    //return Jiffy(reader.readString());
    /*final micros = reader.readInt();
    return DateTime.fromMicrosecondsSinceEpoch(micros);*/
  }

  @override
  void write(BinaryWriter writer, Jiffy obj) {
    writer.writeInt(obj.millisecondsSinceEpoch);
  }
}

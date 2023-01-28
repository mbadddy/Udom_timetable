import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CreateBlogg{
  Future create(title,body,venue,date,author_photo,blog_photo)async{
        Directory? dir=await getExternalStorageDirectory();
        print(dir!.path);
    }
}

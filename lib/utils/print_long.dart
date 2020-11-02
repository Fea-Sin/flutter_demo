/// print 打印日子有长度限制，超长部分会自动截断

int maxLength = 340;

void printLong(String log) {
  if (log.length < maxLength) {
    print(log);
  } else {
    while(log.length > maxLength) {
      print(log.substring(0, maxLength));
      log = log.substring(maxLength);
    }
    // 打印剩余部分
    print(log);
  }
}

void printKV(String key, Object value) {
  printLong('$key: $value');
}
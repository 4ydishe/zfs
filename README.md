README.MD
Домашняя работа ZFS
Для запуска VM машины требуется скачать все файлы с git репозитория и сложить в одном месте рядом с VagrantFile
В репозитории находится скрипт, который устанавливает ZFS, создает 4 RAID 1 пула, добавляет на каждый из них один из методов сжатия (lzjb, lz4, gzip, zle ) и скачивает на каждый пул файл для проверки метода сжатия
Начнем!
1. Проверим методы сжатия:
$zfs list
Таким образом, у нас получается, что алгоритм gzip-9 самый эффективный по сжатию.
2. Определение настроек пула
Скачиваем архив в домашний каталог:
$wget -O archive.tar.gz --no-check-certificate 'https://drive.usercontent.google.com/download?id=1MvrcEp-WgAQe57aDEzxSRalPAwbNN1Bb&export=download'
Разархивируем его:
[root@localhost ~]# tar -xzvf archive.tar.gz
zpoolexport/
zpoolexport/filea
zpoolexport/fileb
Проверим, возможно ли импортировать данный каталог в пул:
[root@localhost ~]# zpool import -d zpoolexport/
   pool: otus
     id: 6554193320433390805
  state: ONLINE
 action: The pool can be imported using its name or numeric identifier.
 config:

        otus                         ONLINE
          mirror-0                   ONLINE
            /root/zpoolexport/filea  ONLINE
            /root/zpoolexport/fileb  ONLINE
Сделаем импорт данного пула к нам в ОС:
[root@localhost ~]# zpool import -d zpoolexport/ otus
3. Работа со снапшотом, поиск сообщения от преподавателя
Скачаем файл, указанный в задании:
wget -O otus_task2.file --no-check-certificate https://drive.usercontent.google.com/download?id=1wgxjih8YZ-cqLqaZVa0lA3h3Y029c3oI&export=download
Восстановим файловую систему из снапшота:
#$zfs receive otus/test@today < otus_task2.file
Далее, ищем в каталоге /otus/test файл с именем “secret_message”:
find /otus/test -name "secret_message" /otus/test/task1/file_mess/secret_message
[root@localhost ~]# cat /otus/test/task1/file_mess/secret_message
https://otus.ru/lessons/linux-hl/

[root@localhost ~]# https://otus.ru/lessons/linux-hl/
Готово :)

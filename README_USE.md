# Программа для управления репозитариями.

Привет всем. Hi everyone. :wave:

Пока все изложу все кратко. 
So far, I will state everything briefly.

## Оглавление
1. [Общее описание](#Общее-описание)
2. [Описание использования](#Описание-использования)

## 1. Общее описание

Набор личных программ для автоматизации работы с Git.
Используется как альтернатива архиваторам.
Работа производиться в Microsoft Windows [https://www.microsoft.com/ru-ru/windows]

Будет использоваться для сохранения моих программ на GitHub. 
Позволяет, через запуск одного файла (в Windows командного файла):
 - создовать репозитарий (repo) Git локально
 - добавлять файлы в repo
 - делать автоматический коммит с привязкой к времени
 - отправить все изменения на GitHub (обновление удаленной ветки)

## 2. Описание использования

README_USE.md - этот файл

>`run_git.cmd` - Главный коммандный (пакетный) файл


### 2.1 Работа с репозитариями локально

>>`run_git.cmd.git.init.cmd` - создание репозитария в текущей папке и создание удаленного репозитария на GitHub с именем папки

>>`run_git.cmd.auto.commit.cmd` - выполнение команды commit

>>`run_git.cmd.auto.commit.add.cmd`

>>`run_git.cmd.auto.push.cmd` - выполнение команды push

>>`run_git.cmd.git.info.cmd` - информация о репозитарии

### 2.2. Работа с репозитариями - Управление ветками

>>`run_git.cmd.git.branch.cmd` - команда branch

>>`run_git.cmd.git.branch.new.cmd` - команда branch new

>>`run_git.cmd.git.checkout.cmd` - команда checkout

>>`run_git.cmd.git.checkout.master.cmd`- команда checkout master

### 2.3. Работа с репозитариями локально - GitHub

>>`run_git.cmd.github.create.cmd` - создание репозитария

>>`run_git.cmd.github.delete.cmd` - удаление репозитария


### 2.4. Вспомагательные

>>`run_git.cmd.clearlog.cmd` - Удаление всех логов `*.log`

>>`ProjectClean.cmd` - Удаление всех логов `*.log`

>>`run_git.cmd.createini.cmd`


5. Информационные

>>`run_git.cmd.help.cmd` - вывод помощи

>>`run_git.cmd.info.cmd` - вывод информации о установленных программах

6. Набор файлов для сканирования текущего катклога и подкаталогов на наличие репозитариев,
по завершению создаеться файл `run_git.cmd.auto.scan.ini` со списком папок и запуска пакетного режима

>>`run_git.cmd.auto.scan.cmd` - запуск скнирования

>>`run_git.cmd.auto.scan.run.cmd`

>>`run_git.cmd.auto.scan.run.commit.cmd` - запуск для всех репотазираев команды commit

>>`run_git.cmd.auto.scan.run.push.cmd` - запуск для всех репотазираев команды push


7. Набор файлов для тестирования

>>`run_git.cmd.test.cmd`

>>`run_git.cmd.test.debug.cmd`

>>`run_git.cmd.test.debug0.cmd`

>>`run_git.cmd.test.nodebug.cmd`

8. Набор файлов для установки программы в папку **%USERPROFILE%\.spbcmd**

>>`run_git.cmd.install.cmd`

>>`run_git.cmd.install.list-of-excluded-files.txt`


9. Используемые программы, ссылки:
Programs used, links:
1. **Git for Windows**	https://git-scm.com/download/win
2. **GitHub CLI**	https://cli.github.com/
3. **Far Manager**	https://farmanager.com/

Кое какие ссылки:
 How to echo with different colors in the Windows command line https://stackoverflow.com/questions/2048509/how-to-echo-with-different-colors-in-the-windows-command-line

____
УВЫ. ALAS! :raised_hands:
Перевод делал через Яндекс Переводчик.
The translation was done through Yandex Translator. https://translate.yandex.ru

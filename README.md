# README.md
# Программа для управления репозиториями.

![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)
![Batchfile](https://img.shields.io/badge/-Batchfile-090909?style=for-the-badge&logo=Batchfile&logoColor=097CDB)

![TEST](https://img.shields.io/badge/TEST-you_like-blue)

Привет всем. Hi everyone. :wave:

Пока все изложу все кратко.  
So far, I will state everything briefly.  

## Оглавление
1. [Общее описание](#Общее-описание)
2. [Описание параметров](#Описание-параметров)
                                                                                                                                          72
## Общее описание

Набор личных программ для автоматизации работы с Git  .
Используется как альтернатива архиваторам.
Работа производиться в Microsoft Windows [https://www.microsoft.com/ru-ru/windows]

Будет использоваться для сохранения моих программ на GitHub. 
Позволяет, через запуск одного файла (в Windows командного файла):
 - создовать репозиторий (repo) Git локально
 - добавлять файлы в repo
 - делать автоматический коммит с привязкой к времени
 - отправить все изменения на GitHub (обновление удаленной ветки)

## Описание параметров
```

run_git.cmd <command>

Команды:
    create folder       - создание локального репозитория в каталоге folder
                          в каталог копирует все необходимое, после создания все вызовы надо делать из folder
    createmaster        - создание главного репозитория на GitHub, для хранения этих утилит

Команды работа с репозиториями:
    gitinit             - созданиеи и ининциализация репозитория в текущей папке
    autopush            - отправляет все изменения в удаленный репозитория на GitHub
    autocommit		- автокоммит в текущей датой и временим
    remoteadd           - добавление удалённых репозиториев
    gitbranch           - команда для управления ветками в репозитории Git

Команды для GitHub:
    createhub           - создание удаленного репозитория на GitHub, для хранения созданного
    githubdelete        - удаление репозитория на GitHub

    info                - Информация, команда по умолчанию
    help                - Показать эту справку и выйти



```




So far, I will state everything briefly.  
A set of personal programs for automating work with Git.  
Used as an alternative to the archiver.  
The work is done in Microsoft Windows [https://www.microsoft.com/ru-ru/windows]  

Используемые программы, ссылки:  
Programs used, links:  
1. **Git for Windows**	https://git-scm.com/download/win
2. **GitHub CLI**	https://cli.github.com/
3. **Far Manager**	https://farmanager.com/
4. **MSYS2**		https://www.msys2.org/

Кое какие ссылки:  
 How to echo with different colors in the Windows command line https://stackoverflow.com/questions/2048509/how-to-echo-with-different-colors-in-the-windows-command-line

____
УВЫ. ALAS! :raised_hands:  
Перевод делал через `Яндекс Переводчик`.  
The translation was done through `Yandex Translator`. https://translate.yandex.ru  
Ответы и некоторый текст сформирован `YandexGPT` на основе текстов сайтов. В нём могут быть неточности.  

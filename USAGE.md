# Как использовать систему сборки книги

## Для читателей

### Скачать готовую книгу

1. Перейдите на страницу [Releases](../../releases)
2. Выберите последнюю версию
3. Скачайте файл в нужном формате:
   - **conifers-book.epub** — для большинства электронных книг и приложений
   - **conifers-book.mobi** — для Amazon Kindle
   - **conifers-book.pdf** — для чтения на компьютере или печати

## Для разработчиков

### Создание нового релиза

Когда книга готова к публикации, создайте тег версии:

```bash
# Убедитесь, что все изменения закоммичены
git add .
git commit -m "Финальная версия для релиза"
git push

# Создайте тег версии (например, v1.0)
git tag -a v1.0 -m "Первый релиз книги"

# Отправьте тег на GitHub
git push origin v1.0
```

После отправки тега автоматически запустится GitHub Actions workflow, который:
1. Установит все необходимые зависимости (Pandoc, Calibre, LaTeX)
2. Соберёт книгу во всех форматах (EPUB, MOBI, PDF)
3. Создаст новый релиз на GitHub
4. Прикрепит собранные файлы к релизу

Процесс занимает около 5-10 минут. Следить за прогрессом можно на вкладке "Actions" в репозитории.

### Локальная сборка

#### Установка зависимостей

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install pandoc calibre texlive-xetex texlive-fonts-recommended texlive-lang-cyrillic fonts-dejavu
```

**macOS:**
```bash
# Установите Homebrew, если ещё не установлен: https://brew.sh
brew install pandoc
brew install --cask calibre
brew install --cask mactex
```

**Windows:**
- Скачайте и установите [Pandoc](https://pandoc.org/installing.html)
- Скачайте и установите [Calibre](https://calibre-ebook.com/download)
- Скачайте и установите [MiKTeX](https://miktex.org/download) или [TeX Live](https://www.tug.org/texlive/)

#### Сборка книги

```bash
# Собрать все форматы
make all

# Собрать только EPUB
make epub

# Собрать только MOBI (требует EPUB)
make mobi

# Собрать только PDF
make pdf

# Очистить собранные файлы
make clean

# Показать справку
make help
```

Собранные файлы будут в директории `build/`.

### Редактирование книги

#### Структура файлов

```
chapters/
├── 00-introduction.md              # Введение
├── 01-birth-of-conifers.md         # Глава 1: Рождение хвойных
├── 02-epochs.md                     # Глава 2: Эпохи расцвета
├── 03-conifers-and-humans.md       # Глава 3: Хвойные и человек
├── 04-pinaceae.md                   # Глава 4: Сосновые
├── 05-cupressaceae.md               # Глава 5: Кипарисовые
├── 06-09-rare-families.md           # Главы 6-9: Другие семейства
├── 10-12-internal-life.md           # Главы 10-12: Внутренняя жизнь
├── 13-17-world-and-future.md        # Главы 13-17: Мир вокруг и будущее
└── 18-conclusion-appendices.md      # Послесловие и приложения
```

#### Добавление нового контента

1. Откройте нужный файл в текстовом редакторе
2. Редактируйте используя [Markdown синтаксис](https://www.markdownguide.org/basic-syntax/)
3. Сохраните изменения
4. Соберите книгу заново: `make epub`

#### Добавление изображений

1. Поместите изображение в директорию `images/`
2. Вставьте в текст:
   ```markdown
   ![Описание изображения](images/your-image.png)
   ```

#### Изменение метаданных

Отредактируйте файл `metadata.yaml`:
```yaml
---
title: "Название книги"
subtitle: "Подзаголовок"
author: "Автор"
lang: ru
date: 2024
---
```

### Устранение проблем

#### Ошибка: "pandoc: command not found"
Установите Pandoc согласно инструкциям выше.

#### Ошибка: "ebook-convert: command not found"
Установите Calibre. MOBI можно не создавать, если это не критично.

#### Ошибка при создании PDF
Убедитесь, что установлен XeLaTeX и русские шрифты:
```bash
sudo apt-get install texlive-xetex texlive-lang-cyrillic fonts-dejavu
```

#### GitHub Actions не создаёт релиз
- Проверьте, что тег начинается с 'v' (например, v1.0, v2.1)
- Проверьте логи в разделе Actions
- Убедитесь, что у репозитория есть права на создание релизов

### Настройка build.sh

Если нужно изменить порядок глав или добавить новые:

1. Откройте `scripts/build.sh`
2. Найдите секцию `CHAPTERS=(`
3. Добавьте или измените пути к файлам глав
4. Сохраните и запустите сборку

Пример:
```bash
CHAPTERS=(
    "chapters/00-introduction.md"
    "chapters/01-new-chapter.md"  # Добавлена новая глава
    "chapters/02-epochs.md"
    # ... остальные главы
)
```

## Советы по работе

### Проверка перед релизом

1. Соберите книгу локально: `make all`
2. Откройте EPUB в программе для чтения (Calibre, Apple Books, etc.)
3. Проверьте оглавление
4. Просмотрите несколько глав на предмет форматирования
5. Если всё в порядке — создавайте тег и релиз

### Версионирование

Рекомендуемая схема версий:
- `v1.0` — первый полный релиз
- `v1.1` — небольшие исправления и дополнения
- `v2.0` — крупные изменения в структуре или добавление новых частей

### Работа с изменениями

```bash
# Посмотреть статус
git status

# Добавить изменённые файлы
git add chapters/01-birth-of-conifers.md

# Закоммитить
git commit -m "Исправлены опечатки в главе 1"

# Отправить на GitHub
git push
```

## Полезные ресурсы

- [Pandoc документация](https://pandoc.org/MANUAL.html)
- [Markdown guide](https://www.markdownguide.org/)
- [Calibre documentation](https://manual.calibre-ebook.com/)
- [GitHub Actions documentation](https://docs.github.com/en/actions)

## Контакты и поддержка

Если у вас возникли вопросы или проблемы:
1. Проверьте этот документ
2. Посмотрите [Issues](../../issues) — возможно, вопрос уже обсуждался
3. Создайте новый Issue с описанием проблемы

---

Удачи в создании и распространении книги! 📚🌲

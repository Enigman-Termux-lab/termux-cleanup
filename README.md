<div align="center">

# 🧹 Termux Cleanup

### *Безопасная очистка дискового пространства и кэшей в Android Termux*

[![Termux](https://img.shields.io/badge/Termux-Android-000000?style=for-the-badge&logo=termux&logoColor=white)](https://termux.dev/)
[![Bash](https://img.shields.io/badge/Bash-Automation-2B35AF?style=for-the-badge&logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Storage](https://img.shields.io/badge/Android-Storage_Saver-4EAA25?style=for-the-badge&logo=android&logoColor=white)](https://www.android.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

<br/>

**Termux Cleanup** — готовый инструментарий и скилл для безопасного освобождения дискового пространства в среде Termux на Android. Утилита очищает временные кэши пакетных менеджеров и устаревшие хранилища, гарантируя неприкосновенность рабочих проектов, пользовательских конфигураций и данных AI-агентов.

---

</div>

> [!NOTE]
> 🌐 **Этот проект является частью экосистемы [Enigman Termux Lab](https://github.com/Enigman-Termux-lab)** — открытой лаборатории автономных AI-агентов и системных инструментов для Android Termux.  
> 📌 **Главный хаб и полный каталог инструментов:** [github.com/Enigman-Termux-lab](https://github.com/Enigman-Termux-lab)

## 🎯 Что очищается безопасно

Скрипт выполняет очистку только временных файлов, которые при необходимости автоматически перекачиваются:

| Компонент | Расположение | Описание |
| :--- | :--- | :--- |
| **apt-кэш** | `pkg clean` | Скачанные архивы пакетов Termux (`.deb`) |
| **npm кэш и логи** | `~/.npm/_cacache`, `~/.npm/_logs` | Временные кэши npm и журналы установок |
| **node-gyp кэш** | `~/.cache/node-gyp` | Заголовки и временные артефакты компиляции нативных модулей |
| **старые версии pnpm store** | `~/.local/share/pnpm/store/v*` | Удаляются только устаревшие форматы стора; **активная версия сохраняется** |
| **pip кэш** | `~/.cache/pip` | Кэш скачанных wheel и tar.gz пакетов Python |
| **npx логи** | `~/.npm/_npx` | Логи и остаточные данные временных запусков `npx` |

---

## 🛡️ Гарантии безопасности: что никогда не удаляется

Утилита строго соблюдает правила изоляции данных и **никогда не затрагивает**:
- **Конфигурации и рабочие данные CLI-агентов:** `~/.happy`, `~/.claude`, `~/.gemini`, `~/.codex`, `~/.hermes`, `~/.agents` и другие каталоги `~/.<progname>`.
- **Системные настройки Termux:** `~/.termux/` (шрифты, цветовые схемы, keybindings).
- **Активный стор pnpm:** `~/.local/share/pnpm/store/v<актуальная>`.
- **Рабочие проекты и репозитории:** каталоги `~/projects/`, `~/storage/` и пользовательские папки.

---

## 🚀 Установка и быстрый запуск

### 1. Клонирование репозитория
```bash
git clone https://github.com/Enigman-Termux-lab/termux-cleanup.git ~/projects/lab-termux-cleanup
cd ~/projects/lab-termux-cleanup
```

### 2. Прямой запуск скрипта
```bash
./scripts/cleanup.sh
```
Скрипт замерит объём до и после очистки и выведет точное количество освобождённых мегабайт:
```text
🧹 Termux Cleanup
==================
Занято до: 2450 MB

→ apt-кеш...
  ✓ готово
→ npm-кеш и логи...
  ✓ готово
...
==================
Занято после: 1810 MB
🎉 Освобождено: 640 MB
```

### 3. Настройка ярлыка для Termux:Widget
Чтобы запускать очистку в один тап с рабочего стола смартфона:
```bash
mkdir -p ~/.shortcuts
cp scripts/cleanup.sh ~/.shortcuts/cleanup.sh
chmod 700 ~/.shortcuts/cleanup.sh
```

---

## 📊 Полезные команды для диагностики диска

Если места по-прежнему мало, используйте проверенные команды анализа:

- **Топ-25 самых больших директорий в Home:**
  ```bash
  du -sh ~/.* ~/* 2>/dev/null | grep -E '^\s*[0-9.]+[MG]' | sort -hr | head -25
  ```
- **Интерактивный анализ через `ncdu`:**
  ```bash
  pkg install -y ncdu
  ncdu ~
  ```
- **Поиск забытых архивов в домашней папке:**
  ```bash
  find ~ -maxdepth 2 -type f \( -name "*.tgz" -o -name "*.tar.gz" \) -exec ls -lh {} \;
  ```

---

## 📄 Лицензия

Распространяется под лицензией [MIT](LICENSE). Разработано для открытой экосистемы **[Enigman-Termux-lab](https://github.com/Enigman-Termux-lab)**.

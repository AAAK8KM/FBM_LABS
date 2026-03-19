#!/bin/bash

# Директория, где лежат папки с проектами
SOURCE_DIR="/workspace"

# Проверяем, существует ли директория
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Ошибка: Директория $SOURCE_DIR не найдена."
    exit 1
fi

echo "Начинаем компиляцию проектов в $SOURCE_DIR..."

# Счетчик ошибок
errors=0

# Проходим по всем непосредственным подпапкам
for dir in "$SOURCE_DIR"/*/; do
    # Если папка пустая (цикл не сработал), пропускаем
    [ -d "$dir" ] || continue
    
    # Ищем первый .tex файл в папке
    tex_file=$(find "$dir" -maxdepth 1 -name "*.tex" -type f | head -n 1)
    
    if [ -n "$tex_file" ]; then
        echo "----------------------------------------"
        echo "Обработка папки: $(basename "$dir")"
        echo "Найден файл: $tex_file"
        
        # Запускаем latexmk в режиме PDF
        # -pdf: создать PDF
        # -interaction=nonstopmode: не останавливаться на ошибках ввода
        # -cd: менять директорию на где лежит файл (чтобы aux файлы не мусорили)
        if latexmk -pdf -interaction=nonstopmode -cd "$tex_file"; then
            echo "Успешно: $(basename "$tex_file")"
        else
            echo "ОШИБКА при компиляции: $(basename "$tex_file")"
            ((errors++))
        fi
        
        # Очистка временных файлов (опционально, уберите -c, если нужны .log/.aux)
        # latexmk -c "$tex_file" 
    else
        echo "Пропущено: $dir (нет файлов .tex)"
    fi
done

echo "----------------------------------------"
if [ $errors -gt 0 ]; then
    echo "Завершено с ошибками: $errors сбоев."
    exit 1
else
    echo "Все проекты успешно скомпилированы!"
    exit 0
fi
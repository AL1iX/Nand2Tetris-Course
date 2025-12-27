// Программа для рисования смайла при нажатии стрелок и очистки экрана при других клавишах

//   current_pos = 0, previous_pos = 0
//   while true:
//       key = KBD
//       if key == LEFT: current_pos = 3978
//       if key == UP: current_pos = 2640
//       if key == RIGHT: current_pos = 3989
//       if key == DOWN: current_pos = 5296
//       else: current_pos = 0
//
//       if current_pos != previous_pos:
//           clear_smile(previous_pos)
//           if current_pos != 0:
//               draw_smile(current_pos)
//           previous_pos = current_pos

// Инициализация переменных для хранения позиций смайла
@current_pos
M=0         // Текущая позиция смайла (0 = смайл не отображается)
@previous_pos
M=0         // Предыдущая позиция смайла

(LOOP)
    // Чтение клавиатуры и проверка нажатых клавиш
    // Проверка клавиши LEFT (код 130)
    @KBD
    D=M
    @130
    D=D-A
    @LEFT
    D;JEQ
    
    // Проверка клавиши UP (код 131)
    @KBD
    D=M
    @131
    D=D-A
    @UP
    D;JEQ
    
    // Проверка клавиши RIGHT (код 132)
    @KBD
    D=M
    @132
    D=D-A
    @RIGHT
    D;JEQ
    
    // Проверка клавиши DOWN (код 133)
    @KBD
    D=M
    @133
    D=D-A
    @DOWN
    D;JEQ
    
    // Если нажата другая клавиша - сбрасываем текущую позицию
    @current_pos
    M=0
    
    // Если ранее был нарисован смайл - очищаем его
    @previous_pos
    D=M
    @CLEAR
    D;JNE
    
    // Продолжаем цикл опроса клавиатуры
    @LOOP
    0;JMP

// Обработка нажатия стрелки LEFT
(LEFT)
    // Вычисляем позицию для LEFT: top=124, left=160 -> 124*32 + 160/16 = 3978
    @3978
    D=A
    @current_pos
    M=D
    // Проверяем, нужно ли перерисовывать смайл
    @CHECK_POSITION
    0;JMP

// Обработка нажатия стрелки UP
(UP)
    // Вычисляем позицию для UP: top=82, left=256 -> 82*32 + 256/16 = 2640
    @2640
    D=A
    @current_pos
    M=D
    // Проверяем, нужно ли перерисовывать смайл
    @CHECK_POSITION
    0;JMP

// Обработка нажатия стрелки RIGHT
(RIGHT)
    // Вычисляем позицию для RIGHT: top=124, left=336 -> 124*32 + 336/16 = 3989
    @3989
    D=A
    @current_pos
    M=D
    // Проверяем, нужно ли перерисовывать смайл
    @CHECK_POSITION
    0;JMP

// Обработка нажатия стрелки DOWN
(DOWN)
    // Вычисляем позицию для DOWN: top=165, left=256 -> 165*32 + 256/16 = 5296
    @5296
    D=A
    @current_pos
    M=D
    // Проверяем, нужно ли перерисовывать смайл
    @CHECK_POSITION
    0;JMP

// Проверка изменения позиции смайла
(CHECK_POSITION)
    // Сравниваем текущую и предыдущую позиции
    @current_pos
    D=M
    @previous_pos
    D=D-M
    
    // Если позиция не изменилась - продолжаем цикл
    @LOOP
    D;JEQ
    
    // Если позиция изменилась - очищаем старый смайл
    @CLEAR
    0;JMP

// Рисование смайла в текущей позиции
(PAINT)
    // Вычисляем абсолютный адрес и рисуем строки смайла
    
    // Строка 1: 0001110000111000 = 7224
    @current_pos
    D=M
    @SCREEN
    D = D+A
    @pos
    M=D
    @7224
    D=A
    @pos
    A=M
    M=D

    // Строка 2: 0001110000111000 = 7224
    @32
    D=A
    @pos
    M=M+D  // current_pos + SCREEN + 32
    @7224
    D=A
    @pos
    A=M
    M=D

    // Строка 3: 0001110000111000 = 7224
    @32
    D=A
    @pos
    M=M+D  // current_pos + SCREEN + 64
    @7224
    D=A
    @pos
    A=M
    M=D

    // Строка 6: 0110000000000110 = 24582
    @96
    D=A
    @pos
    M=M+D  // current_pos + SCREEN + 160
    @24582
    D=A
    @pos
    A=M
    M=D

    // Строка 7: 0011100000011100 = 14364
    @32
    D=A
    @pos
    M=M+D  // current_pos + SCREEN + 192
    @14364
    D=A
    @pos
    A=M
    M=D

    // Строка 8: 0000111111110000 = 4080
    @32
    D=A
    @pos
    M=M+D  // current_pos + SCREEN + 224
    @4080
    D=A
    @pos
    A=M
    M=D

    // Сохраняем текущую позицию как предыдущую
    @current_pos
    D=M
    @previous_pos
    M=D

    // Возвращаемся к опросу клавиатуры
    @LOOP
    0;JMP

// Очистка смайла из предыдущей позиции
(CLEAR)
    // Очищаем все строки смайла в предыдущей позиции
    
    @previous_pos
    D=M

    // Строка 1
    @SCREEN
    A = D+A
    M = 0

    // Строка 2
    @16416  // SCREEN + 32
    A = D+A
    M = 0

    // Строка 3
    @16448  // SCREEN + 64
    A = D+A
    M = 0

    // Строка 6
    @16544  // SCREEN + 160
    A = D+A
    M = 0

    // Строка 7
    @16576  // SCREEN + 192
    A = D+A
    M = 0

    // Строка 8
    @16608  // SCREEN + 224
    A = D+A
    M = 0

    // Сбрасываем предыдущую позицию
    @previous_pos
    M=0

    // Проверяем, нужно ли рисовать смайл в новой позиции
    @current_pos
    D=M
    
    // Если текущая позиция = 0 (другая клавиша) - продолжаем цикл
    @LOOP
    D;JEQ
    
    // Если установлена новая позиция - рисуем смайл
    @PAINT
    0;JMP
section .data
    message db "Digite uma palavra: ", 0
    message_len equ $ - message
    letter_prompt db "Digite uma letra: ", 0
    letter_prompt_len equ $ - letter_prompt
    result_string db "Ocorrências da letra: ", 0
    result_length db "Tamanho da palavra: ", 0
    buffer db 100  ; Buffer para armazenar a palavra
    buffer_len equ 100
    result_buffer db 10  ; Buffer para armazenar o resultado

section .text
    global _start

_start:
    ; Imprime a mensagem para digitar a palavra
    mov eax, 4        ; Número da chamada do sistema para escrever
    mov ebx, 1        ; Descritor de arquivo (stdout)
    mov ecx, message  ; Mensagem a ser impressa
    mov edx, message_len  ; Comprimento da mensagem
    int 0x80          ; Executa a chamada do sistema

    ; Lê a palavra digitada pelo usuário
    mov eax, 3        ; Número da chamada do sistema para ler
    mov ebx, 0        ; Descritor de arquivo (stdin)
    mov ecx, buffer   ; Buffer para armazenar a palavra
    mov edx, buffer_len  ; Número máximo de bytes a serem lidos
    int 0x80          ; Executa a chamada do sistema

    ; Imprime a mensagem para digitar a letra
    mov eax, 4        ; Número da chamada do sistema para escrever
    mov ebx, 1        ; Descritor de arquivo (stdout)
    mov ecx, letter_prompt  ; Mensagem a ser impressa
    mov edx, letter_prompt_len  ; Comprimento da mensagem
    int 0x80          ; Executa a chamada do sistema

    ; Lê a letra digitada pelo usuário
    mov eax, 3        ; Número da chamada do sistema para ler
    mov ebx, 0        ; Descritor de arquivo (stdin)
    mov ecx, result_buffer   ; Buffer para armazenar a letra
    mov edx, 2        ; Número máximo de bytes a serem lidos (letra + null terminator)
    int 0x80          ; Executa a chamada do sistema

    ; Conta as ocorrências da letra na palavra
    xor eax, eax      ; Limpa o registrador EAX (contador de ocorrências)
    xor ebx, ebx      ; Limpa o registrador EBX (índice para percorrer a palavra)
    xor ecx, ecx      ; Limpa o registrador ECX (tamanho da palavra)
count_occurrences:
    mov al, byte [buffer + ebx]  ; Carrega um caractere da palavra
    cmp al, 0         ; Verifica se é o final da palavra (null terminator)
    je print_result   ; Se for, pula para imprimir o resultado
    cmp al, byte [result_buffer]  ; Compara o caractere com a letra digitada
    je increment_counter  ; Se for igual, incrementa o contador de ocorrências
    inc ebx           ; Incrementa o índice para percorrer a palavra
    inc ecx           ; Incrementa o tamanho da palavra
    jmp count_occurrences  ; Pula para a próxima iteração

increment_counter:
    inc eax           ; Incrementa o contador de ocorrências
    inc ebx           ; Incrementa o índice para percorrer a palavra
    inc ecx           ; Incrementa o tamanho da palavra
    jmp count_occurrences  ; Pula para a próxima iteração

print_result:
    ; Converte o contador de ocorrências para uma string
    mov esi, eax      ; Move o valor do contador de ocorrências para ESI
    mov eax, 0x0a     ; Valor ASCII para o caractere de nova linha (line feed)
    mov edi, result_buffer + 1  ; Pula o primeiro byte para armazenar o resultado
    sub edi, 2        ; Ajusta o ponteiro para trás em 2 bytes (tamanho fixo da string)
    mov byte [edi], al  ; Armazena o caractere de nova linha

    mov eax, esi      ; Move o valor do contador de ocorrências de volta para EAX
convert_to_string:
    xor edx, edx      ; Limpa o registrador EDX (parte alta do valor)
    mov ebx, 10       ; Divisor para converter em base decimal
    div ebx           ; Divide EAX por EBX (resultado em EAX, resto em EDX)
    add dl, '0'       ; Converte o resto em um caractere ASCII
    dec edi           ; Move o ponteiro para a próxima posição na string
    mov byte [edi], dl  ; Armazena o caractere na string
    test eax, eax     ; Verifica se o quociente é zero
    jnz convert_to_string  ; Se não for zero, continua a conversão

    ; Imprime a quantidade de ocorrências da letra
    mov eax, 4        ; Número da chamada do sistema para escrever
    mov ebx, 1        ; Descritor de arquivo (stdout)
    mov ecx, result_string  ; Mensagem a ser impressa
    mov edx, result_length  ; Comprimento da mensagem
    int 0x80          ; Executa a chamada do sistema

    mov eax, 4        ; Número da chamada do sistema para escrever
    mov ebx, 1        ; Descritor de arquivo (stdout)
    mov ecx, edi      ; String com o resultado (contador de ocorrências)
    sub edx, edi      ; Comprimento da string (tamanho fixo - posição atual)
    int 0x80          ; Executa a chamada do sistema

    ; Imprime o tamanho da palavra
    mov eax, 4        ; Número da chamada do sistema para escrever
    mov ebx, 1        ; Descritor de arquivo (stdout)
    mov ecx, result_length  ; Mensagem a ser impressa
    mov edx, result_length  ; Comprimento da mensagem
    int 0x80          ; Executa a chamada do sistema

    mov eax, 4        ; Número da chamada do sistema para escrever
    mov ebx, 1        ; Descritor de arquivo (stdout)
    mov ecx, ecx      ; Tamanho da palavra (em ECX)
    sub edx, edx      ; Limpa o registrador EDX
    add edx, '0'      ; Converte o tamanho em um caractere ASCII
    int 0x80          ; Executa a chamada do sistema

    ; Finaliza o programa
    mov eax, 1        ; Número da chamada do sistema para sair
    xor ebx, ebx      ; Código de saída 0
    int 0x80          ; Executa a chamada do sistema

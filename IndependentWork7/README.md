# Самостійна робота 7

## Функція

```c
void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}
```

## Асемблерний код

### x86-64

```asm
swap:
        pushq   %rbp
        movq    %rsp, %rbp
        movq    %rdi, -8(%rbp)
        movq    %rsi, -16(%rbp)
        movq    -8(%rbp), %rax
        movl    (%rax), %eax
        movl    %eax, -20(%rbp)
        movq    -16(%rbp), %rax
        movl    (%rax), %ecx
        movq    -8(%rbp), %rax
        movl    %ecx, (%rax)
        movl    -20(%rbp), %ecx
        movq    -16(%rbp), %rax
        movl    %ecx, (%rax)
        popq    %rbp
        retq
```

Прапорці: `-O0 -g0 -fno-asynchronous-unwind-tables -fno-unwind-tables`.

### ARM64 (AArch64)

```asm
swap:
        sub     sp, sp, #32
        str     x0, [sp, #24]
        str     x1, [sp, #16]
        ldr     x8, [sp, #24]
        ldr     w8, [x8]
        str     w8, [sp, #12]
        ldr     x8, [sp, #16]
        ldr     w8, [x8]
        ldr     x9, [sp, #24]
        str     w8, [x9]
        ldr     w8, [sp, #12]
        ldr     x9, [sp, #16]
        str     w8, [x9]
        add     sp, sp, #32
        ret
```

Прапорці: `-O0 -g0 -fno-asynchronous-unwind-tables -fno-unwind-tables --target=aarch64-linux-gnu`.

### RISC-V (RV64GC)

```asm
swap:
        addi    sp, sp, -48
        sd      ra, 40(sp)
        sd      s0, 32(sp)
        addi    s0, sp, 48
        sd      a0, 24(sp)
        sd      a1, 16(sp)
        ld      a0, 24(sp)
        lw      a0, 0(a0)
        sw      a0, 12(sp)
        ld      a0, 16(sp)
        lw      a0, 0(a0)
        ld      a1, 24(sp)
        sw      a0, 0(a1)
        lw      a0, 12(sp)
        ld      a1, 16(sp)
        sw      a0, 0(a1)
        ld      ra, 40(sp)
        ld      s0, 32(sp)
        addi    sp, sp, 48
        ret
```

Прапорці: `-O0 -g0 -fno-asynchronous-unwind-tables -fno-unwind-tables --target=riscv64-linux-gnu -march=rv64gc -mabi=lp64d`.

## Кількість інструкцій

| Архітектура | Кількість інструкцій |
|---|---:|
| x86-64 | 16 |
| ARM64 (AArch64) | 15 |
| RISC-V (RV64GC) | 20 |

## Регістри аргументів і результату

| Архітектура | Регістри аргументів | Регістр результату |
|---|---|---|
| x86-64 (System V ABI) | `a` — `%rdi`, `b` — `%rsi` | Немає: функція має тип `void` |
| ARM64 (AArch64) | `a` — `x0`, `b` — `x1` | Немає: функція має тип `void` |
| RISC-V (RV64GC) | `a` — `a0`, `b` — `a1` | Немає: функція має тип `void` |

## Висновок

У цьому прикладі RV64GC має 20 інструкцій, більше за x86-64 (16) та AArch64 (15), переважно через додаткове збереження й відновлення `ra`/`s0` і більший стековий кадр, згенеровані Clang при `-O0`. Це не доводить, що RISC-V завжди потребує більше команд: результат залежить від компілятора, ABI та оптимізації. Обмін вимагає завантажити значення з пам’яті й записати їх за іншими адресами. У RISC-архітектурах ці доступи виконуються окремими load/store-командами; обчислення не може напряму читати чи записувати пам’ять, що робить формат інструкцій простішим і регулярнішим.
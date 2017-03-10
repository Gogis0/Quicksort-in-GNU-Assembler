.global sort

.data
.bss
.text

sort:
    push %ebp
    mov %esp, %ebp
    push %ebx
    push %esi
    push %edi

    # store array pointer in ecx
    mov 8(%ebp), %ecx
    # left index in eax
    mov 12(%ebp), %eax
    # right index in ebx
    mov 16(%ebp), %ebx
    
    cmp %eax, %ebx
    jle return

    # eax will hold a pivot, edx will serve as an iterator
    mov %eax, %edx
    # esi is boundary = left
    mov %eax, %esi

loop:
    inc %edx

    cmp %edx, %ebx
    jle cont 
    
    # if (array[i] > array[left]) {
    mov (%ecx, %eax, 4), %edi
    cmp %edi, (%ecx, %edx, 4)
    jle loop

    # swap(array[edx], array[++boundary])
    # swap will be done through esi
    inc %esi
    
    mov (%ecx, %esi, 4), %edi
    xchg (%ecx, %edx, 4), %edi
    mov %edi, (%ecx, %esi, 4)
    jmp loop

cont:
    # swap(array[left], array[boundary])
    mov (%ecx, %eax, 4), %edi
    xchg (%ecx, %esi, 4), %edi
    mov %edi, (%ecx, %eax, 4)

    push %esi
    push %eax
    push %ecx
    inc %esi
    push %ebx
    push %esi
    push %ecx

    # quicksort(arr, left, boundary)
    call sort
    add $12, %esp

    # quicksort(arr, boundary + 1, right)
    call sort
    add $12, %esp

return:
    pop %edi
    pop %esi
    pop %ebx
    mov %ebp, %esp
    pop %ebp
    ret



;Nama : Nadya Prita Ramadhani
;NIM : 2200018127

org 100h
jmp start      
msg : db    "==============================================",0dh,0ah
msg2: db    "SELAMAT DATANG DI PROGRAM KALKULATOR SEDERHANA ",0dh,0ah
msg3: db    "============================================== ",0dh,0ah
msg4: db    "SILAHKAN PILIH MENU : ",0dh,0ah   
msg5: db    "1.TAMBAH",0dh,0ah,"2.KURANG",0dh,0ah,"3.KALI",0dh,0ah,"4.BAGI",0dh,0ah, '$'
msg6: db    0dh,0ah,"Masukkan Angka Pertama : $"
msg7: db    0dh,0ah,"Masukkan Angka Kedua : $"
msg8: db    0dh,0ah,"Error! $"
msg9: db    0dh,0ah,"Hasil : $"
msg10: db   0dh,0ah, 'Terimakasih, keluar dan coba lagi!',0dh,0ah, '$'

start: mov ah,9
       mov dx, offset msg
       int 21h
       mov ah,0
       int 16h
       cmp al,31h
       je Tambah
       cmp al,32h
       je Kurang
       cmp al,33h
       je Kali
       cmp al,34h
       je Bagi
       mov ah,09h
       mov dx, offset msg8
       int 21h
       mov ah,0
       int 16h
       jmp start

Tambah: mov ah,09h
        mov dx, offset msg6
        int 21h
        mov cx,0
        call TambahNmr
        push dx
        mov ah,9
        mov dx, offset msg7
        int 21h
        mov cx,0
        call TambahNmr
        pop bx
        add dx,bx
        push dx
        mov ah,9
        mov dx, offset msg9
        int 21h
        mov cx,10000
        pop dx
        call Tampil
        jmp End

TambahNmr: mov ah,0
           int 16h
           mov dx,0
           mov bx,1
           cmp al,0dh
           je FormNmr
           sub ax,30h
           call TampilNmr
           mov ah,0
           push ax
           inc cx
           jmp TambahNmr

FormNmr: pop ax
         push dx
         mul bx
         pop dx
         add dx,ax
         mov ax,bx
         mov bx,10
         push dx
         mul bx
         pop dx
         mov bx,ax
         dec cx
         cmp cx,0
         jne FormNmr
         ret

Tampil: mov ax,dx
        mov dx,0
        div cx
        call TampilNmr
        mov bx,dx
        mov dx,0
        mov ax,cx
        mov cx,10
        div cx
        mov dx,bx
        mov cx,ax
        cmp ax,0
        jne Tampil
        ret

TampilNmr: push ax
           push dx
           mov dx,ax
           add dl,30h
           mov ah,2
           int 21h
           pop dx
           pop ax
           ret

End: mov dx,offset msg10
        mov ah, 09h
        int 21h
        
        
        mov ah,0
        int 16h
        
        ret 

Kurang: mov ah,09h
        mov dx, offset msg6
        int 21h
        mov cx,0
        call TambahNmr
        push dx
        mov ah,9
        mov dx, offset msg7
        int 21h
        mov cx,0
        call TambahNmr
        pop bx
        sub bx,dx
        mov dx,bx
        push dx
        mov ah,9
        mov dx, offset msg9
        int 21h
        mov cx,10000
        pop dx
        call Tampil
        jmp End

Kali: mov ah,09h
      mov dx, offset msg6
      int 21h
      mov cx,0
      call TambahNmr
      push dx
      mov ah,9
      mov dx, offset msg7
      int 21h
      mov cx,0
      call TambahNmr
      pop bx 
      mov ax,dx
      mul bx
      mov dx,ax
      push dx
      mov ah,9
      mov dx, offset msg9
      int 21h
      mov cx,10000
      pop dx
      call Tampil
      jmp End   

Bagi: mov ah,09h
      mov dx, offset msg6
      int 21h
      mov cx,0
      call TambahNmr
      push dx
      mov ah,9
      mov dx, offset msg7
      int 21h
      mov cx,0
      call TambahNmr
      pop bx 
      mov ax,bx
      mov cx,dx
      mov dx,0
      mov bx,0
      div cx
      mov bx,dx
      mov dx,ax
      push bx
      push dx
      mov ah,9
      mov dx, offset msg9
      int 21h
      mov cx,10000
      pop dx
      call Tampil
      pop bx
      cmp bx,0
      je End
      jmp End
ret
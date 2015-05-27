; @author 
;   1. Muhammad Alvian S (G64130046)
;   2. Tri Setio Br (G64130070)

%include "printNum.asm"
%include "scanNum.asm"

section .text
    global main
global main

main:

    ;cetak kalimat pilihan paket
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_paket
    mov edx, len_msg_paket
    int 0x80
    jmp input_paket

    ;input paket soal 1 atau 2
input_paket:
    call scanNum
    cmp eax, 1
    je tipesoal1
    cmp eax, 2
    je tipesoal2
    jmp paketsalah

    
    ;cetak kalimat pilihan paket
paketsalah:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_paketsalah
    mov edx, len_msg_paketsalah
    int 0x80
    jmp input_paket
    
tipesoal1:
    ;buka soal
    mov eax, 5
    mov ebx, sl1
    mov ecx, 0
    mov edx, 777
    int 0x80    
    mov dword[isi_file], eax
    mov ecx, 0
    ;akhir buka soal
    ;baca soal
    mov eax, 3
    mov ebx, [isi_file]
    mov ecx, soalan
    mov edx, 10000
    int 0x80
    ;akhir baca soal
    ;cetak soal
    mov eax, 4
    mov ebx, 1
    mov ecx, soalan
    mov edx, 10000
    int 0x80
    ;akhir cetak soal

    ;cetak kalimat jawaban
kalimat1:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len_msg2
    int 0x80

loopjawaban: ;ambil jawaban

    mov eax, 3
    mov ebx, 0
    mov ecx, jawaban
    mov edx, 2
    int 0x80
    ;cek apakah inputan sudah sesuai a b c d
    cmp byte[jawaban],'a'
    jne cek_b
balikan1:
    ;ambil kuncian1
    mov al, [ecx] 
    inc ecx
    ;akhir ambil kuncian1
    mov edx, [total]
    cmp al, [kuncian1+4*edx]; jawab
    ;add dword[cjawaban],1
    je cek

balikan2:
    add dword[total], 1 
    sub dword[jumlah], 1
    cmp dword [jumlah], 0
    jne loopjawaban
    jmp cetakan

cek:
    add dword[coba],  1;cek1
    jmp balikan2

cek_b:
    cmp byte[jawaban],'b'
    jne cek_c
    jmp balikan1
cek_c:
    cmp byte[jawaban], 'c'
    jne cek_d
    jmp balikan1    
cek_d:
    cmp byte[jawaban], 'd'
    jne cek_e
    jmp balikan1
cek_e:
    cmp byte[jawaban], 'e'
    jne peringatan
    jmp balikan1
peringatan:
    ;cetak peringatan
    mov eax, 4
    mov ebx, 1
    mov ecx, peringatan_msg
    mov edx, 37
    int 0x80
    jmp loopjawaban
    ;akhir cetak peringatan


cetakan:
    ;cetak bacaan "skor kamu adalah"
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, len_msg
    int 0x80

    mov eax, [coba]
    call printNum;akhir cetak skor


    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80
    mov eax, 4;cetak tulisan kelas kamu adalah:
    mov ebx, 1
    mov ecx, kelas
    mov edx, len_kelas
    int 0x80
    jmp kelas_newbie

kelas_newbie:
    cmp dword[coba], 5
    jg kelas_beginner
    mov eax, 4;cetak newbie
    mov ebx, 1
    mov ecx, newbie
    mov edx, len_newbie
    int 0x80
    jmp exit
    
kelas_beginner:
    cmp dword[coba], 8
    jg kelas_intermediate
    mov eax, 4;cetak beginner
    mov ebx, 1
    mov ecx, beginner
    mov edx, len_beginner
    int 0x80
    jmp exit
    
kelas_intermediate:
    cmp dword[coba], 10
    jg kelas_expert
    mov eax, 4;cetak intermediate
    mov ebx, 1
    mov ecx, intermediate
    mov edx, len_intermediate
    int 0x80
    jmp exit
    
kelas_expert:
    cmp dword[coba], 12
    jg kelas_insane
    mov eax, 4;cetak expert
    mov ebx, 1
    mov ecx, expert
    mov edx, len_expert
    int 0x80
    jmp exit
    
kelas_insane:
    mov eax, 4;cetak insane
    mov ebx, 1
    mov ecx, insane
    mov edx, len_insane
    int 0x80
    jmp exit

tipesoal2:
    ;buka soal
    mov eax, 5
    mov ebx, sl2
    mov ecx, 0
    mov edx, 777
    int 0x80    
    mov dword[isi_file], eax
    mov ecx, 0
    ;akhir buka soal
    ;baca soal
    mov eax, 3
    mov ebx, [isi_file]
    mov ecx, soalan
    mov edx, 10000
    int 0x80
    ;akhir baca soal
    ;cetak soal
    mov eax, 4
    mov ebx, 1
    mov ecx, soalan
    mov edx, 10000
    int 0x80
    ;akhir cetak soal

    ;cetak kalimat jawaban
    kalimat12:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len_msg2
    int 0x80

loopjawaban2: ;ambil jawaban

    mov eax, 3
    mov ebx, 0
    mov ecx, jawaban
    mov edx, 2
    int 0x80
    ;cek apakah inputan sudah sesuai a b c d
    cmp byte[jawaban],'a'
    jne cek_b2
balikan12:
    ;ambil kuncian2
    mov al, [ecx] 
    inc ecx
    ;akhir ambil kuncian2
    mov edx, [total]
    cmp al, [kuncian2+4*edx]; jawab
    ;add dword[cjawaban],1
    je cek2

balikan22:
    add dword[total], 1 ;BUAT APA?
    sub dword[jumlah], 1
    cmp dword [jumlah], 0
    jne loopjawaban2
    jmp cetakan2

cek2:
    add dword[coba],  1;cek1
    jmp balikan22

cek_b2:
    cmp byte[jawaban],'b'
    jne cek_c2
    jmp balikan12
cek_c2:
    cmp byte[jawaban], 'c'
    jne cek_d2
    jmp balikan12   
cek_d2:
    cmp byte[jawaban], 'd'
    jne cek_e2
    jmp balikan12
cek_e2:
    cmp byte[jawaban], 'e'
    jne peringatan2
    jmp balikan12
peringatan2:
    ;cetak peringatan
    mov eax, 4
    mov ebx, 1
    mov ecx, peringatan_msg
    mov edx, 37
    int 0x80
    jmp loopjawaban2
    ;akhir cetak peringatan


cetakan2:
    ;cetak bacaan "skor kamu adalah"
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, len_msg
    int 0x80

    mov eax, [coba]
    call printNum;akhir cetak skor


    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80
    mov eax, 4;cetak tulisan kelas kamu adalah:
    mov ebx, 1
    mov ecx, kelas
    mov edx, len_kelas
    int 0x80
    jmp kelas_newbie2

kelas_newbie2:
    cmp dword[coba], 5
    jg kelas_beginner2
    mov eax, 4;cetak newbie
    mov ebx, 1
    mov ecx, newbie
    mov edx, len_newbie
    int 0x80
    jmp exit
    
kelas_beginner2:
    cmp dword[coba], 8
    jg kelas_intermediate2
    mov eax, 4;cetak beginner
    mov ebx, 1
    mov ecx, beginner
    mov edx, len_beginner
    int 0x80
    jmp exit
    
kelas_intermediate2:
    cmp dword[coba], 10
    jg kelas_expert2
    mov eax, 4;cetak intermediate
    mov ebx, 1
    mov ecx, intermediate
    mov edx, len_intermediate
    int 0x80
    jmp exit
    
kelas_expert2:
    cmp dword[coba], 12
    jg kelas_insane2
    mov eax, 4;cetak expert
    mov ebx, 1
    mov ecx, expert
    mov edx, len_expert
    int 0x80
    jmp exit
    
kelas_insane2:
    mov eax, 4;cetak insane
    mov ebx, 1
    mov ecx, insane
    mov edx, len_insane
    int 0x80
    jmp exit


    
exit:
    mov eax, 1
    mov ebx, 0
    int 0x80

section .data
    kuncian1 dd 'b','a','c','d','a','a','d','b','c','a','d','d','b','a','a',0
    kuncian2 dd 'a','a','a','b','b','b','c','c','c','d','d','d','e','e','e',0
    peringatan_msg db "silakan masukan jawaban dengan benar",0xa
    msg_paket db "Paket yang tersedia:",0xa,"1. Paket Soal 1",0xa,"2. Paket Soal 2",0xa,"Silahkan pilih paket: "
    len_msg_paket equ $-msg_paket
    msg_paketsalah db 0xa,"Maaf paket tidak tersedia, silahkan input paket kembali secara benar",0xa,"Silahkan pilih paket: "
    len_msg_paketsalah equ $-msg_paketsalah
    msg db "Skor EPT kamu adalah: "
    len_msg equ $-msg
    msg2 db "Silahkan masukkan jawaban kamu (1-15): ",0xa
    len_msg2 equ $-msg2
    kelas db "Kamu masuk kelas : "
    len_kelas equ $-kelas
    newbie db "Newbie",0xa;sampai 5 
    len_newbie equ $-newbie
    beginner db "Beginner",0xa; sampai 8
    len_beginner equ $-beginner
    intermediate db "Intermediate",0xa; sampai 10
    len_intermediate db $-intermediate
    expert db "Expert",0xa; sampai 12
    len_expert equ $-expert
    insane db "Insane",0xa; sampai 15
    len_insane equ $-insane
    sl1 db "soal1.txt",0
    sl2 db "soal2.txt",0
    coba dd 0
    jumlah dd 15
    total dd 0
    newline db 10

section .bss
    soalan resd 10000
    jawaban resb 255
    isi_file resd 1
    Score resb 3
    ;mov ecx, 0
    ;mov [konter], ecx
    ;mov ebx, [kuncian]
    ;mov eax, [kuncian+ecx*ptrr]
    ;add ecx, 1

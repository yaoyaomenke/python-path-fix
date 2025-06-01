default rel
section .text
global main

extern scanf
extern exit
extern strcat
extern printf
extern system
extern MessageBoxA

fix_python:
  lea rcx, [printf_input_python_path]
  call printf

  lea rcx, [input_path_text]
  lea rdx, [path_buffer]
  call scanf

  lea rcx, [fix_cmd]
  lea rdx, [get_user_path]
  call strcat

  lea rcx, [fix_cmd]
  lea rdx, [path_buffer]
  call strcat

  lea rcx, [fix_cmd]
  lea rdx, [closing_quote]
  call strcat

  lea rcx, [fix_cmd]
  call system



  mov rcx,0
    lea rdx,[fix_ok]
    lea r8,[fix_ok]
    mov r9,0
    call MessageBoxA

  jmp exit_break

fix_py:
  lea rcx, [printf_input_python_path]
  call printf

  lea rcx, [input_path_text]
  lea rdx, [path_buffer]
  call scanf

  lea rcx, [fix_cmd]
  lea rdx, [fix_py_cmd]
  call strcat

  lea rcx, [fix_cmd]
  lea rdx, [path_buffer]
   call strcat

   lea rcx, [fix_cmd]
   lea rdx, [closing_quote1]
    call strcat

  lea rcx, [fix_cmd]
  call system

  mov rcx,0
  lea rdx,[fix_ok]
  lea r8,[fix_ok]
  mov r9,0
  call MessageBoxA

  jmp exit_break

main:
  sub rsp, 36
  mov dword [rsp+32], 0

  lea rcx, [printf_fun_list]
  call printf
  lea rcx, [printf_what_fun]
  call printf

  lea rcx, [input_text]
  lea rdx, [rsp+32]
  call scanf
  cmp rax, 0
  je exit_break

  cmp dword [rsp+32], 1
  je fix_python

  cmp dword [rsp+32], 2
  je fix_py

exit_break:
  mov rcx, 0
  call exit

section .data
printf_what_fun db "��Ҫʹ��ʲô����?>",0
printf_fun_list db "1.�޸�python��������      2.�޸�py�ļ��򿪷�ʽ",0x0A,0
printf_input_python_path db "������python·��>",0
input_text db "%d",0
input_path_text db "%255s",0
path_buffer times 256 db 0
fix_cmd times 290 db 0
closing_quote db ';%~b"',0
get_user_path db "for /f ",22h,"tokens=2*",22h," %a in ('reg query HKCU\Environment /v PATH') do setx PATH ",22h,0
closing_quote1 db ' "%1"', 0
fix_py_cmd db 'assoc .py=Python.File & ftype Python.File=',0
fix_ok db "�޸��ɹ�",0
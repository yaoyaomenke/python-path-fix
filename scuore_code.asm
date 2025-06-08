default rel
section .text
global main

extern scanf
extern exit
extern strcat
extern printf
extern system
extern MessageBoxA
extern getchar

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
get_python_path:
  lea rcx, [python_in_where]
  call system
  call scanf
  jmp exit_break
main:
  sub rsp, 40
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

  cmp dword [rsp+32], 3
   je get_python_path

exit_break:
  mov rcx, 0
  call exit

section .data
printf_what_fun db "你要使用什么功能?>",0
printf_fun_list db "1.修复python环境变量      2.修复py文件打开方式      3.找已安装的python路径",0x0A,0
printf_input_python_path db "请输入python路径>",0
input_text db "%d",0
input_path_text db "%255s",0
closing_quote db ';%~b"',0
get_user_path db "for /f ",22h,"tokens=2*",22h," %a in ('reg query HKCU\Environment /v PATH') do setx PATH ",22h,0
closing_quote1 db ' "%1"', 0
fix_py_cmd db 'assoc .py=Python.File & ftype Python.File=',0
fix_ok db "修复成功",0
python_in_where db "where python",0
section .bss
path_buffer resb 258
fix_cmd resb 510

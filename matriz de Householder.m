% Transformação de Householder
clear all
clc
tamanho = input('Insira o tamanho do vetor: ')
x = linspace(0,0,tamanho)

menu = 1
while menu != 0
  clc
  x
  printf('\n  * MENU\n')
  printf('1. Alterar\n')
  printf('0. Continuar\n\n')
  menu = input('Escolha a opção: ')
  if menu == 1
    printf('\n')
    i = input('Escolha a posição no vetor: ')
    printf('\n')
    x(i) = input('Digite o valor: ')
  endif
endwhile
x = x'
normaX = norm(x)
e = linspace(0,0,tamanho)
e(1)=1
e = e'
v = x + normaX*e
vtv = v'*v
vvt = v*v'
matriz_Householder = eye(length(vvt))-(2/vtv)*vvt

clc
printf('Matriz originada do vetor x: \n\n')
matriz_Householder
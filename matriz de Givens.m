% Rotação de Gives
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

bin = false
for i=2:length(x)
  c = x(1)/sqrt((x(1)**2)+(x(i)**2))
  s = x(i)/sqrt((x(1)**2)+(x(i)**2))

  R = eye(length(x))
  R(1,1) = c
  R(1,i) = s
  R(i,1) = -s
  R(i,i) = c
  
  if bin == true
    G = R*G
  else
    G = R
  endif
  bin = true
    
  x = R*x
endfor
matriz_Givens = G
clc
printf('Matriz originada do vetor x: \n\n')
matriz_Givens
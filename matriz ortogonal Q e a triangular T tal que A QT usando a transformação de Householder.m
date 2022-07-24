% Transformação de Householder
clear all
clc

linhas = input('Insira a quantidade de linhas: ')
colunas = input('Insira a quantidade de colunas: ')

A = zeros(linhas, colunas)

menu = 1
while menu != 0
  clc
  A
  printf('\n  * MENU\n')
  printf('1. Alterar\n')
  printf('0. Continuar\n\n')
  menu = input('Escolha a op��o: ')
  if menu == 1
    printf('\n')
    alterarLinha = input('Escolha a linha: ')
    printf('\n')
    alterarColuna = input('Ecolha a coluna: ')
    printf('\n')
    A(alterarLinha, alterarColuna) = input('Digite o valor: ')
  endif
endwhile

R = A
contador = 1
while contador < colunas && contador < linhas
  x = linspace(0,0,linhas)
  x = x'
  x(contador:linhas) = A(contador:linhas,contador)
  normaX = norm(x)

  e = linspace(0,0,linhas)
  e(contador) = (1)
  e = e'

  v = x - normaX*e
  vvt = v*v'
  vtv = v'*v

  P = eye(linhas) - (2/vtv)*vvt
  if contador > 1
    Q = P*Q
  else
    Q = P
  endif
  R = P*R
  contador += 1
  
  if linhas > colunas
    boolean = false
    for j=1:length(A)
      for i=j+1:length(A)
        if A(i,j) > 0
          boolean = true
        endif
      endfor
    endfor
    atualizacao = false
    if boolean == true
      nulos_em_Rnxn = []
      for i=1:linhas
        aux = 0
        for j=1:colunas
          aux += R(i,j)
        endfor
        if aux == 0
          nulos_em_Rnxn(end+1) = i
        endif
      endfor
      nulos = []
      for i=colunas+1:linhas
        aux = 0
        for j=1:colunas
          aux += R(i,j)
        endfor
        if aux != 0
          nulos(end+1) = i
        endif
      endfor
      nulos_em_Rnxn
      P = eye(linhas)
      for i=1:length(nulos_em_Rnxn)
        aux = P(nulos(i),:)
        P(nulos(i),:) = P(nulos_em_Rnxn(i),:)
        P(nulos_em_Rnxn(i),:) = aux
      endfor
    endif
    atualizacao = true
    if atualizacao == true
      R = P*R
      contador += 1
    endif
  endif
endwhile
for k=2:linhas
  naoNulos = []
  nulos = []
  aux = []
  auxBin = false
  for i=2:linhas
    auxBin = false
    for j=1:i-1
      if R(i,j) != 0
        auxBin = true
      endif
    endfor
    if auxBin == true
      naoNulos(end+1) = i
    else
      nulos(end+1) = i
    endif
  endfor
  P = eye(linhas)
  for i=1:length(nulos)
    aux = P(nulos(i),:)
    P(nulos(i),:) = P(naoNulos(i),:)
    P(naoNulos(i),:) = aux
  endfor
endfor
R = P*R
clc

A
R
Q
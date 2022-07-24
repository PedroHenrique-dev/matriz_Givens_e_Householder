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
  menu = input('Escolha a opção: ')
  if menu == 1
    printf('\n')
    alterarLinha = input('Escolha a linha: ')
    printf('\n')
    alterarColuna = input('Ecolha a coluna: ')
    printf('\n')
    A(alterarLinha, alterarColuna) = input('Digite o valor: ')
  endif
endwhile

clc
% Transformação de Householder
printf('    * Transformação de Householder\n\n')
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
matriz_triangular_Householder = R
matriz_ortogonal_Householder = Q
input('Aperte ENTER para continuar')

clc
% Rotação de Gives
printf('    * Rotação de Gives\n\n')
R = A
bin = false
for i=1:linhas-1
  for j=i+1:colunas
    vetor = linspace(0,0,2)
    vetor = vetor'
    vetor(1) = R(i,i)
    vetor(2) = R(j,i)
    
    x = vetor(1)
    y = vetor(2)
    r = sqrt((x**2)+(y**2))

    c = x/r
    s = -y/r
    G = eye(linhas)
    G(i,i) = c
    G(i,j) = -s
    G(j,i) = s
    G(j,j) = c
    
    R = G*R
    
    if bin == true
      Q = G*Q
    else
      Q = G
    endif
    bin = true
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
  endfor
endfor

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
matriz_triangular_Givens = R
matriz_ortogonal_Givens = Q
input('Aperte ENTER para continuar')

clc
A
matriz_triangular_Householder
matriz_ortogonal_Householder
matriz_triangular_Givens
matriz_ortogonal_Givens

# Valores de Ganho do PID
addi s2, zero, 4  # Kp 
addi s3, zero, 1  # Ki
addi s4, zero, 2  # Kd

# Alvo de estabilidade do sistema
addi s5, zero, 10 # Setpoint

add  t5, zero, zero # Erro acumulado (I)
add  t6, zero, zero # Último erro    (D)

# Loop principal
PID: 

   # Declarando a saída da iteração
   add  t0, zero, zero # Saída
   
   # Carregando a variável do processo pela entrada paralela
   lw   t1, 0x00(zero) # Entrada
   
   # Calculando o erro
   sub  t1, s5, t1 # Erro = Setpoint - Entrada  

   # PROPORCIONAL

   add t2, zero, s2 # Carregando Kp num temporário

   _mul_Kp:

      beq     t2, zero, mul_Kp_ 
      add     t0, t0, t1      
      addi    t2, t2, -1      
      beq     zero, zero, _mul_Kp 

   mul_Kp_:

   # INTEGRAL 

   add t2, zero, s3 # Carregando Ki num temporário
   add t5, t5, t1   # Erro integrativo = Erro + Erro Acumulado

   _mul_Ki:

      beq     t2, zero, mul_Ki_ 
      add     t0, t0, t5      
      addi    t2, t2, -1      
      beq     zero, zero, _mul_Ki

   mul_Ki_:

   # DIFERENCIAL

   add t2, zero, s4 # Carregando Kd num temporário
   sub t6, t1, t6   # Erro Diferencial = Erro - Último Erro

   _mul_Kd:

      beq     t2, zero, mul_Kd_ 
      add     t0, t0, t6      
      addi    t2, t2, -1      
      beq     zero, zero, _mul_Kd

   mul_Kd_:

   add t6, zero, t1 # Atualiza o último erro

   # SAÍDA
   
   sw  t0, 0x04(zero) # Escreve saída da iteração na saída paralela 

beq  zero, zero, PID # Volta para o início do loop PID
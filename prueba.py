# from random import randint

# def lanza_dado():
#     dado = randint(1,6)
#     dado2_= randint(1,6)

#     return dado,dado2_


# def evaluar_jugada(dado,dado2):
#     """
#     Funcion encargada de evaluar una jugada en base a dos numeros dados con limite de 6
#     """
#     resultados = ''
#     suma_dados = dado + dado2

#     def tumama():
#         print("Tu mama")

#     if suma_dados  <= 6:
#         resultados = f'La suma de tus dados es {suma_dados}. Lamentable'
#     elif suma_dados > 6 and suma_dados < 10:
#         resultados = f'la suma de tus dados es {suma_dados}, Tienes buenas chances'
#     else:
#         resultados= f'La suma de tus dados es {suma_dados}, Parece una jugada ganadora'

#     return resultados

# dado, dado2 = lanza_dado()
# # Invocacion de la funcion evaluar jugada, parametros provenientes de lanza_dado
# evalua_jugada = evaluar_jugada(dado, dado2)
# print(evalua_jugada)


def suma_absolutos(*args):
    numeros = 0
    for n in args:
        if n < 0:
            n *= -1
            print(n)
        else:
            numeros += n
            print(n)

suma_absolutos(2244,-2,23,-333,-11,-22,122222,-999)
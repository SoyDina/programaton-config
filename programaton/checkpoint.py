import random

# Resumiendo lo que hicimos a la mañana, 
# vimos que podemos simular el llenado de un álbum de 6 figuritas haciendo:

album = [0]*6                           # Creamos el álbum vacío. [0]*6 es lo mismo que [0, 0, 0, 0, 0, 0]
contador = 0                            # Arrancamos el contador de figuritas en 0
while sum(album) < 6:                   # Mientras el álbum no esté lleno...
    figu = random.randint(0,5)          # Compramos una figu,
    album[figu] = 1                     # la pegamos en el álbum,
    contador = contador + 1             # y la contamos (le sumamos 1 al contador)

# Finalmente, la variable "contador" guarda el valor que nos interesa: 
# la cantidad de figuritas que tuvimos que comprar para llenar el álbum.


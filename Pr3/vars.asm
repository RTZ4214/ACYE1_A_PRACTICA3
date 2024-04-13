
.data

    bandera db 10,13,"Entraste en la opcion 1",10,13,"$"
    bandera2 db 10,13,"Entraste en la opcion 2",10,13,"$"
    bandera3 db 10,13,"Este es un caballo",10,13,"$"
    bandera4 db 10,13,"Este es un peon",10,13,"$"
    bandera5 db 10,13,"Este es un alfil",10,13,"$"
    bandera6 db 10,13,"Este es un torre",10,13,"$"
    bandera7 db 10,13,"Este es el REY",10,13,"$"
    bandera8 db 10,13,"Este es la REINA",10,13,"$"



    msgError db 10,13,"Movimiento invalido",10,13,"$"


    salto db 10,13,"$"
    encabezado db "UNIVERSIDAD DE SAN CARLOS DE GUATEMALA",10,13,"FACULTAD DE INGENIERIA",10,13,"ESCUELA DE CEINCIAS Y SISTEMAS",10,13,"ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1",10,13,"SECCION B",10,13,"$"
    semestre db "PRIMER SEMESTRE 2024",10,13,"$"
    datos db "JOSEPH RAPHAEL GOMEZ TZORIN",10,13,"201901974",10,13,"PRACTICA 3","$"

    indicadorColumnas db 10,13, "  A B C D E F G H", "$" 
    indicadorFilas db "12345678", "$"
    tablero db 64 dup(32) ; ROW-MAJOR O COLUMN-MAJOR
    

    mensajeMenu db " 1. Nuevo Juego", 10, 13, " 2. Puntajes", 10, 13, " 3. Reportes", 10, 13, " 4. Salir", 10, 13, " >> Ingrese Una Opcion: ","$"
    
    opcion db 1 dup(32)


    msgColMenor db 10,13, "Columna no valida",10,13,"$"
    msgRowMenor db 10,13, "Fila no valida",10,13,"$"
    msgErrorMov db 10,13, "Movimiento no valido",10,13,"$"
    msgErrorMatar db 10,13, "No puedes eliminar tu propia pieza",10,13,"$"
    msgErrorPieza db 10,13, "Esta pieza no te pertenece",10,13,"$"
    msgbloqueo db 10,13, "Pieza bloqueada",10,13,"$"
    msgcomidarival db 10,13, "Pieza del Rival Comida",10,13,"$"
    msgcomidapropia db 10,13, "Pieza propia Comida",10,13,"$"



     ;--------------------------------Vars para juego--------------------------------------
    msgSelectP db  10,13,"***Seleccione una pieza*** ", "$"
    msgSelectC db  10,13,"***Seleccione una casilla***", "$"

    msgRow db 10,13,10,13, "Ingrese la fila: ", "$"
    msgColumn db 10,13, "Ingrese la columna: ", "$"
    rowInicio db 1 dup("$")
    colInicio db 1 dup("$")

    rowFin db 1 dup("$")
    colFin db 1 dup("$")

    msgExit db 10,13, "Saliendo del juego...",10,13,"$"
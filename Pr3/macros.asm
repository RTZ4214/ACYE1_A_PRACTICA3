obtenerOpcion MACRO regOpcion ;Macro que obtiene la opcion del usuario
    MOV AH, 01h ;01h es el codigo de la funcion que lee un caracter
    INT 21h    ;interrupcion para el servicio de lectura
    MOV regOpcion, AL   ;Guardamos el valor leido en AL en regOpcion
ENDM

LimpiarConsola MACRO
    MOV ax,03h              ;03H es el codigo de la funcion que limpia la pantalla
    INT 10h                 ;10h es la interrupcion para el video
ENDM

ImprimirCadenas Macro cadena
    MOV ah,09h              ;09h es el codigo de la funcion que imprime una cadena
    LEA DX,cadena           ;carga la direccion de la cadena en dx
    INT 21h                 ;interrupcion para el servicio de impresion
ENDM

ImprimirEncabezado MACRO
    ImprimirCadenas encabezado
    ImprimirCadenas salto
    ImprimirCadenas semestre
    ImprimirCadenas salto
    ImprimirCadenas datos
    ImprimirCadenas salto
ENDM

;--------------------------------------Macros de juego--------------------------------------

ImprimirTableroJuego Macro ;Macro que imprime el tablero de juego

    LOCAL fila,columna
    XOR BX,BX  ;Limpiamos bx (inicia en 0),contador de filas
    XOR SI ,SI ;Limpiamos SI (inicia en 0),indice del tablero
    XOR CL,CL ;Limpiamos cl (inicia en 0),contador de columnas
    ImprimirCadenas indicadorColumnas

    fila:
        ImprimirCadenas salto


        MOV ah,02h
        MOV DL,indicadorFilas[BX]  ;Imprimimos el valor del indicador de las filas,se utilzia 02h para imprimir un caracter
        INT 21h

        ;Imprimimos el separador
        MOV DL,32
        INT 21h

        columna:
            ;Imprimimos el valor del tablero
            MOV DL,tablero[SI]
            INT 21h

            ;Imprimimos el separador
            MOV DL,124
            INT 21h

            ;incrementamos el contador de columnas
            ;incrementamos el indice del tablero
            INC CL
            INC SI

            ;Verificamos si ya se imprimieron las 8 columnas
            CMP CL, 8
            ;Si no se han impreso las 8 columnas, repetimos el ciclo,JB salta si el contador de columnas es menor que 8
            JB columna

            ;Si ya se imprimieron las 8 columnas, reiniciamos el contador de columnas,he incrementamos el contador de filas
            MOV CL, 0
            INC BX

            ;Verificamos si ya se imprimieron las 8 filas
            CMP BX, 8
            ;Si no se han impreso las 8 filas, repetimos el ciclo
            JB fila
ENDM

LlenarTablero MACRO ;Macro que llena el tablero con los caracteres correspondientes
    LOCAL llenarPeon1, llenarPeon2, Piezas1, Piezas2

    MOV SI, 0 ; Indice del tablero
    MOV CH, 0 ; Contador de peones

    Piezas1:
        MOV DX, 116 ;t ; Caracter a guardar en el tablero
        MOV tablero[SI], DL ; Escribir caracter en el tablero
        PUSH DX ; Guardamos el registro en la pila
        INC SI ; Incrementamos indice de tablero -> SI++

        MOV DX, 99 ;c
        MOV tablero[SI], DL
        PUSH DX
        INC SI

        MOV DX, 97 ;a
        MOV tablero[SI], DL
        PUSH DX
        INC SI

        MOV DX, 114 ;r
        MOV tablero[SI], DL
        INC SI

        MOV DX, 35 ;#
        MOV tablero[SI], DL
        INC SI

        POP DX ;a ; Extraemos registro de la pila y lo almacenamos en DX
        MOV tablero[SI], DL ; Escribimos caracter en el tablero
        INC SI ; Incrementamos indice de tablero -> SI++

        POP DX ;c
        MOV tablero[SI], DL
        INC SI

        POP DX ;t
        MOV tablero[SI], DL
        INC SI

    llenarPeon1:
        MOV tablero[SI], 112 ;p ; Escribir caracter en tablero
        INC SI ; Incrementamos indice del tablero
        INC CH ; Incrementamos contador de peones

        CMP CH, 8 ; Si es menor a 8 que regrese a la etiqueta 'llenarPeon1', caso contrario continua
        JB llenarPeon1

        MOV CH, 0
        MOV SI, 48

    llenarPeon2:

        MOV tablero[SI], 80 ;P ; Escribir caracter en tablero
        INC SI ; Incrementamos indice del tablero
        INC CH ; Incrementamos contador de peones

        CMP CH, 8 ; Si es menor a 8 que regrese a la etiqueta 'llenarPeon2', caso contrario continua
        JB llenarPeon2

    Piezas2:
        MOV DX, 84 ;T
        MOV tablero[SI], DL
        PUSH DX
        INC SI

        MOV DX, 67 ;C
        MOV tablero[SI], DL
        PUSH DX
        INC SI

        MOV DX, 65 ;A
        MOV tablero[SI], DL
        PUSH DX
        INC SI

        MOV DX, 82 ;R
        MOV tablero[SI], DL
        INC SI

        MOV DX, 42 ;*
        MOV tablero[SI], DL
        INC SI

        POP DX ;A
        MOV tablero[SI], DL
        INC SI

        POP DX ;C
        MOV tablero[SI], DL
        INC SI

        POP DX ;T
        MOV tablero[SI], DL
        INC SI
ENDM

CoordenadasInicio MACRO
    LOCAL PedirCol,PedirRow,ER,EC,EndMacro


    ImprimirCadenas msgSelectP

    PedirRow:
        ImprimirCadenas msgRow
        obtenerOpcion rowInicio

        CMP rowInicio, 49 ;comparar si rowInicio es menor a 49 0-9
        JLE ER

        CMP rowInicio, 56 ;comparar si rowInicio es mayor a 56
        JG ER

        JMP PedirCol

        ER:
            ImprimirCadenas msgRowMenor
            JMP PedirRow

    PedirCol:
        ImprimirCadenas msgColumn
        obtenerOpcion colInicio

        CMP colInicio, 65
        JL EC

        CMP colInicio, 72
        JG EC

        JMP EndMacro

        EC:
            ImprimirCadenas msgColMenor
            JMP PedirCol


    EndMacro:


ENDM

CoordenadasFin MACRO
    LOCAL PedirCol,PedirRow,ER,EC,EndMacro


    ImprimirCadenas msgSelectC

    PedirRow:
        ImprimirCadenas msgRow
        obtenerOpcion rowFin

        CMP rowFin, 48
        JLE ER

        CMP rowFin, 56
        JG ER

        JMP PedirCol

        ER:
            ImprimirCadenas msgRowMenor
            JMP PedirRow

    PedirCol:
        ImprimirCadenas msgColumn
        obtenerOpcion colFIN

        CMP colFIN, 65
        JL EC

        CMP colFIN, 72
        JG EC

        JMP EndMacro

        EC:
            ImprimirCadenas msgColMenor
            JMP PedirCol


    EndMacro:



ENDM

RowMajor MACRO row, col, registro
    ;Calculo de la posicion en la matriz
    MOV AL, row ;Guardamos el valor de la fila en AL
    MOV BL, col ;Guardamos el valor de la columna en BL

    SUB AL, 49 ;Restamos 49 para obtener el valor de la fila
    SUB BL, 65 ;Restamos 65 para obtener el valor de la columna

    MOV BH, 8  ;Multiplicamos por 8 el registro BH por el registro Al

    MUL BH ;Multiplicamos AL por BH
    ADD AL, BL ;Sumamos AL con BL

    MOV registro, AX ;Guardamos el resultado en SI

ENDM

MoviAlfilPRO MACRO
    ImprimirCadenas bandera5
    MOV DI,SI
    ;DI guarda la posicion actual del Peon
    CoordenadasFin 
    RowMajor rowFin,colFIN,SI

    ;Todas las posibles posiciones del peon
    MOV CL, [SI] ;guardamos el valor de la posicion final en CL

    CMP CL,[DI+7]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI+14]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI+21]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI+28]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI+35]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI+42]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI+49]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI+9]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI+18]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI+27]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI+36]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI+45]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI+54]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI+63]
    JE MoverAlfil
    ;negativos
    MOV CL, [SI]
    CMP CL,[DI-7]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI-14]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI-21]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI-28]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI-35]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI-42]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI-49]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI-9]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI-18]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI-27]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI-36]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI-45]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI-54]
    JE MoverAlfil
    MOV CL, [SI]
    CMP CL,[DI-63]
    JE MoverAlfil
    
    ImprimirCadenas msgError
    JMP ImprimirTablero
    MoverAlfil:

        CMP tablero[SI],32
        JE MovAlfil

        CMP tablero[SI],96
        JB BloqueoA

        CMP tablero[SI],96
        JA ComerAlfil

        CMP tablero[SI],35
        JE ComerAlfil

        ImprimirCadenas msgErrorMatar
        JMP ImprimirTablero

        MovAlfil:
            MOV tablero[DI],32  ;Limpiamos la posicion inicial
            MOV tablero[SI],65 ;Movemos el caballo a la posicion final
            JMP ImprimirTablero
        BloqueoA:
            ImprimirCadenas msgbloqueo
            JMP ImprimirTablero
        ComerAlfil:
            ImprimirCadenas msgcomidarival
            MOV tablero[SI],32  ;Limpiamos la pieza comida
            MOV tablero[DI],32  ;Limpiamos la posicion inicial
            MOV tablero[SI],65 ;Movemos el peon a la posicion final
            JMP ImprimirTablero
ENDM

MovimientoCaballoPropio MACRO
    
    ImprimirCadenas bandera3

    MOV DI,SI
    ;DI guarda la posicion actual del caballo
    CoordenadasFin 
    RowMajor rowFin,colFIN,SI

    ;Todas las posibles posiciones del caballo
    MOV CL, [SI] ;guardamos el valor de la posicion final en CL

    CMP CL,[DI-17]
    JE MoverCaballo

    CMP CL,[DI-10]
    JE MoverCaballo

    CMP CL,[DI+6]
    JE MoverCaballo

    CMP CL,[DI+15]
    JE MoverCaballo

    CMP CL,[DI+17]
    JE MoverCaballo

    CMP CL,[DI+10]
    JE MoverCaballo

    CMP CL,[DI-6]
    JE MoverCaballo

    CMP CL,[DI-15]
    JE MoverCaballo

    ImprimirCadenas msgError
    JMP ImprimirTablero
    MoverCaballo:
        CMP tablero[SI],32
        JE ComerCaballo

        CMP tablero[SI],96
        JA ComerCaballo


        CMP tablero[SI],35
        JE ComerCaballo

        ImprimirCadenas msgErrorMatar
        JMP ImprimirTablero

        ComerCaballo:
            MOV tablero[DI],32  ;Limpiamos la posicion inicial
            MOV tablero[SI],67 ;Movemos el caballo a la posicion final
            JMP ImprimirTablero



ENDM

MovipeonPRO MACRO
    ImprimirCadenas bandera4
    MOV DI,SI
    ;DI guarda la posicion actual del Peon
    CoordenadasFin 
    RowMajor rowFin,colFIN,SI

    ;Todas las posibles posiciones del peon
    MOV CL, [SI] ;guardamos el valor de la posicion final en CL

    CMP CL,[DI+8]
    JE MoverPeon
    CMP CL,[DI-8]
    JE MoverPeon
     CMP CL,[DI-7]
    JE MoverPeond
    CMP CL,[DI+7]
    JE MoverPeond

    ImprimirCadenas msgError
    JMP ImprimirTablero
    MoverPeon:

        CMP tablero[SI],32
        JE MovPeon

        CMP tablero[SI],96
        JA Bloqueo

        CMP tablero[SI],35
        JE ComerPeon

        ImprimirCadenas msgErrorMatar
        JMP ImprimirTablero

        MovPeon:
            MOV tablero[DI],32  ;Limpiamos la posicion inicial
            MOV tablero[SI],80 ;Movemos el caballo a la posicion final
            JMP ImprimirTablero
        Bloqueo:
            ImprimirCadenas msgbloqueo
            JMP ImprimirTablero
    MoverPeond:
        CMP tablero[SI],96
        JA ComerPeon

        ImprimirCadenas msgErrorMatar
        JMP ImprimirTablero
        ComerPeon:
            ImprimirCadenas msgcomidarival
            MOV tablero[SI],32  ;Limpiamos la pieza comida
            MOV tablero[DI],32  ;Limpiamos la posicion inicial
            MOV tablero[SI],80 ;Movemos el peon a la posicion final
            JMP ImprimirTablero




ENDM
MovTorrePro MACRO
    ImprimirCadenas bandera6
    MOV DI,SI
    ;DI guarda la posicion actual del Peon
    CoordenadasFin 
    RowMajor rowFin,colFIN,SI
    ;Todas las posibles posiciones del peon
    MOV CL, [SI] ;guardamos el valor de la posicion final en CL
    CMP CL,[DI+8]
    JE MoverTorre
    CMP CL,[DI+16]
    JE MoverTorre
    CMP CL,[DI+24]
    JE MoverTorre
    CMP CL,[DI+32]
    JE MoverTorre
    CMP CL,[DI+40]
    JE MoverTorre
    CMP CL,[DI+48]
    JE MoverTorre
    CMP CL,[DI+56]
    JE MoverTorre
    CMP CL,[DI+1]
    JE MoverTorre
    CMP CL,[DI+2]
    JE MoverTorre
    CMP CL,[DI+3]
    JE MoverTorre
    CMP CL,[DI+4]
    JE MoverTorre
    CMP CL,[DI+5]
    JE MoverTorre
    CMP CL,[DI+6]
    JE MoverTorre
    CMP CL,[DI+7]
    JE MoverTorre
    ;seperar
    CMP CL,[DI-8]
    JE MoverTorre
    CMP CL,[DI-16]
    JE MoverTorre
    CMP CL,[DI-24]
    JE MoverTorre
    CMP CL,[DI-32]
    JE MoverTorre
    CMP CL,[DI-40]
    JE MoverTorre
    CMP CL,[DI-48]
    JE MoverTorre
    CMP CL,[DI-56]
    JE MoverTorre
    CMP CL,[DI-1]
    JE MoverTorre
    CMP CL,[DI-2]
    JE MoverTorre
    CMP CL,[DI-3]
    JE MoverTorre
    CMP CL,[DI-4]
    JE MoverTorre
    CMP CL,[DI-5]
    JE MoverTorre
    CMP CL,[DI-6]
    JE MoverTorre
    CMP CL,[DI-7]
    JE MoverTorre
    MoverTorre:
        CMP tablero[SI],32
        JE MovTorre

        CMP tablero[SI],96
        JB BloqueoT

        CMP tablero[SI],96
        JA ComerTorre

        CMP tablero[SI],35
        JE ComerTorre

        ImprimirCadenas msgErrorMatar
        JMP ImprimirTablero

        MovTorre:
            MOV tablero[DI],32  ;Limpiamos la posicion inicial
            MOV tablero[SI],84 ;Movemos el caballo a la posicion final
            JMP ImprimirTablero
        BloqueoT:
            ImprimirCadenas msgbloqueo
            JMP ImprimirTablero
        ComerTorre:
            ImprimirCadenas msgcomidarival
            MOV tablero[SI],32  ;Limpiamos la pieza comida
            MOV tablero[DI],32  ;Limpiamos la posicion inicial
            MOV tablero[SI],84 ;Movemos el peon a la posicion final
            JMP ImprimirTablero



ENDM
MovReyPro MACRO
    ImprimirCadenas bandera7
    MOV DI,SI
    ;DI guarda la posicion actual del Peon
    CoordenadasFin 
    RowMajor rowFin,colFIN,SI
    ;Todas las posibles posiciones del peon
    MOV CL, [SI] ;guardamos el valor de la posicion final en CL
    CMP CL,[DI+1]
    JE MoverRey
    
    MoverRey:
        CMP tablero[SI],32
        JE MovRey

        CMP tablero[SI],96
        JB BloqueoR

        CMP tablero[SI],96
        JA ComerREY

        CMP tablero[SI],35
        JE ComerREY

        ImprimirCadenas msgErrorMatar
        JMP ImprimirTablero

        MovRey:
            MOV tablero[DI],32  ;Limpiamos la posicion inicial
            MOV tablero[SI],82 ;Movemos el caballo a la posicion final
            JMP ImprimirTablero
        BloqueoR:
            ImprimirCadenas msgbloqueo
            JMP ImprimirTablero
        ComerREY:
            ImprimirCadenas msgcomidarival
            MOV tablero[SI],32  ;Limpiamos la pieza comida
            MOV tablero[DI],32  ;Limpiamos la posicion inicial
            MOV tablero[SI],82 ;Movemos el peon a la posicion final
            JMP ImprimirTablero

ENDM
MovReinaPro MACRO
    ImprimirCadenas bandera8
    MOV DI,SI
    ;DI guarda la posicion actual del Peon
    CoordenadasFin 
    RowMajor rowFin,colFIN,SI
    ;Todas las posibles posiciones del peon
    MOV CL, [SI] ;guardamos el valor de la posicion final en CL
    ;igual al alfi
    CMP CL,[DI+7]
    JE MoverReina
    CMP CL,[DI+14]
    JE MoverReina
    CMP CL,[DI+21]
    JE MoverReina
    CMP CL,[DI+28]
    JE MoverReina
    CMP CL,[DI+35]
    JE MoverReina
    CMP CL,[DI+42]
    JE MoverReina
    CMP CL,[DI+49]
    JE MoverReina
    CMP CL,[DI+9]
    JE MoverReina
    CMP CL,[DI+18]
    JE MoverReina
     CMP CL,[DI+27]
    JE MoverReina
    CMP CL,[DI+36]
    JE MoverReina
    CMP CL,[DI+45]
    JE MoverReina
    CMP CL,[DI+54]
    JE MoverReina
    CMP CL,[DI+63]
    JE MoverReina
    ;negativos
    CMP CL,[DI-7]
    JE MoverReina
    CMP CL,[DI-14]
    JE MoverReina
    CMP CL,[DI-21]
    JE MoverReina
    CMP CL,[DI-28]
    JE MoverReina
    CMP CL,[DI-35]
    JE MoverReina
    CMP CL,[DI-42]
    JE MoverReina
    CMP CL,[DI-49]
    JE MoverReina
    CMP CL,[DI-9]
    JE MoverReina
    CMP CL,[DI-18]
    JE MoverReina
    CMP CL,[DI-27]
    JE MoverReina
    CMP CL,[DI-36]
    JE MoverReina
    CMP CL,[DI-45]
    JE MoverReina
    CMP CL,[DI-54]
    JE MoverReina
    CMP CL,[DI-63]
    JE MoverReina
    ;igual a la torre
     CMP CL,[DI+8]
    JE MoverReina
    CMP CL,[DI+16]
    JE MoverReina
    CMP CL,[DI+24]
    JE MoverReina
    CMP CL,[DI+32]
    JE MoverReina
    CMP CL,[DI+40]
    JE MoverReina
    CMP CL,[DI+48]
    JE MoverReina
    CMP CL,[DI+56]
    JE MoverReina
    CMP CL,[DI+1]
    JE MoverReina
    CMP CL,[DI+2]
    JE MoverReina
    CMP CL,[DI+3]
    JE MoverReina
    CMP CL,[DI+4]
    JE MoverReina
    CMP CL,[DI+5]
    JE MoverReina
    CMP CL,[DI+6]
    JE MoverReina
    CMP CL,[DI+7]
    JE MoverReina
    ;seperar
    CMP CL,[DI-8]
    JE MoverReina
    CMP CL,[DI-16]
    JE MoverReina
    CMP CL,[DI-24]
    JE MoverReina
    CMP CL,[DI-32]
    JE MoverReina
    CMP CL,[DI-40]
    JE MoverReina
    CMP CL,[DI-48]
    JE MoverReina
    CMP CL,[DI-56]
    JE MoverReina
    CMP CL,[DI-1]
    JE MoverReina
    CMP CL,[DI-2]
    JE MoverReina
    CMP CL,[DI-3]
    JE MoverReina
    CMP CL,[DI-4]
    JE MoverReina
    CMP CL,[DI-5]
    JE MoverReina
    CMP CL,[DI-6]
    JE MoverReina
    CMP CL,[DI-7]
    JE MoverReina
    MoverReina:
        CMP tablero[SI],32
        JE MovReina

        CMP tablero[SI],96
        JB BloqueoReina

        CMP tablero[SI],96
        JA ComerREina

        CMP tablero[SI],35
        JE ComerREina

        ImprimirCadenas msgErrorMatar
        JMP ImprimirTablero

        MovReina:
            MOV tablero[DI],32  ;Limpiamos la posicion inicial
            MOV tablero[SI],42 ;Movemos el caballo a la posicion final
            JMP ImprimirTablero
        BloqueoReina:
            ImprimirCadenas msgbloqueo
            JMP ImprimirTablero
        ComerREina:
            ImprimirCadenas msgcomidarival
            MOV tablero[SI],32  ;Limpiamos la pieza comida
            MOV tablero[DI],32  ;Limpiamos la posicion inicial
            MOV tablero[SI],42 ;Movemos el peon a la posicion final
            JMP ImprimirTablero


ENDM
Play MACRO

    CoordenadasInicio
    RowMajor rowInicio, colInicio, SI

    MOV AL,tablero[SI]
    CMP AL,67 ;C
    JE CaballoPropio
    MOV AL,tablero[SI]
    CMP AL,80 ;P
    JE PeonPropio
    MOV AL,tablero[SI]
    CMP AL,65 ;A
    JE AlfilPropio
    MOV AL,tablero[SI]
    CMP AL,84 ;T
    JE TorrePropio
    MOV AL,tablero[SI]
    CMP AL,82 ;R
    JE ReyPropio
    MOV AL,tablero[SI]
    CMP AL,42 ;*
    JE ReinaPropio

    ImprimirCadenas msgError
    JMP ImprimirTablero

    CaballoPropio:
        MovimientoCaballoPropio
        JMP ImprimirTablero
    PeonPropio:
        MovipeonPRO
        JMP ImprimirTablero
    AlfilPropio:
        MoviAlfilPRO
        JMP ImprimirTablero
    TorrePropio:
        MovTorrePro
        JMP ImprimirTablero
    ReyPropio:
        MovReyPro
        JMP ImprimirTablero
    ReinaPropio:
        MovReinaPro
        JMP ImprimirTablero

        
ENDM

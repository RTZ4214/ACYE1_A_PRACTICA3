include macros.asm
.model small
.stack
.data 
    include vars.asm

.code
    MOV AX, @data
    MOV DS, AX


    MAIN PROC
        LimpiarConsola
        ImprimirEncabezado
        LlenarTablero

        Munu:
            ImprimirCadenas salto
            ImprimirCadenas mensajeMenu
            obtenerOpcion opcion

            CMP opcion, 49 ;1
            JE ImprimirTablero

        ImprimirTablero:
            ;LimpiarConsola
            ImprimirTableroJuego
            Play
            

        EXIT:
            MOV AX, 4C00h
            INT 21h


    MAIN ENDP

END
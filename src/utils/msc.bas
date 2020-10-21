' Parser y compilador para los scripts de la churrera 3.
' Copyleft 2010, 2011 The Mojon Twins, los masters del c�digo guarro.
' Compilar con freeBasic (http://www.freebasic.net).

Const LIST_WORDS_SIZE = 20
Const LIST_CLAUSULES_SIZE = 100
Dim Shared listaPalabras (LIST_WORDS_SIZE) As String
Dim Shared listaClausulasEnter (LIST_CLAUSULES_SIZE) As Integer
Dim Shared listaClausulasFire (LIST_CLAUSULES_SIZE) As Integer
Dim Shared clausulasUsed (255) As Integer
Dim Shared actionsUsed (255) As Integer
Dim Shared maxItem As Integer
Dim Shared maxFlag As Integer
Dim Shared maxNPant As Integer
Dim Shared clausulasEnterIdx As Integer
Dim Shared clausulasFireIdx As Integer
Dim Shared clausulasEnter (LIST_CLAUSULES_SIZE) As String
Dim Shared clausulasFire (LIST_CLAUSULES_SIZE) As String
Dim AddTo (LIST_WORDS_SIZE) As Integer
Dim AddToIdx As Integer

Sub dump ()
	Dim i As Integer
	For i = 0 to LIST_WORDS_SIZE
		Print "["+listaPalabras (i) + "]";
	next i
	print
end sub

Sub stringToArray (in As String)
	Dim m as Integer
	Dim index as Integer
	Dim character as String * 1
	
	for m = 1 to LIST_WORDS_SIZE: listaPalabras (m) = "": Next m
	
	index = 0
	listaPalabras (index) = ""
	in = in + " "
	
	For m = 1 To Len (in)
		character = Ucase (Mid (in, m, 1))
		If (character >= "A" and character <= "Z") or (character >= "0" and character <="9") or character = "#" or character = "_" or character = "'" or character="<" or character=">" Then
			listaPalabras (index) = listaPalabras (index) + character
		Else
			listaPalabras (index) = Ltrim (Rtrim (listaPalabras (index)))
			If listaPalabras (index) <> "" Then
				index = index + 1
			End If
			If character <> " " Then 
				listaPalabras (index) = character
				index = index + 1
			End If
			listaPalabras (index) = ""
		End If
	Next m
End Sub

Sub displayMe (clausula As String) 
	Dim i As Integer
	Dim p As String
	
	For i = 1 To Len (clausula)
		p = Str (asc (mid (clausula, i, 1)))
		if Len (p) = 1 Then p = "00" + p
		If Len (p) = 2 Then p = "0" + p
		? p; 
		If i < Len (clausula) Then ? ", ";
	Next i
	Print
End Sub

Function writeMe (clausula As String) As String
	Dim res As String
	Dim i As Integer
	
	For i = 1 To Len (clausula)
		res = res + "0x" + hex (asc (mid (clausula, i, 1)), 2)
		
		If i < Len (clausula) Then res = res + ", "
	Next i
	writeMe = res
End Function

Function pval (s as string) as integer
	Dim res as integer
	if (left(s, 1) = "#") Then
		res = 128 + val (right (s, len(s) - 1))
	Else
		res = val (s)
	End If
	pval = res
end function

Function procesaClausulas (f As integer, nPant As Integer) As String
	' Lee cl�usulas de la pantalla nPant del archivo abierto f
	Dim linea As String
	Dim terminado As Integer
	Dim estado As integer
	Dim clausulas As String
	Dim clausula As String
	Dim numclausulas As Integer
	Dim longitud As Integer
	Dim ai As Integer
	
	terminado = 0
	estado = 0
	numclausulas = 0
	longitud = 0
	clausulas = ""
	clausula = ""
	
	While not terminado And Not eof (f)
		Line input #f, linea
		linea = Trim (linea, Any chr (32) + chr (9))
		'?estado & " " & linea
		'?linea ;"-";:displayMe clausula
		stringToArray (linea)
		
		if estado <> 1 then
			' Leyendo cl�usulas
			Select Case listaPalabras (0)
				case "IF":
					Select Case listaPalabras (1)
						Case "PLAYER_HAS_ITEM":
							clausula = clausula + chr (&H1) + chr (pval (listaPalabras (2)))
							numClausulas = numClausulas + 1
							clausulasUsed (&H1) = -1
							if maxItem < val (listaPalabras (2)) Then maxItem = val (listaPalabras (2))
						Case "PLAYER_HASN'T_ITEM":
							clausula = clausula + chr (&H2) + chr (pval (listaPalabras (2)))
							numClausulas = numClausulas + 1
							clausulasUsed (&H2) = -1
							if maxItem < val (listaPalabras (2)) Then maxItem = val (listaPalabras (2))
						Case "FLAG":
							Select Case listaPalabras (3)
								Case "=":
									if listaPalabras (4) = "FLAG" Then
										clausula = clausula + chr (&H14) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (5)))
										clausulasUsed (&H14) = -1
										if maxFlag < val (listaPalabras (2)) Then maxFlag = val (listaPalabras (2))
										if maxFlag < val (listaPalabras (5)) Then maxFlag = val (listaPalabras (5))
									Else
										clausula = clausula + chr (&H10) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (4)))
										clausulasUsed (&H10) = -1
										if maxFlag < val (listaPalabras (2)) Then maxFlag = val (listaPalabras (2))
										if maxFlag < val (listaPalabras (4)) Then maxFlag = val (listaPalabras (4))
									End If
								Case "<":
									If listaPalabras (4) = "FLAG" Then
										clausula = clausula + chr (&H15) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (5)))
										clausulasUsed (&H15) = -1
										if maxFlag < val (listaPalabras (2)) Then maxFlag = val (listaPalabras (2))
										if maxFlag < val (listaPalabras (5)) Then maxFlag = val (listaPalabras (5))
									Else
										clausula = clausula + chr (&H11) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (4)))
										clausulasUsed (&H11) = -1
										if maxFlag < val (listaPalabras (2)) Then maxFlag = val (listaPalabras (2))
										if maxFlag < val (listaPalabras (4)) Then maxFlag = val (listaPalabras (4))
									End If
								Case ">":
									If listaPalabras (4) = "FLAG" Then
										clausula = clausula + chr (&H16) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (5)))
										clausulasUsed (&H16) = -1
										if maxFlag < val (listaPalabras (2)) Then maxFlag = val (listaPalabras (2))
										if maxFlag < val (listaPalabras (5)) Then maxFlag = val (listaPalabras (5))
									Else
										clausula = clausula + chr (&H12) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (4)))
										clausulasUsed (&H12) = -1
										if maxFlag < val (listaPalabras (2)) Then maxFlag = val (listaPalabras (2))
										if maxFlag < val (listaPalabras (4)) Then maxFlag = val (listaPalabras (4))
									End If
								Case "<>", "!=":
									If listaPalabras (4) = "FLAG" Then
										clausula = clausula + chr (&H17) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (5)))
										clausulasUsed (&H17) = -1
										if maxFlag < val (listaPalabras (2)) Then maxFlag = val (listaPalabras (2))
										if maxFlag < val (listaPalabras (5)) Then maxFlag = val (listaPalabras (5))
									Else
										clausula = clausula + chr (&H13) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (4)))
										clausulasUsed (&H13) = -1
										if maxFlag < val (listaPalabras (2)) Then maxFlag = val (listaPalabras (2))
										if maxFlag < val (listaPalabras (4)) Then maxFlag = val (listaPalabras (4))
									End If
							End Select
							numClausulas = numClausulas + 1
						Case "PLAYER_TOUCHES":
							clausula = clausula + chr (&H20) + chr (pval (listaPalabras (2))) + chr (pval (listaPalabras (4)))
							clausulasUsed (&H20) = -1
							numClausulas = numClausulas + 1
						Case "PLAYER_IN_X":
							clausula = clausula + chr (&H21) + chr (val (listaPalabras (2))) + chr (val (listaPalabras (4)))
							clausulasUsed (&H21) = -1
							numClausulas = numClausulas + 1
						Case "PLAYER_IN_Y":
							clausula = clausula + chr (&H22) + chr (val (listaPalabras (2))) + chr (val (listaPalabras (4)))
							clausulasUsed (&H22) = -1
							numClausulas = numClausulas + 1
						Case "ALL_ENEMIES_DEAD"
							clausula = clausula + chr (&H30)
							clausulasUsed (&H30) = -1
							numClausulas = numClausulas + 1
						Case "ENEMIES_KILLED_EQUALS"
							clausula = clausula + chr (&H31) + chr (pval (listaPalabras (2)))
							clausulasUsed (&H31) = -1
							numClausulas = numClausulas + 1
						Case "PLAYER_HAS_OBJECTS"
							clausula = clausula + chr (&H40)
							clausulasUsed (&H40) = -1
							numClausulas = numClausulas + 1
						Case "NPANT"
							clausula = clausula + chr (&H50) + chr (pval (listaPalabras (2)))
							clausulasUsed (&H50) = -1
							numClausulas = numClausulas + 1
						Case "NPANT_NOT"
							clausula = clausula + chr (&H51) + chr (pval (listaPalabras (2)))
							clausulasUsed (&H51) = -1
							numClausulas = numClausulas + 1
						Case "TRUE"
							clausula = clausula + chr (&HF0)
							clausulasUsed (&HF0) = -1
							numClausulas = numClausulas + 1
					End Select
				case "THEN":
					clausula = clausula + Chr (255)
					if numclausulas = 0 Then Print "ERROR: THEN sin cl�usulas": terminado = -1
					estado = 1
				case "END":
					if estado = 0 then
					terminado = -1
					end if	
			end select
		else
			' Leyendo acciones
			Select Case listaPalabras (0)
				Case "SET":
					Select Case listaPalabras (1)
						Case "ITEM":
							clausula = clausula + Chr (&H0) + Chr (pval (listaPalabras (2))) + chr (pval (listaPalabras (4)))
							actionsUsed (&H0) = -1
							if maxItem < val (listaPalabras (2)) Then maxItem = val (listaPalabras (2))
						Case "FLAG":
							clausula = clausula + Chr (&H1) + Chr (pval (listaPalabras (2))) + chr (pval (listaPalabras (4)))	
							actionsUsed (&H1) = -1
							if maxFlag < val (listaPalabras (2)) Then maxFlag = val (listaPalabras (2))
						Case "TILE":
							clausula = clausula + Chr (&H20) + Chr (pval (listaPalabras (3))) + Chr (pval (listaPalabras (5))) + Chr (pval (listaPalabras (8)))
							actionsUsed (&H20) = -1
					End Select
				Case "INC":
					Select Case listaPalabras (1)
						Case "FLAG":
							clausula = clausula + Chr (&H10) + Chr (pval (listaPalabras (2))) + chr (pval (listaPalabras (4)))	
							actionsUsed (&H10) = -1
							if maxFlag < val (listaPalabras (2)) Then maxFlag = val (listaPalabras (2))
						Case "LIFE":
							clausula = clausula + Chr (&H30) + Chr (pval (listaPalabras (2)))
							actionsUsed (&H30) = -1
						Case "OBJECTS":
							clausula = clausula + Chr (&H40) + Chr (pval (listaPalabras (2)))
							actionsUsed (&H40) = -1
					End Select
				Case "DEC":
					Select Case listaPalabras (1)
						Case "FLAG":
							clausula = clausula + Chr (&H11) + Chr (pval (listaPalabras (2))) + chr (pval (listaPalabras (4)))						
							actionsUsed (&H11) = -1
							if maxFlag < val (listaPalabras (2)) Then maxFlag = val (listaPalabras (2))
						Case "LIFE":
							clausula = clausula + Chr (&H31) + Chr (pval (listaPalabras (2)))
							actionsUsed (&H31) = -1
						Case "OBJECTS":
							clausula = clausula + Chr (&H41) + Chr (pval (listaPalabras (2)))
							actionsUsed (&H41) = -1
					End Select
				Case "ADD":
					clausula = clausula + Chr (&H12) + Chr (pval (listaPalabras (2))) + chr (pval (listaPalabras (4)))						
					actionsUsed (&H12) = -1
					if maxFlag < val (listaPalabras (2)) Then maxFlag = val (listaPalabras (2))
					if maxFlag < val (listaPalabras (4)) Then maxFlag = val (listaPalabras (4))
				Case "SUB":
					clausula = clausula + Chr (&H13) + Chr (pval (listaPalabras (2))) + chr (pval (listaPalabras (4)))						
					actionsUsed (&H13) = -1
					if maxFlag < val (listaPalabras (2)) Then maxFlag = val (listaPalabras (2))
					if maxFlag < val (listaPalabras (4)) Then maxFlag = val (listaPalabras (4))
				Case "SWAP":
					clausula = clausula + Chr (&H14) + Chr (pval (listaPalabras (1))) + chr (pval (listaPalabras (3)))
					actionsUsed (&H14) = -1
				Case "PRINT_TILE_AT":
					clausula = clausula + Chr (&H50) + Chr (pval (listaPalabras (2))) + Chr (pval (listaPalabras (4))) + Chr (pval (listaPalabras (7)))
					actionsUsed (&H50) = -1
				Case "SET_FIRE_ZONE":
					clausula = clausula + Chr (&H51) + Chr (pval (listaPalabras (1))) + Chr (pval (listaPalabras (3))) + Chr (pval (listaPalabras (5))) + Chr (pval (listaPalabras (7)))
					actionsUsed (&H51) = -1
				Case "SOUND":
					clausula = clausula + Chr (&HE0) + Chr (pval (listaPalabras (1)))
					actionsUsed (&HE0) = -1
				Case "SHOW":
					clausula = clausula + Chr (&HE1)
					actionsUsed (&HE1) = -1
				Case "RECHARGE":
					clausula = clausula + Chr (&HE2)
					actionsUsed (&HE2) = -1
				Case "FLICKER":
					clausula = clausula + Chr (&H32)
					actionsUsed (&H32) = -1
				Case "DIZZY":
					clausula = clausula + Chr (&H33)
					actionsUsed (&H33) = -1
				Case "TEXT":
					clausula = clausula + Chr (&HE3)
					for ai = 1 To Len (listaPalabras (1))
						if ai = 31 Then Exit For
						If Mid (listaPalabras (1), ai, 1) = "_" Then
							clausula = clausula + Chr (0)
						Else
							clausula = clausula + Chr (Asc(Mid (listaPalabras (1), ai, 1)) - 32)
						End If
					Next ai
					clausula = clausula + Chr (&HEE)
					actionsUsed (&HE3) = -1
				Case "GAME":
					clausula = clausula + Chr (240)
					actionsUsed (240) = -1
				Case "WIN":
					clausula = clausula + Chr (241)
					actionsUsed (241) = -1
				Case "END":
					clausula = clausula + Chr (255)
					clausula = Chr (len (clausula)) + clausula
					clausulas = clausulas + clausula
					numclausulas = 0
					estado = 0
					clausula = ""
			End Select
		End if
	wend
	procesaClausulas = Clausulas + Chr (255)
End Function

Dim f As Integer
Dim i As Integer
Dim nPant As Integer
Dim linea As String
Dim clausulas As String
dim o as String

Dim inFileName As String
Dim outFileName As String
Dim maxpants As Integer

' TODO: Comprobaci�n de la entrada
'inFileName = "test.spt"
'outFileName = "msc.h"
inFileName = command (1)
outFileName = command (2)
maxpants = pval (command (3))

print "msc para MTE MK1 v4.7"

if command (1) = "" or command (2) = "" or maxpants = 0 then
	print "uso: msc input output maxpants"
	system
end if

maxItem = 0
maxFlag = 0
maxNPant = 0

For i = 1 to LIST_CLAUSULES_SIZE
	listaClausulasEnter (i) = -1
	listaClausulasFire (i) = -1
Next i

' Abrimos el archivo de entrada
f = Freefile
Open inFileName for input as #f

' Esto es una m�quina de estados.

While not eof (f)

	Line input #f, linea
	linea = Trim (linea, Any chr (32) + chr (9))
	stringToArray (linea)
	
	' ESTADO 1: Buscando ENTERING SCREEN x � PRESS_FIRE AT SCREEN x
	Select Case listaPalabras (0)
		Case "ENTERING":
			If listaPalabras (1) = "GAME" Then
				AddToIdx = 1
				AddTo (0) = maxpants
			ElseIf listaPalabras (1) = "ANY" Then
				AddToIdx = 1
				AddTo (0) = maxpants + 1
			Else
				AddToIdx = 0
				For i = 2 to LIST_WORDS_SIZE
					If listaPalabras (i) <> "" And listaPalabras (i) <> "," Then
						AddTo (AddToIdx) = val (listaPalabras (i))
						AddToIdx = AddToIdx + 1
					End If
				Next i
			End If
			clausulas = procesaClausulas (f, 0)
			clausulasEnter (clausulasEnterIdx) = clausulas	
			For i = 0 To AddToIdx - 1
				listaClausulasEnter (AddTo(i)) = clausulasEnterIdx
				'?"listaClausulasEnter (" & AddTo(i) & ") = " & clausulasEnterIdx
			Next i
			
			clausulasEnterIdx = clausulasEnterIdx + 1
		Case "PRESS_FIRE":
			If listaPalabras (2) = "ANY" Then
				AddToIdx = 1
				AddTo (0) = maxpants
			Else
				AddToIdx = 0
				For i = 3 to LIST_WORDS_SIZE
					If listaPalabras (i) <> "" And listaPalabras (i) <> "," Then
						AddTo (AddToIdx) = val (listaPalabras (i))
						AddToIdx = AddToIdx + 1
					End If
				Next i
			End If
			clausulas = procesaClausulas (f, 0)
			clausulasFire (clausulasFireIdx) = clausulas
			
			For i = 0 To AddToIdx - 1
				listaClausulasFire (AddTo(i)) = clausulasFireIdx
			Next i
			
			clausulasFireIdx = clausulasFireIdx + 1
	End Select
Wend

' Fin
Close #f

' Y cuando tenemos todo esto lleno, tenemos que sacar 
' el c�digo que interpreta los scripts y los scripts
' en s� en #asm con etiquetas y luego un array de etiquetas.

' Esta es, en realidad, la parte complicada y eso. Pero
' tampoco es demasiado moco de pavo.

f = FreeFile
open "msc-config.h" for output as #f

print #f, "// msc.h"
print #f, "// Generado por Mojon Script Compiler de la Churrera"
print #f, "// Copyleft 2011 The Mojon Twins"
print #f, " "
If clausulasUsed (&H1) Or clausulasUsed (&H2) Then
	print #f, "#define MSC_MAXITEMS    " + str (32)
	print #f, " "
	print #f, "typedef struct {"
	print #f, "    unsigned char status;"
	print #f, "    unsigned char supertile;"
	print #f, "    unsigned char n_pant;"
	print #f, "    unsigned char x, y;"
	print #f, "} ITEM;"
	print #f, "ITEM items [MSC_MAXITEMS];"
	print #f, " "
End If
print #f, "unsigned char script_result = 0;"
print #f, "unsigned char script_something_done = 0;"
print #f, " "
close #f

open outFileName for output as #f
print #f, "// msc.h"
print #f, "// Generado por Mojon Script Compiler de la Churrera"
print #f, "// Copyleft 2011 The Mojon Twins"
print #f, " "
print #f, "// Script data & pointers"

for i = 0 to clausulasEnterIdx - 1
	print #f, "extern unsigned char mscce_"+trim(str(i))+" [];"
Next i
	
For i = 0 To clausulasFireIdx - 1
	print #f, "extern unsigned char msccf_"+trim(str(i))+" [];"
next i

print #f, " "
print #f, "unsigned char *e_scripts [] = {"
o = ""
for i = 0 to maxpants + 1
	if listaClausulasEnter (i) <> -1 Then
		o = o + "mscce_"+trim(str(listaClausulasEnter (i)))
	else
		o = o + "0"
	end if
	if i < maxpants + 1 then o = o +", "
next i
print #f, "    " + o
print #f, "};"

print #f, " "
print #f, "unsigned char *f_scripts [] = {"
o = ""
for i = 0 to maxpants
	if listaClausulasFire (i) <> -1 Then
		o = o + "msccf_"+trim(str(listaClausulasFire (i)))
	else
		o = o + "0"
	end if
	if i < maxpants then o = o +", "
next i
print #f, "    " + o
print #f, "};"

print #f, " "
print #f, "#asm"
For i = 0 to clausulasEnterIdx - 1
	print #f, "._mscce_" + Trim (Str (i))
	print #f, "    defb " + writeMe (clausulasEnter (i))
Next i
For i = 0 To clausulasFireIdx - 1
	print #f, "._msccf_" + Trim (Str (i))
	print #f, "    defb " + writeMe (clausulasFire (i))
Next i

print #f, "#endasm"

print #f, " "
print #f, "unsigned char *script;"
print #f, "unsigned char *next_script;"
print #f, "unsigned char sc_i, sc_x, sc_y, sc_c, sc_n, sc_m, sc_terminado, sc_continuar, sc_res;"
print #f, " "
print #f, "void msc_init_all () {"
If clausulasUsed (&H1) Or clausulasUsed (&H2) Then
	print #f, "    for (sc_i = 0; sc_i < MSC_MAXITEMS; sc_i ++)"
	print #f, "        items [sc_i].status = 0;"
End If
print #f, "    for (sc_i = 0; sc_i < MAX_FLAGS; sc_i ++)"
print #f, "        flags [sc_i] = 0;"
print #f, "}"
print #f, " "
print #f, "unsigned char read_byte () {"
print #f, "    sc_c = script [0];"
print #f, "    script ++;"
print #f, "    return sc_c;"
print #f, "}"
print #f, " "
print #f, "unsigned char read_vbyte () {"
print #f, "    sc_c = read_byte ();"
print #f, "    if (sc_c & 128) return flags [sc_c & 127];"
print #f, "    return sc_c;"
print #f, "}"
print #f, " "
print #f, "// Ejecutamos el script apuntado por *script:"
print #f, "unsigned char run_script () {"
print #f, "    sc_res = 0;"
print #f, "    sc_terminado = 0;"
print #f, "    sc_continuar = 0;"
print #f, " "
print #f, "    if (script == 0)"
print #f, "        return; "
print #f, " "
print #f, "    script_something_done = 0;"
print #f, " "
print #f, "    while (1) {"
print #f, "        sc_c = read_byte ();"
print #f, "        if (sc_c == 0xFF) break;"
print #f, "        next_script = script + sc_c;"
print #f, "        sc_terminado = sc_continuar = 0;"
print #f, "        while (!sc_terminado) {"
print #f, "            sc_c = read_byte ();"
print #f, "            switch (sc_c) {"

if clausulasUsed (&H1) Then
	print #f, "                case 0x01:"
	print #f, "                    // IF PLAYER_HAS_ITEM x"
	print #f, "                    // Opcode: 01 x"
	print #f, "                    sc_x = read_vbyte ();"
	print #f, "                    if (items [sc_x].status == 0)"
	print #f, "                        sc_terminado = 1;"
	print #f, "                    break;"
end if

if clausulasUsed (&H2) Then
	print #f, "                case 0x02:"
	print #f, "                    // IF PLAYER_HASN'T_ITEM x"
	print #f, "                    // Opcode: 02 sc_x"
	print #f, "                    sc_x = read_vbyte ();"
	print #f, "                    if (items [sc_x].status != 0)"
	print #f, "                        sc_terminado = 1;"
	print #f, "                    break;"
end if

if clausulasUsed (&H10) Then
	print #f, "                case 0x10:"
	print #f, "                    // IF FLAG x = n"
	print #f, "                    // Opcode: 10 x n"
	print #f, "                    sc_x = read_vbyte ();"
	print #f, "                    sc_n = read_vbyte ();"	
	print #f, "                    if (flags [sc_x] != sc_n)"
	print #f, "                        sc_terminado = 1;"
	print #f, "                    break;"
end if

if clausulasUsed (&H11) Then
	print #f, "                case 0x11:"
	print #f, "                    // IF FLAG x < n"
	print #f, "                    // Opcode: 11 x n"
	print #f, "                    sc_x = read_vbyte ();"
	print #f, "                    sc_n = read_vbyte ();"	
	print #f, "                    if (flags [sc_x] >= sc_n)"
	print #f, "                        sc_terminado = 1;"
	print #f, "                    break;"
end if

if clausulasUsed (&H12) Then
	print #f, "                case 0x12:"
	print #f, "                    // IF FLAG x > n"
	print #f, "                    // Opcode: 12 x n"
	print #f, "                    sc_x = read_vbyte ();"
	print #f, "                    sc_n = read_vbyte ();"	
	print #f, "                    if (flags [sc_x] <= sc_n)"
	print #f, "                        sc_terminado = 1;"
	print #f, "                    break;"
end if

if clausulasUsed (&H13) Then
	print #f, "                case 0x13:"
	print #f, "                    // IF FLAG x <> n"
	print #f, "                    // Opcode: 13 x n"
	print #f, "                    sc_x = read_vbyte ();"
	print #f, "                    sc_n = read_vbyte ();"	
	print #f, "                    if (flags [sc_x] == sc_n)"
	print #f, "                        sc_terminado = 1;"
	print #f, "                    break;"
end if

if clausulasUsed (&H14) Then
	print #f, "                case 0x14:"
	print #f, "                    // IF FLAG x = FLAG y"
	print #f, "                    // Opcode: 14 x n"
	print #f, "                    sc_x = read_vbyte ();"
	print #f, "                    sc_y = read_vbyte ();"	
	print #f, "                    if (flags [sc_x] != flags [sc_y])"
	print #f, "                        sc_terminado = 1;"
	print #f, "                    break;"
end if

if clausulasUsed (&H15) Then
	print #f, "                case 0x15:"
	print #f, "                    // IF FLAG x < FLAG y"
	print #f, "                    // Opcode: 15 x n"
	print #f, "                    sc_x = read_vbyte ();"
	print #f, "                    sc_y = read_vbyte ();"	
	print #f, "                    if (flags [sc_x] >= flags [sc_y])"
	print #f, "                        sc_terminado = 1;"
	print #f, "                    break;"
end if

if clausulasUsed (&H16) Then
	print #f, "                case 0x16:"
	print #f, "                    // IF FLAG x > FLAG y"
	print #f, "                    // Opcode: 16 x n"
	print #f, "                    sc_x = read_vbyte ();"
	print #f, "                    sc_y = read_vbyte ();"	
	print #f, "                    if (flags [sc_x] <= flags [sc_y])"
	print #f, "                        sc_terminado = 1;"
	print #f, "                    break;"
end if

if clausulasUsed (&H17) Then
	print #f, "                case 0x17:"
	print #f, "                    // IF FLAG x <> FLAG y"
	print #f, "                    // Opcode: 17 x n"
	print #f, "                    sc_x = read_vbyte ();"
	print #f, "                    sc_y = read_vbyte ();"	
	print #f, "                    if (flags [sc_x] == flags [sc_y])"
	print #f, "                        sc_terminado = 1;"
	print #f, "                    break;"
end if

if clausulasUsed (&H20) Then
	print #f, "                case 0x20:"
	print #f, "                    // IF PLAYER_TOUCHES x, y"
	print #f, "                    // Opcode: 20 x y"
	print #f, "                    sc_x = read_vbyte ();"
	print #f, "                    sc_y = read_vbyte ();"	
	print #f, "                    if (!((player.x >> 6) >= (sc_x << 4) - 15 && (player.x >> 6) <= (sc_x << 4) + 15 && (player.y >> 6) >= (sc_y << 4) - 15 && (player.y >> 6) <= (sc_y << 4) + 15))"
	print #f, "                        sc_terminado = 1;"
	print #f, "                    break;"
end if

if clausulasUsed (&H21) Then
	print #f, "                case 0x21:"
	print #f, "                    // IF PLAYER_IN_X x1, x2"
	print #f, "                    // Opcode: 21 x1 x2"
	print #f, "                    sc_x = read_byte ();"
	print #f, "                    sc_y = read_byte ();"	
	print #f, "                    if (!((player.x >> 6) >= sc_x && (player.x >> 6) <= sc_y))"
	print #f, "                        sc_terminado = 1;"
	print #f, "                    break;"
end if
	
if clausulasUsed (&H22) Then
	print #f, "                case 0x22:"
	print #f, "                    // IF PLAYER_IN_Y y1, y2"
	print #f, "                    // Opcode: 22 y1 y2"
	print #f, "                    sc_x = read_byte ();"
	print #f, "                    sc_y = read_byte ();"	
	print #f, "                    if (!((player.y >> 6) >= sc_x && (player.y >> 6) <= sc_y))"
	print #f, "                        sc_terminado = 1;"
	print #f, "                    break;"
end if

if clausulasUsed (&H30) Then
	print #f, "                case 0x30:"
	print #f, "                    // IF ALL_ENEMIES_DEAD"
	print #f, "                    // Opcode: 30"
	print #f, "                    if (player.killed != BADDIES_COUNT)"
	print #f, "                        sc_terminado = 1;"
	print #f, "                    break;"
end if

if clausulasUsed (&H31) Then
	print #f, "                case 0x31:"
	print #f, "                    // IF ENEMIES_KILLED_EQUALS n"
	print #f, "                    // Opcode: 31 n"
	print #f, "                    sc_n = read_vbyte ();"
	print #f, "                    if (player.killed != sc_n)"
	print #f, "                        sc_terminado = 1;"
	print #f, "                    break;"
End If

if clausulasUsed (&H40) Then
	print #f, "                case 0x40:"
	print #f, "                     // IF PLAYER_HAS_OBJECTS"
	print #f, "                     // Opcode: 40"
	print #f, "                     if (player.objs == 0)"
	print #f, "                         sc_terminado = 1;"
	print #f, "                     break;"
End If

If clausulasUsed (&H50) Then
	print #f, "                case 0x50:"
	print #f, "                     // IF NPANT n"
	print #f, "                     // Opcode: 50 n"
	print #f, "                     sc_n = read_vbyte ();"
	print #f, "                     if (n_pant != sc_n)"
	print #f, "                         sc_terminado = 1;"
	print #f, "                     break;"
End If

If clausulasUsed (&H51) Then
	print #f, "                case 0x51:"
	print #f, "                     // IF NPANT_NOT n"
	print #f, "                     // Opcode: 51 n"
	print #f, "                     sc_n = read_vbyte ();"
	print #f, "                     if (n_pant == sc_n)"
	print #f, "                         sc_terminado = 1;"
	print #f, "                     break;"
End If

if clausulasUsed (&HF0) Then
	print #f, "                case 0xF0:"
	print #f, "                     // IF TRUE"
	print #f, "                     // Opcode: F0"
	print #f, "                     break;"
End If

print #f, "                case 0xFF:"
print #f, "                    // THEN"
print #f, "                    // Opcode: FF"
print #f, "                    sc_terminado = 1;"
print #f, "                    sc_continuar = 1;"
print #f, "                    script_something_done = 1;"
print #f, "                    break;"

print #f, "            }"
print #f, "        }"

print #f, "        if (sc_continuar) {"
print #f, "            sc_terminado = 0;"
print #f, "            while (!sc_terminado) {"
print #f, "                sc_c = read_byte ();"
print #f, "                switch (sc_c) {"

if actionsUsed (&H0) Then
	print #f, "                    case 0x00:"
	print #f, "                        // SET ITEM x n"
	print #f, "                        // Opcode: 00 x n"
	print #f, "                        sc_x = read_vbyte ();"
	print #f, "                        sc_n = read_vbyte ();"
	print #f, "                        items [sc_x].status = sc_n;"
	print #f, "                        break;"
End If

if actionsUsed (&H1) Then
	print #f, "                    case 0x01:"
	print #f, "                        // SET FLAG x = n"
	print #f, "                        // Opcode: 01 x n"
	print #f, "                        sc_x = read_vbyte ();"
	print #f, "                        sc_n = read_vbyte ();"
	print #f, "                        flags [sc_x] = sc_n;"
	print #f, "                        break;"
End If

if actionsUsed (&H10) Then
	print #f, "                    case 0x10:"
	print #f, "                        // INC FLAG x, n"
	print #f, "                        // Opcode: 10 x n"
	print #f, "                        sc_x = read_vbyte ();"
	print #f, "                        sc_n = read_vbyte ();"
	print #f, "                        flags [sc_x] += sc_n;"
	print #f, "                        break;"
End If

if actionsUsed (&H11) Then
	print #f, "                    case 0x11:"
	print #f, "                        // DEC FLAG x, n"
	print #f, "                        // Opcode: 11 x n"
	print #f, "                        sc_x = read_vbyte ();"
	print #f, "                        sc_n = read_vbyte ();"
	print #f, "                        flags [sc_x] -= sc_n;"
	print #f, "                        break;"
End If

if actionsUsed (&H12) Then
	print #f, "                    case 0x12:"
	print #f, "                        // ADD FLAGS x, y"
	print #f, "                        // Opcode: 12 x y"
	print #f, "                        sc_x = read_vbyte ();"
	print #f, "                        sc_y = read_vbyte ();"
	print #f, "                        flags [sc_x] = flags [sc_x] + flags [sc_y];"
	print #f, "                        break;"
End If

if actionsUsed (&H13) Then
	print #f, "                    case 0x13:"
	print #f, "                        // SUB FLAGS x, y"
	print #f, "                        // Opcode: 13 x y"
	print #f, "                        sc_x = read_vbyte ();"
	print #f, "                        sc_y = read_vbyte ();"
	print #f, "                        flags [sc_x] = flags [sc_x] - flags [sc_y];"
	print #f, "                        break;"
End If

if actionsUsed (&H14) Then
	print #f, "                    case 0x14:"
	print #f, "                        // SWAP FLAGS x, y"
	print #f, "                        // Opcode: 14 x y"
	print #f, "                        sc_x = read_vbyte ();"
	print #f, "                        sc_y = read_vbyte ();"
	print #f, "                        sc_n = flags [sc_x];"
	print #f, "                        flags [sc_x] = flags [sc_y];"
	print #f, "                        flags [sc_y] = sc_n;"
	print #f, "                        break;"
End If

if actionsUsed (&H20) Then
	print #f, "                    case 0x20:"
	print #f, "                        // SET TILE (x, y) = n"
	print #f, "                        // Opcode: 20 x y n"
	print #f, "                        sc_x = read_vbyte ();"
	print #f, "                        sc_y = read_vbyte ();"
	print #f, "                        sc_n = read_vbyte ();"
	print #f, "                        map_buff [sc_x + (sc_y << 4) - sc_y] = sc_n;"
	print #f, "                        map_attr [sc_x + (sc_y << 4) - sc_y] = comportamiento_tiles [sc_n];"
	print #f, "                        draw_coloured_tile (VIEWPORT_X + sc_x + sc_x, VIEWPORT_Y + sc_y + sc_y, sc_n);"
	print #f, "                        break;"
End If

if actionsUsed (&H30) Then
	print #f, "                    case 0x30:"
	print #f, "                        // INC LIFE n"
	print #f, "                        // Opcode: 30 n"
	print #f, "                        sc_n = read_vbyte ();"
	print #f, "                        player.life += sc_n;"
	print #f, "                        break;"
End If

if actionsUsed (&H31) Then
	print #f, "                    case 0x31:"
	print #f, "                        // DEC LIFE n"
	print #f, "                        // Opcode: 31 n"
	print #f, "                        sc_n = read_vbyte ();"
	print #f, "                        player.life -= sc_n;"
	print #f, "                        break;"
End If

if actionsUsed (&H32) Then
	print #f, "                    case 0x32:"
	print #f, "                        // FLICKER"
	print #f, "                        // Opcode: 32"
	print #f, "                        player.estado |= EST_PARP;"
	print #f, "                        player.ct_estado = 32;"
	print #f, "                        break;"
End If

if actionsUsed (&H33) Then
	print #f, "                    case 0x33:"
	print #f, "                        // DIZZY"
	print #f, "                        // Opcode: 33"
	print #f, "                        player.estado |= EST_DIZZY;"
	print #f, "                        player.ct_estado = 32;"
	print #f, "                        break;"
End If

if actionsUsed (&H40) Then
	print #f, "                    case 0x40:"
	print #f, "                        // INC OBJECTS n"
	print #f, "                        // Opcode: 40 n"
	print #f, "                        sc_n = read_vbyte ();"
	print #f, "                        player.objs += sc_n;"
	print #f, "                        break;"
End If

if actionsUsed (&H41) Then
	print #f, "                    case 0x41:"
	print #f, "                        // DEC OBJECTS n"
	print #f, "                        // Opcode: 41 n"
	print #f, "                        sc_n = read_vbyte ();"
	print #f, "                        player.objs -= sc_n;"
	print #f, "                        break;"
End If

if actionsUsed (&H50) then
	print #f, "                    case 0x50:"
	print #f, "                        // PRINT_TILE_AT (X, Y) = N"
	print #f, "                        // Opcode: 50 x y n"
	print #f, "                        sc_x = read_vbyte ();"
	print #f, "                        sc_y = read_vbyte ();"
	print #f, "                        sc_n = read_vbyte ();"
	print #f, "                        draw_coloured_tile (sc_x, sc_y, sc_n);"
	print #f, "                        break;"
end if

if actionsUsed (&H51) Then
	print #f, "                    case 0x51:"
	print #f, "                        // SET_FIRE_ZONE x1, y1, x2, y2"
	print #f, "                        // Opcode: 51 x1 y1 x2 y2"
	print #f, "                        fzx1 = read_byte ();"
	print #f, "                        fzy1 = read_byte ();"
	print #f, "                        fzx2 = read_byte ();"
	print #f, "                        fzy2 = read_byte ();"
	print #f, "                        f_zone_ac = 1;"
	print #f, "                        break;"
End If

if actionsUsed (&HE0) Then
	print #f, "                    case 0xE0:"
	print #f, "                        // SOUND n"
	print #f, "                        // Opcode: E0 n"
	print #f, "                        sc_n = read_vbyte ();"
	print #f, "                        peta_el_beeper (sc_n);"
	print #f, "                        break;"
End If

If actionsUsed (&HE1) Then
	print #f, "                    case 0xE1:"
	print #f, "                        // SHOW"
	print #f, "                        // Opcode: E1"
	print #f, "                        sp_UpdateNow ();"
	print #f, "                        break;"
End If

if actionsUsed (&HE2) Then
	print #f, "                    case 0xE2:"
	print #f, "                        // RECHARGE"
	print #f, "                        player.life = PLAYER_LIFE;"
	print #f, "                        break;"
End If

if actionsUsed (&HE3) Then
	print #f, "                    case 0xE3:"
	print #f, "                        sc_x = 0;"
	print #f, "                        while (1) {"
	print #f, "                           sc_n = read_byte ();"
	print #f, "                           if (sc_n == 0xEE) break;"
	print #f, "                           sp_PrintAtInv (LINE_OF_TEXT, LINE_OF_TEXT_X + sc_x, 71, sc_n);"
	print #f, "                           sc_x ++;"
	print #f, "                        }"
	print #f, "                        break;"
End If

if actionsUsed (&HF0) Then
	print #f, "                    case 0xF0:"
	print #f, "                        script_result = 2;"
	print #f, "                        sc_terminado = 1;"
	print #f, "                        break;"
End If

if actionsUsed (&HF1) Then
	print #f, "                    case 0xF1:"
	print #f, "                        script_result = 1;"
	print #f, "                        sc_terminado = 1;"
	print #f, "                        break;"
End If

print #f, "                    case 0xFF:"
print #f, "                        sc_terminado = 1;"
print #f, "                        break;"
print #f, "                }"
print #f, "            }"
print #f, "        }"
print #f, "        script = next_script;"
print #f, "    }"
print #f, " "
print #f, "    return sc_res;"
print #f, "}"

' Fin
Close #f

' Joer, qu� guarrada, pero no veas c�mo funciona... Incredibly evil.
' Po eso. 
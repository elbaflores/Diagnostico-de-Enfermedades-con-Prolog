
:- use_module(library(pce)).
:- use_module(library(pce_style_item)).

main:-
	new(Menu, dialog('Diagnostico de Enfermedades S-5', size(500,500))),
	new(L, label(nombre, '�Hola! Puedo Ayudar a saber que Tienes.')),
	new(@texto, label(nombre, 'Responde y tendra su resultado:')),
	new(@respl, label(nombre, '')),
	new(Salir, button('Salir', and(message(Menu,destroy), message(Menu, free)))),
	new(@boton, button('Realizar test', message(@prolog, botones))),
	send(Menu, append(L)), new(@btncarrera, button('�Diagnostico?')),
	send(Menu,display,L,point(100,20)),
	send(Menu,display,@boton,point(130,150)),
	send(Menu,display,@texto,point(50,100)),
	send(Menu,display,Salir,point(20,400)),
	send(Menu,display,@respl,point(20,130)),
	send(Menu,open_centered).

enfermedades(colesterol):- colesterol,!.
enfermedades(diabetes):- diabetes,!.
enfermedades(ebola):-ebola,!.
enfermedades(gastritis):-gastritis,!.
enfermedades(neumonia):-neumonia,!.
enfermedades(parkinson):-parkinson,!.
enfermedades(asma):-asma,!.
enfermedades('�Ups! No estoy entrenado para darte ese diagnostico').


colesterol :-
	tiene_colesterol,
	pregunta('�Tiene hinchazon en alguna extremidad?'),
	pregunta('�Tiene perdida del equilibrio?'),
	pregunta('�Tiene dolor de cabeza?'),
	pregunta('�Tiene amarillos los ojos?'),
	pregunta('�Tiene adormecimiento en alguna extremidad?'),
	pregunta('�Tiene agitacion,como ser al caminar?'),
	pregunta('�Siente dolor en el pecho?').

diabetes :-
	tiene_diabetes,
	pregunta('�Siente ganas de orina frecuente?'),
	pregunta('�Tiene sed constante?'),
	pregunta('�Tiene hambre excesiva?'),
	pregunta('�Perdida de peso inexplicable?'),
	pregunta('�Se siente fatigado?'),
	pregunta('�Tiene irritabilidad?').

ebola :-
	tiene_ebola,
	pregunta('�Presenta dolores musculares?'),
	pregunta('�Tiene v�mito y diarrea?'),
	pregunta('�Presenta erupciones cutaneas?'),
	pregunta('�Siente debilidad intensa?'),
	pregunta('�Tiene dolor de garganta?').

gastritis :-
	tiene_gastritits,
	pregunta('�Tiene acidez estomacal?'),
	pregunta('�Presenta aerofagia?'),
	pregunta('�Tiene ausencia de hambre?'),
	pregunta('�Presenta heces de color negro o con sangrado?'),
	pregunta('�Tiene n�useas?').

neumonia :-
	tiene_neumonia,
	pregunta('�Tiene dolores articulares?'),
	pregunta('�Tiene tos constantemenete?'),
	pregunta('�Presenta escalofrios?'),
	pregunta('�Presenta dificultad para respirar?').

parkinson :-
	tiene_parkinson,
	pregunta('�Tiene dolores articulares?'),
	pregunta('�Tiene perdidad de movimiento en alguna extremidad?'),
	pregunta('�Presenta rigidez severa en alguna region muscular?'),
	pregunta('�Sufre de depresi�n?'),
	pregunta('�Presenta algun trastorno en el sue�o?').
asma :-
	tiene_asma,
	pregunta('�Tiene falta de aire frecuentemente?'),
	pregunta('�Tiene tos?'),
	pregunta('Tiene sibilancias?'),
	pregunta('Tiene presion en el pecho?'),
	pregunta('Tiene dificultad para respirar?').


%desconocido :- se_desconoce_enfermedad.

tiene_colesterol:-	pregunta('�Tiene vision borrosa?').
tiene_diabetes:-	pregunta('�Tiene vision borrosa?').
tiene_ebola:-		pregunta('�Tiene fiebre?').
tiene_gastritits:-	pregunta('�Tiene dolor abdominal?').
tiene_neumonia:-	pregunta('�Tiene fiebre?').
tiene_parkinson:-	pregunta('�Presenta temblor en alguna de las extremidades superiores del cuerpo?').
tiene_asma:- pregunta('�Tiene dificultad para respirar?').

:-dynamic si/1,no/1.


preguntar(Problema):-new(Di, dialog('Examen Medico')),
	new(L2, label(texto,'Responde las siguientes preguntas')),
	new(La, label(prob,Problema)),

	new(B1,button(si,and(message(Di,return,si)))),
	new(B2,button(no,and(message(Di,return,no)))),

	send(Di,append(L2)),
	send(Di,append(La)),
	send(Di,append(B1)),
	send(Di,append(B2)),

	send(Di,default_button,si),
	send(Di,open_centered),
	get(Di,confirm,Answer),
	write(Answer),send(Di,destroy),


	((Answer==si)->assert(si(Problema)); assert(no(Problema)),fail).

pregunta(S):- (si(S)->true; (no(S)->fail;preguntar(S))).
limpiar:- retract(si(_)),fail.
limpiar:- retract(no(_)),fail.
limpiar.


botones :-lim,
	send(@boton,free),
	send(@btncarrera,free),
	enfermedades(Enter),
	send(@texto, selection('De acuerdo con sus respuestas,usted padece de:')),
	send(@respl, selection(Enter)),
	new(@boton, button('Iniciar su evaluaci�n', message(@prolog, botones))),
	send(Menu,display,@boton,point(40,50)),
	send(Menu,display,@btncarrera,point(20,50)),
	limpiar.

lim:- send(@respl, selection('')).

limpiar2:-
	send(@texto,free),
	send(@respl,free),
*	%send(@btncarrera,free),
	send(@boton,free).





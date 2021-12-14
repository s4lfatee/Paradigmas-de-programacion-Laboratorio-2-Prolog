% TDA Fecha
% El TDA Fecha se representa a traves de una lista que almacena un dia
% de tipo entero, un mes de tipo entero, y un anho de tipo entero.

% Constructor
date(Dia,Mes,Year, [Dia,Mes,Year]):-
            number(Dia),number(Mes),number(Year),
            Mes > 0, (Mes < 12; Mes = 12).

% Selectores
getdia([Dia, _, _], Dia).

getmes([_, Mes, _], Mes).

getanho([_, _, Year], Year).





% TDA Paradigmadocs
% El TDA Paradigmadocs se representa a traves de una lista que almacena
% el nombre de la plataforma (string), y su fecha de creacion (tipo
% fecha) junto a dos listas que almacenaran los usuarios y sus
% documentos creados.

% Constructor
paradigmadocs(Name, Date, [Name, Date, [], [], []]).

% Selectores
getplatformname([Name,_,_,_,_], Name).

getplatformdate([_,Date,_,_,_], Date).

getlistausers([_,_,Listausers,_,_], Listausers).

getlistadocs([_,_,_,Listadocs,_], Listadocs).

getsesionactiva([_,_,_,_,SesionActiva], SesionActiva).




% TDA Usuario
% El TDA Usuario se representa a traves de una lista que almacena el
% nombre de un usuario (string), su contrasenha (string) y su fecha de
% registro (tipo fecha)

% Constructor
usuario(Username, Password, UserDate, [Username, Password, UserDate]).


% Selectores
getusername([Username,_,_], Username).

getpassword([_, Password,_], Password).

getUserDate([_,_, UserDate], UserDate).




% TDA Documento
% El TDA Documento se representa a traves de una lista que almacena el
% titulo de un documento (String), su fecha de creacion (tipo fecha),
% contenido (string), un valor de identificacion (entero), el duenho del
% documento y dos listas para los accesos del documento y su historial
% de versiones.

% Constructor
documento(Titulo, FechaDoc, Contenido, Id, Owner, [Titulo, FechaDoc, Contenido, Id, Owner, [], []]).

% Selectores
gettitulo([Titulo, _, _, _, _, _, _], Titulo).

getfechaDoc([_, FechaDoc, _, _, _, _, _], FechaDoc).

getContenido([_, _, Contenido, _, _, _, _], Contenido).

getIdDoc([_, _, _, Iddoc, _, _, _], Iddoc).

getOwner([_, _, _, _, Owner, _, _], Owner).

getAccessList([_, _, _, _, _ , AccessList, _], AccessList).

getVersionList([_, _, _, _, _, _, VersionList], VersionList).


getallusernames(ListaUsers, UsernamesList) :- maplist(nth0(0), ListaUsers, UsernamesList).

% Funcion paradigmaDocsRegister
paradigmaDocsRegister(Sn1, Fecha, Username, Password, Sn2) :-
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            usuario(Username, Password, Fecha, NuevoUsuario),
            getallusernames(U, UsernamesList),
            not(member(Username, UsernamesList)),
            append(U, [NuevoUsuario], NuevaLista),
            Sn2 = [N, F, NuevaLista, D, S], !.

% Funcion paradigmaDocsLogin
paradigmaDocsLogin(Sn1, Username, Password, Sn2) :-
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            member([Username, Password, _], U),
            append(S, Username, SesionLogueada),
            Sn2 = [N, F, U, D, SesionLogueada], !.

            
paradigmaDocsCreate(Sn1, Fecha, Nombre, Contenido, Sn2) :-
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            length(D, LargoDocs),
            nth0(0, S, UserLogueado),
            documento(Nombre, Fecha, Contenido, LargoDocs, UserLogueado, NuevoDoc),
            append(D, [NuevoDoc], NuevaListaDocs),
            Sn2 = [N, F, U, NuevaListaDocs, []].



/* Ejemplos


Ejemplo de paradigmadocs y paradigmaDocsRegister
date(20, 12, 2015, D1), date(1, 12, 2021, D2), date(3, 12, 2021, D3), paradigmadocs("google docs", D1, PD1), paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2), paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3), paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4).



*/
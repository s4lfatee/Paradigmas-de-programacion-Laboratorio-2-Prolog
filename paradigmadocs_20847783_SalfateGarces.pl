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

getuserlogueado([S], S).

% Otros predicados de paradigmadocs
getallusernames(ListaUsers, UsernamesList) :- maplist(listref(0), ListaUsers, UsernamesList), !.

append_final(Item, Lista, [Lista|Item]).

unirlistas(ListadePermisos, ListaUsers, ListaDeAccesos) :- maplist(append_final([ListadePermisos]), ListaUsers, ListaDeAccesos).

verificadorusers([], _) :- !.
verificadorusers([FirstUser|NextUsers], UsuariosRegistrados) :- ownmember(FirstUser, UsuariosRegistrados), 
                                                                verificadorusers(NextUsers, UsuariosRegistrados).

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
documento(Titulo, FechaDoc, Contenido, Id, Owner, [Titulo, FechaDoc, Contenido, Id, Owner, [], [[Titulo, FechaDoc, Contenido, 0]]]).

documento2(Titulo, FechaDoc, Contenido, Id, Owner, ListaAccesos, ListaVersiones, [Titulo, FechaDoc, Contenido, Id, Owner, ListaAccesos, ListaVersiones]).

% Selectores
gettitulo([Titulo, _, _, _, _, _, _], Titulo).

getfechaDoc([_, FechaDoc, _, _, _, _, _], FechaDoc).

getContenido([_, _, Contenido, _, _, _, _], Contenido).

getIdDoc([_, _, _, Iddoc, _, _, _], Iddoc).

getOwner([_, _, _, _, Owner, _, _], Owner).

getAccessList([_, _, _, _, _ , AccessList, _], AccessList).

getVersionList([_, _, _, _, _, _, VersionList], VersionList).


% TDA Acceso
% El TDA Acceso se representa a través de una lista que almacena el nombre de usuario
% al que se le ha otorgado el permiso (string), y un tipo de acceso que alterna entre
% R, W, C (String).

% Constructor
acceso(NombreUser, TipoAcceso, [NombreUser, TipoAcceso]).

% Selectores
getaccessUser([NombreUser, _], NombreUser).

getaccessType([_, TipoAcceso], TipoAcceso).





% Implementación propia del predicado nth0
listref(0, [X], X).
listref(0, [H|_], H).
listref(I, [_|T], E) :- NuevoIndex is I-1, listref(NuevoIndex, T, E), !.


% Implementación propia del predicado member
ownmember(L, [L|_]):-!.
ownmember(L, [_|R]):-
            ownmember(L, R).

% Implementación de list-set
listset([_|T], 0, X, [X|T]).
listset([H|T], I, X, [H|R]) :-
            I > 0, NI is I-1, listset(T, NI, X, R).

% Implementación de eq?
equal(N1, N2) :-
            N1 == N2.

% Implementación de remove
delete(X,[X|T],T):-!.
delete(X,[Y|T],[Y|T1]):-delete(X,T,T1).

% Dominio: ListaTipoAccesos, Letra
verifyTypeAccess([], _) :- !, fail.
verifyTypeAccess([H|_], H).
verifyTypeAccess([_|T], AccessType) :- verifyTypeAccess(T, AccessType).

% Dominio: ListaDeAccesosDoc, User, Letter
checkAccesses([], _, _) :- !, fail.
checkAccesses([FirstAccess|_], User, Letter) :- 
            getaccessUser(FirstAccess, User), 
            getaccessType(FirstAccess, Accesses),
            verifyTypeAccess(Accesses, Letter), !.
checkAccesses([_|NextAccess], User, Letter) :-
            checkAccesses(NextAccess, User, Letter).


% Predicado paradigmaDocsRegister
paradigmaDocsRegister(Sn1, Fecha, Username, Password, Sn2) :-
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            usuario(Username, Password, Fecha, NuevoUsuario),
            getallusernames(U, UsernamesList),
            not(ownmember(Username, UsernamesList)),
            append(U, [NuevoUsuario], NuevaLista),
            Sn2 = [N, F, NuevaLista, D, S], !.

% Predicado paradigmaDocsLogin
paradigmaDocsLogin(Sn1, Username, Password, Sn2) :-
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            ownmember([Username, Password, _], U),
            append(S, [Username], SesionLogueada),
            Sn2 = [N, F, U, D, SesionLogueada], !.

% Predicado paradigmaDocsCreate           
paradigmaDocsCreate(Sn1, Fecha, Nombre, Contenido, Sn2) :-
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            length(D, LargoDocs),
            getuserlogueado(S, UserLogueado),
            documento(Nombre, Fecha, Contenido, LargoDocs, UserLogueado, NuevoDoc),
            append(D, [NuevoDoc], NuevaListaDocs),
            Sn2 = [N, F, U, NuevaListaDocs, []].


% Predicado paradigmaDocsShare
paradigmaDocsShare(Sn1, DocumentId, ListaPermisos, ListaUsernamesPermitidos, Sn2) :-
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            getuserlogueado(S, UserLogged),
            getallusernames(U, ListadeUsernames),
            listref(DocumentId, D, DocumentoMod),
            gettitulo(DocumentoMod, TituloDoc),
            getfechaDoc(DocumentoMod, FechaDocs),
            getContenido(DocumentoMod, ContentDoc),
            getIdDoc(DocumentoMod, IdDocumento),
            getOwner(DocumentoMod, Ownerdoc),
            getAccessList(DocumentoMod, ListadeAccesosDoc),
            getVersionList(DocumentoMod, ListaVerDoc),
            equal(UserLogged, Ownerdoc),
            (not(ownmember(Ownerdoc, ListaUsernamesPermitidos)) ; checkAccesses(ListadeAccesosDoc, UserLogged, "S"))
            verificadorusers(ListaUsernamesPermitidos, ListadeUsernames),
            unirlistas(ListaPermisos, ListaUsernamesPermitidos, ListaDeAccesos),
            append(ListaDeAccesos, ListadeAccesosDoc, NuevaListaAccess),
            documento2(TituloDoc, FechaDocs, ContentDoc, IdDocumento, Ownerdoc, NuevaListaAccess, ListaVerDoc, NuevoDocAccess),
            listset(D, DocumentId, NuevoDocAccess, NuevalistaDocs),
            Sn2 = [N, F, U, NuevalistaDocs, []].




% Predicado paradigmaDocsAdd
paradigmaDocsAdd(Sn1, DocumentId, Date, ContenidoTexto, Sn2) :-
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            getuserlogueado(S, UserLogged),
            listref(DocumentId, D, DocumentoMod),
            gettitulo(DocumentoMod, TituloDoc),
            getfechaDoc(DocumentoMod, FechaDocs),
            getContenido(DocumentoMod, ContentDoc),
            getIdDoc(DocumentoMod, IdDocumento),
            getOwner(DocumentoMod, Ownerdoc),
            getAccessList(DocumentoMod, ListadeAccesosDoc),
            getVersionList(DocumentoMod, ListaVerDoc),
            checkAccesses(ListadeAccesosDoc, UserLogged, "W"),




/* Ejemplos


Ejemplo de paradigmadocs y paradigmaDocsRegister
date(20, 12, 2015, D1), date(1, 12, 2021, D2), date(3, 12, 2021, D3), paradigmadocs("google docs", D1, PD1), paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2), paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3), paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4).

Ejemplo de paradigmaDocsCreate
date(20, 12, 2015, D1), date(1, 12, 2021, D2), date(3, 12, 2021, D3), paradigmadocs("google docs", D1, PD1), paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2), paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3), paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4), paradigmaDocsLogin(PD4, "vflores", "hola123", PD5), paradigmaDocsCreate(PD5, D2, "archivo 1", "hola mundo, este es el contenido de un archivo", PD6), paradigmaDocsLogin(PD6, "crios", "qwert", PD7), paradigmaDocsCreate(PD7, D2, "archivo2", "alex linda", PD8). paradigmaDocsLogin(PD8, "vflores", "hola123", PD9), paradigmaDocsShare(PD9, 0, ["R"], ["crios", "alopez"], PD10), paradigmaDocsLogin(PD10, "crios", "qwert", PD11), paradigmaDocsShare(PD11, 1, ["R", "C"], ["alopez"], PD12)

Ejemplo de paradigmaDocsShare
date(20, 12, 2015, D1), date(1, 12, 2021, D2), date(3, 12, 2021, D3), paradigmadocs("google docs", D1, PD1), paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2), paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3), paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4), paradigmaDocsLogin(PD4, "vflores", "hola123", PD5), paradigmaDocsCreate(PD5, D2, "archivo 1", "hola mundo, este es el contenido de un archivo", PD6), paradigmaDocsLogin(PD6, "crios", "qwert", PD7), paradigmaDocsCreate(PD7, D2, "archivo2", "alex linda", PD8), paradigmaDocsLogin(PD8, "vflores", "hola123", PD9), paradigmaDocsShare(PD9, 0, ["R"], ["crios", "alopez"], PD10), paradigmaDocsLogin(PD10, "crios", "qwert", PD11), paradigmaDocsShare(PD11, 1, ["R", "C"], ["alopez"], PD12)

*/
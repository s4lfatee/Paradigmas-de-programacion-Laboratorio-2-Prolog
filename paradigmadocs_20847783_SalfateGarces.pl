/*
*******************************************
TDA date
*******************************************
El TDA date se representa a traves de una lista que almacena un dia
de tipo entero, un mes de tipo entero, y un anho de tipo entero.

Dominios:       Dia: Entero      
                Mes: Entero
                Year: Entero
                Fecha: date

Predicados:
                date(Dia,Mes,Year, Fecha).                                                              Aridad = 4
                getdia(Fecha, Dia).                                                                     Aridad = 2
                getmes(Fecha, Mes).                                                                     Aridad = 2
                datetostring(FEcha, StrOut).                                                            Aridad = 2

Metas primarias:
                date
                datetostring

Metas secundarias:
                getdia
                getmes
                getanho
                atomics_to_string
                number
*/

% Constructor
date(Dia,Mes,Year, [Dia,Mes,Year]):-
            number(Dia),number(Mes),number(Year),
            Mes > 0, (Mes < 12; Mes = 12).

% Selectores
getdia([Dia, _, _], Dia).

getmes([_, Mes, _], Mes).

getanho([_, _, Year], Year).

% Otros predicados del TDA Date
datetostring(Fecha, StrOut) :-
            getdia(Fecha, DiaFecha),
            getmes(Fecha, MesFecha),
            getanho(Fecha, AnhoFecha),
            ListStr = [DiaFecha, "/", MesFecha, "/", AnhoFecha],
            atomics_to_string(ListStr, StrOut).




/*
*******************************************
TDA paradigmaDocs
*******************************************
El TDA paradigmaDocs se representa a traves de una lista que almacena
el nombre de la plataforma (string), y su fecha de creacion (tipo
fecha) junto a dos listas que almacenaran los usuarios y sus
documentos creados.

Dominios:       Name: String
                Date: date
                PD: paradigmaDocs
                SesionActiva: Lista
                Listausers: Lista
                AccesosUser: Lista
                ListaDeAccesos: Lista
                User: usuario
                ListUsers: Lista
                ListAccesses: Lista
                ListVersions: Lista
                ListDocs: Lista
                SesionActiva: Lista


Predicados:
                paradigmaDocs(Name, Date, PD).                                                          Aridad = 3
                getplatformname(PD, Name).                                                              Aridad = 2
                getplatformdate(PD, Date).                                                              Aridad = 2
                getlistausers(PD, Listausers).                                                          Aridad = 2
                getlistadocs(PD, Listadocs).                                                            Aridad = 2
                getsesionactiva(PD, SesionActiva).                                                      Aridad = 2
                getuserlogueado(SesionActiva).                                                          Aridad = 1
                getallusernames(Listausers, UsernamesList).                                             Aridad = 2
                unirlistas(ListadePermisos, ListaUsers, ListaDeAccesos).                                Aridad = 3
                verificadorusers(Listausers, Listausersregistrados).                                    Aridad = 2
                alluserstostring(ListUsers, ListStrUsers).                                              Aridad = 2
                allaccessestostring(ListAccesses, ListStrAccesses).                                     Aridad = 2
                allversionstostring(ListVersions, ListStrVersion).                                      Aridad = 2
                alldocumentstostring(ListDocs, ListStrDocs).                                            Aridad = 2
                userloggedexists(SesionActiva).                                                         Aridad = 1

Metas primarias:
                paradigmaDocs
                getallusernames
                unirlistas
                alluserstostring
                allaccessestostring
                allversionstostring
                alldocumentstostring
                userloggedexists
                getplatformname
                getplatformdate
                getlistausers
                getlistadocs
                getsesionactiva
                getuserlogueado

Metas secundarias:
                maplist
                getbyIndex
                append_final
                usertostring
                accesotostring
                versiontostring
                documentotostring
                length
*/

% Constructor
paradigmaDocs(Name, Date, [Name, Date, [], [], []]).

% Selectores
getplatformname([Name,_,_,_,_], Name).

getplatformdate([_,Date,_,_,_], Date).

getlistausers([_,_,Listausers,_,_], Listausers).

getlistadocs([_,_,_,Listadocs,_], Listadocs).

getsesionactiva([_,_,_,_,SesionActiva], SesionActiva).

getuserlogueado([S], S).

% Otros predicados de paradigmadocs
getallusernames(ListaUsers, UsernamesList) :- maplist(getbyIndex(0), ListaUsers, UsernamesList), !.

unirlistas(ListadePermisos, ListaUsers, ListaDeAccesos) :- maplist(append_final([ListadePermisos]), ListaUsers, ListaDeAccesos).

alluserstostring(ListUsers, ListStrUsers) :- maplist(usertostring(), ListUsers, ListStrUsers).
allaccessestostring(ListAccesses, ListStrAccesses) :- maplist(accesotostring(), ListAccesses, ListStrAccesses).
allversionstostring(ListVersions, ListStrVersion) :- maplist(versiontostring(), ListVersions, ListStrVersion).
alldocumentstostring(ListDocs, ListStrDocs) :- maplist(documentotostring(), ListDocs, ListStrDocs).

userloggedexists(SesionActiva) :-
                length(SesionActiva, Y),
                Y = 1.

/*
*******************************************
TDA Usuario
*******************************************
El TDA Usuario se representa a traves de una lista que almacena el
nombre de un usuario (string), su contrasenha (string) y su fecha de
registro (tipo fecha)

Dominios:       Username: String
                Password: String
                UserDate: date
                User: Usuario

Predicados:
                usuario(Username, Password, UserDate, User).                                            Aridad = 4
                getusername(User, Username).                                                            Aridad = 2
                getpassword(User, Password).                                                            Aridad = 2
                getUserDate(User, UserDate).                                                            Aridad = 2
                usertostring(User, StrOut).                                                             Aridad = 2

Metas primarias:
                usuario
                usertostring

Metas secundarias:
                getusername
                getpassword
                getUserDate
                datetostring
                atomics_to_string
*/

% Constructor
usuario(Username, Password, UserDate, [Username, Password, UserDate]).


% Selectores
getusername([Username,_,_], Username).

getpassword([_, Password,_], Password).

getUserDate([_,_, UserDate], UserDate).

% Otros
usertostring(User, StrOut) :-
            getusername(User, UsernameUser),
            getpassword(User, PasswordUser),
            getUserDate(User, DateUser),
            datetostring(DateUser, FechaStr),
            ListStr = ["Nombre de usuario: " , UsernameUser, "\n", "Contrasenha de usuario: ", PasswordUser, "\n", "Fecha de registro: ", FechaStr, "\n", "-------------", "\n"],
            atomics_to_string(ListStr, StrOut).
            


/*
*******************************************
TDA Documento
*******************************************
El TDA Documento se representa a traves de una lista que almacena el
titulo de un documento (String), su fecha de creacion (tipo fecha),
contenido (string), un valor de identificacion (entero), el duenho del
documento y dos listas para los accesos del documento y su historial
de versiones.

Dominios:       Titulo: String
                FechaDoc: date
                Contenido: String
                Id: Entero
                Owner: String
                Doc: documento
                ListaAccesos: Lista
                ListaVersiones: Lista

Predicados:
                documento(Titulo, FechaDoc, Contenido, Id, Owner, Doc).                                 Aridad = 6
                documento2(Titulo, FechaDoc, Contenido, Id, Owner, ListaAccesos, ListaVersiones, Doc).  Aridad = 8
                gettitulo(Doc, Titulo).                                                                 Aridad = 2
                getfechaDoc(Doc, FechaDoc).                                                             Aridad = 2
                getContenido(Doc, Contenido).                                                           Aridad = 2
                getIdDoc(Doc, IdDoc).                                                                   Aridad = 2
                getOwner(Doc, Owner).                                                                   Aridad = 2
                getAccessList(Doc, AccessList).                                                         Aridad = 2
                getVersionList(Doc, VersionList).                                                       Aridad = 2
                documentotostring(Doc, StrOut).                                                         Aridad = 2

Metas primarias:
                documento
                documento2
                documentotostring

Metas secundarias:
                gettitulo
                getfechaDoc
                getContenido
                getIdDoc
                getOwner
                getAccessList
                getVersionList
                allaccessestostring
                allversionstostring
                atomics_to_string
                datetostring
*/

% Constructor
documento(Titulo, FechaDoc, Contenido, Id, Owner, [Titulo, FechaDoc, Contenido, Id, Owner, [], [[FechaDoc, Contenido, 0]]]).

documento2(Titulo, FechaDoc, Contenido, Id, Owner, ListaAccesos, ListaVersiones, [Titulo, FechaDoc, Contenido, Id, Owner, ListaAccesos, ListaVersiones]).

% Selectores
gettitulo([Titulo, _, _, _, _, _, _], Titulo).

getfechaDoc([_, FechaDoc, _, _, _, _, _], FechaDoc).

getContenido([_, _, Contenido, _, _, _, _], Contenido).

getIdDoc([_, _, _, IdDoc, _, _, _], IdDoc).

getOwner([_, _, _, _, Owner, _, _], Owner).

getAccessList([_, _, _, _, _ , AccessList, _], AccessList).

getVersionList([_, _, _, _, _, _, VersionList], VersionList).

% Listadocs, user, salida
getdocsbyreaders([], _, []).
getdocsbyreaders([FirstDoc|NextDocs], User, [FirstDoc|NewDocs]) :-
            getOwner(FirstDoc, User),
            getdocsbyreaders(NextDocs, User, NewDocs), !.
getdocsbyreaders([FirstDoc|NextDocs], User, [FirstDoc|NewDocs]) :-
            getAccessList(FirstDoc, Accesos),
            checkAccesses(Accesos, User, _),
            getdocsbyreaders(NextDocs, User, NewDocs), !.
getdocsbyreaders([_|NextDocs], User, NewDocs) :-
            getdocsbyreaders(NextDocs, User, NewDocs).


% Otros
documentotostring(Documento, StrOut) :-
            gettitulo(Documento, DocumentoTitulo),
            getfechaDoc(Documento, DocumentoFecha),
            getContenido(Documento, DocumentoContenido),
            getIdDoc(Documento, DocumentoId),
            getOwner(Documento, DocumentoOwner),
            getAccessList(Documento, DocumentoAccesses),
            getVersionList(Documento, DocumentoVersionList),
            allaccessestostring(DocumentoAccesses, DocumentoAccessesStr),
            atomics_to_string(DocumentoAccessesStr, DocumentoAccessesStrStr),
            allversionstostring(DocumentoVersionList, DocumentoVersionStr),
            atomics_to_string(DocumentoVersionStr, DocumentoVersionStrStr),
            datetostring(DocumentoFecha, DocumentoFechaStr),
            ListStr = ["Titulo de documento: ", DocumentoTitulo, "\n", "Fecha de creacion del documento: ", DocumentoFechaStr, "\n", "El contenido del documento es:", DocumentoContenido, "\n", "ID del documento: ", DocumentoId, "\n", "El propietario de este documento es: ", DocumentoOwner, "\n", "En este documento existen los siguientes accesos: ", DocumentoAccessesStrStr, "\n", "Lista de versiones del documento: ", DocumentoVersionStrStr, "\n", "-------------", "\n"],
            atomics_to_string(ListStr, StrOut).


/*
*******************************************
TDA Acceso
*******************************************
El TDA Acceso se representa a través de una lista que almacena el nombre de usuario
al que se le ha otorgado el permiso (string), y un tipo de acceso que alterna entre
R, W, C (String).

Dominios:       NombreUser: String
                TipoAcceso: Lista
                Access: acceso
                ListaDeUsernamesPermitidos: Lista
                UsuariosRegistrados: Lista
                ListaTipoAccesos: Lista
                Letter: String
                User: usuario
                ListaDeAccesosDoc: Lista

Predicados:
                acceso(NombreUser, TipoAcceso, Access).                                                 Aridad = 3
                getaccessUser(Access, NombreUser).                                                      Aridad = 2
                getaccessType(Access, TipoAcceso).                                                      Aridad = 2
                verificadorusers(ListaDeUsernamesPermitidos, UsuariosRegistrados).                      Aridad = 2
                verifyTypeAccess(ListaTipoAccessos, Letter).                                            Aridad = 2
                checkAccesses(ListaDeAccesosDoc, User, Letter).                                         Aridad = 3
                accesotostring(Access, StrOut).                                                         Aridad = 2

Metas primarias:
                acceso
                verificadorusers
                checkAccesses
                accesotostring

Metas secundarias:
                ownmember
                getaccessUser
                getaccessType
                verifyTypeAccess
                atomic_list_concat
                atomics_to_string

*/
% Constructor
acceso(NombreUser, TipoAcceso, [NombreUser, TipoAcceso]).

% Selectores
getaccessUser([NombreUser, _], NombreUser).

getaccessType([_, TipoAcceso], TipoAcceso).

% Otros
verificadorusers([], _) :- !.
verificadorusers([FirstUser|NextUsers], UsuariosRegistrados) :- ownmember(FirstUser, UsuariosRegistrados), 
                                                                verificadorusers(NextUsers, UsuariosRegistrados).

% Dominio: ListaTipoAccesos, Letter
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

accesotostring(Access, StrOut) :-
            getaccessUser(Access, UserAccess),
            getaccessType(Access, ListAccessUser),
            atomic_list_concat(ListAccessUser, ", ", StrListAccessUser),
            ListStr = ["El usuario ", UserAccess, " tiene los permisos de: ", StrListAccessUser],
            atomics_to_string(ListStr, StrOut).

/*
*******************************************
TDA Versión
*******************************************
El TDA Acceso se representa a través de una lista que almacena una fecha (tipo date),
el contenido de un documento (string) y un id (entero)

Dominios:       Fecha: date
                Contenido: String
                Id: Entero
                Ver: version

Predicados:
                version(Fecha, Contenido, Id, Ver).                                                     Aridad = 4
                getfechaVer(Ver, Fecha).                                                                Aridad = 2
                getcontenidoVer(Ver, Contenido).                                                        Aridad = 2
                getIdVer(Ver, ID).                                                                      Aridad = 2
                versiontostring(Ver, StrOut).                                                           Aridad = 2

Metas primarias:
                version
                versiontostring

Metas secundarias:
                getfechaVer
                getcontenidoVer
                getIdVer
                datetostring
                atomics_to_string

*/
version(Fecha, Contenido, Id, [Fecha, Contenido, Id]).

% Selectores

getfechaVer([Fecha, _, _], Fecha).

getcontenidoVer([_, Contenido, _], Contenido).

getIdVer([_, _, ID], ID).

% Otros
versiontostring(Version, StrOut) :-
            getfechaVer(Version, FechaVer),
            getcontenidoVer(Version, ContenidoVer),
            getIdVer(Version, Idver),
            datetostring(FechaVer, FechaStr),
            ListStr = ["\n" ,"Version ", Idver, " generada el dia ", FechaStr, " cuyo contenido es: ", ContenidoVer],
            atomics_to_string(ListStr, StrOut).


/*
*******************************************
Predicados que no corresponden a TDAs
*******************************************
*/

% Implementación propia del predicado nth0
% Dominio: Entero X Lista X Cualquiera
getbyIndex(0, [X], X).
getbyIndex(0, [H|_], H).
getbyIndex(I, [_|T], E) :- NuevoIndex is I-1, getbyIndex(NuevoIndex, T, E), !.


% Implementación propia del predicado member
% Dominio: Cualquiera X Lista
ownmember(L, [L|_]):-!.
ownmember(L, [_|R]):-
            ownmember(L, R).

% Implementación de list-set
% Dominio: Lista X Entero X Cualquiera X Lista
listset([_|T], 0, X, [X|T]).
listset([H|T], I, X, [H|R]) :-
            I > 0, NI is I-1, listset(T, NI, X, R).

% Implementación de eq?
% Dominio: Cualquiera X Cualquiera
equal(N1, N2) :-
            N1 == N2.

% Implementación alternativa de append
% Dominio: Cualquiera X Lista X Lista
append_final(Item, Lista, [Lista|Item]).

/*
*******************************************
Bloque de código principal de paradigmaDocs
*******************************************

Dominios:       Sn1: paradigmaDocs
                Fecha: date
                Username: String
                Password: String
                Contenido: String
                DocumentId: Entero
                ListaPermisos: Lista
                ListaUsernamesPermitidos: Lista
                Date: date
                ContenidoTexto: String
                IdVersion: Entero
         
Predicados:     paradigmaDocsRegister(Sn1, Fecha, Username, Password, Sn2)                              Aridad = 5
                paradigmaDocsLogin(Sn1, Username, Password, Sn2)                                        Aridad = 4
                paradigmaDocsCreate(Sn1, Fecha, Nombre, Contenido, Sn2)                                 Aridad = 5
                paradigmaDocsShare(Sn1, DocumentId, ListaPermisos, ListaUsernamesPermitidos, Sn2)       Aridad = 5
                paradigmaDocsAdd(Sn1, DocumentId, Date, ContenidoTexto, Sn2)                            Aridad = 5
                paradigmaDocsRestoreVersion(Sn1, DocumentId, IdVersion, Sn2)                            Aridad = 4
                paradigmaDocsToString(Sn1, StrOut)                                                      Aridad = 2

Metas primarias:
                paradigmaDocsRegister
                paradigmaDocsLogin
                paradigmaDocsCreate
                paradigmaDocsShare
                paradigmaDocsAdd
                paradigmaDocsRestoreVersion
                paradigmaDocsToString

Metas secundarias:
                getplatformname
                getplatformdate
                getlistausers
                getlistadocs
                getsesionactiva
                usuario
                ownmember
                append
                length
                getuserlogueado
                documento
                getbyIndex
                gettitulo
                getfechaDoc
                getContenido
                getIdDoc
                getOwner
                getAccessList
                getVersionList
                equal
                verificadorusers
                unirlistas
                documento2
                listset
                userloggedexist
                datetostring
                CheckAccesses
                version
                string_concat
                getfechaVer
                getcontenidover
                alluserstostring
                alldocumentstostring
                atomics_to_string
                not
*/

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
            getbyIndex(DocumentId, D, DocumentoMod),
            gettitulo(DocumentoMod, TituloDoc),
            getfechaDoc(DocumentoMod, FechaDocs),
            getContenido(DocumentoMod, ContentDoc),
            getIdDoc(DocumentoMod, IdDocumento),
            getOwner(DocumentoMod, Ownerdoc),
            getAccessList(DocumentoMod, ListadeAccesosDoc),
            getVersionList(DocumentoMod, ListaVerDoc),
            (equal(UserLogged, Ownerdoc) ; checkAccesses(ListadeAccesosDoc, UserLogged, "S")),
            not(ownmember(Ownerdoc, ListaUsernamesPermitidos)),
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
            getbyIndex(DocumentId, D, DocumentoMod),
            gettitulo(DocumentoMod, TituloDoc),
            getfechaDoc(DocumentoMod, FechaDocs),
            getContenido(DocumentoMod, ContentDoc),
            getIdDoc(DocumentoMod, IdDocumento),
            getOwner(DocumentoMod, Ownerdoc),
            getAccessList(DocumentoMod, ListadeAccesosDoc),
            getVersionList(DocumentoMod, ListaVerDoc),
            (checkAccesses(ListadeAccesosDoc, UserLogged, "W") ; equal(UserLogged, Ownerdoc)),
            string_concat(ContentDoc, ContenidoTexto, NuevoContent),
            length(ListaVerDoc, LargoListaVer),
            version(Date, NuevoContent, LargoListaVer, NuevaVersion),
            append(ListaVerDoc, [NuevaVersion], NuevaListaVer),
            documento2(TituloDoc, FechaDocs, NuevoContent, IdDocumento, Ownerdoc, ListadeAccesosDoc, NuevaListaVer, NuevoDocsVer),
            listset(D, DocumentId, NuevoDocsVer, NuevalistaDocs),
            Sn2 = [N, F, U, NuevalistaDocs, []].

% Predicado paradigmaDocsRestoreVersion
paradigmaDocsRestoreVersion(Sn1, DocumentId, IdVersion, Sn2) :-
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            getuserlogueado(S, UserLogged),
            equal(UserLogged, Ownerdoc),
            getbyIndex(DocumentId, D, DocumentoMod),
            gettitulo(DocumentoMod, TituloDoc),
            getfechaDoc(DocumentoMod, FechaDocs),
            getIdDoc(DocumentoMod, IdDocumento),
            getOwner(DocumentoMod, Ownerdoc),
            getAccessList(DocumentoMod, ListadeAccesosDoc),
            getVersionList(DocumentoMod, ListaVerDoc),
            getbyIndex(IdVersion, ListaVerDoc, VersionRestaurar),
            getfechaVer(VersionRestaurar, FechaVerRest),
            getcontenidoVer(VersionRestaurar, ContenidoVerRest),
            length(ListaVerDoc, LargoListaVer),
            version(FechaVerRest, ContenidoVerRest, LargoListaVer, VersionRestaurada),
            append(ListaVerDoc, [VersionRestaurada], NuevaListaVerRest),
            documento2(TituloDoc, FechaDocs, ContenidoVerRest, IdDocumento, Ownerdoc, ListadeAccesosDoc, NuevaListaVerRest, NuevoDocsVerRestored),
            listset(D, DocumentId, NuevoDocsVerRestored, NuevalistaDocs),
            Sn2 = [N, F, U, NuevalistaDocs, []].



/*
paradigmaDocsToString(Sn1, StrOut) :-
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            userloggedexists(S),
            getuserlogueado(S, UserLogged),
            datetostring(F, FStr),
         */   



paradigmaDocsToString(Sn1, StrOut) :-
            getsesionactiva(Sn1, S),
            not(userloggedexists(S)),
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            alldocumentstostring(D, DStr),
            atomics_to_string(DStr, DStrStr),
            alluserstostring(U, UStr),
            atomics_to_string(UStr, UStrStr),
            datetostring(F, FStr),
            ListStr = ["Nombre de plataforma: ", N, "\n", "La fecha de creacion de la plataforma corresponde a: ", FStr, "\n", "Los usuarios registrados en esta plaforma corresponden a: ", "\n", UStrStr, "\n", "En esta plataforma estan creados los siguientes documentos:", "\n", DStrStr, "\n"],
            atomics_to_string(ListStr, StrOut).

% ---- FIN DEL CÓDIGO PRINCIPAL ----

/*
*******************************************
Ejemplos
*******************************************
*/


% --- Ejemplos de paradigmaDocsRegister ---
% Se registran cuatro usuarios
ejemploRegister1(PD5) :-
            date(10, 12, 2015, D1), 
            date(11, 12, 2021, D2), 
            date(13, 12, 2021, D3),
            date(13, 12, 2021, D4),
            paradigmaDocs("google docs", D1, PD1), 
            paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2), 
            paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3), 
            paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4),
            paradigmaDocsRegister(PD4, D4, "fco", "salfate", PD5).
% Se registran cuatro usuarios, pero se intenta registrar un usuario con un nombre ya utilizado, por lo tanto se retorna false
ejemploRegister2(PD5) :-
            date(10, 12, 2015, D1), 
            date(11, 12, 2021, D2), 
            date(13, 12, 2021, D3),
            date(13, 12, 2021, D4),
            paradigmaDocs("google docs", D1, PD1), 
            paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2), 
            paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3), 
            paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4),
            paradigmaDocsRegister(PD4, D4, "alopez", "salfate", PD5).
%---------------------------------------------------------------------------

% --- Ejemplos de paradigmaDocsCreate ---
% Se crean 5 documentos
ejemploCreate1(PD15) :-
            date(10, 12, 2015, D1), 
            date(11, 12, 2021, D2), 
            date(13, 12, 2021, D3),
            date(13, 12, 2021, D4),
            date(15, 12, 2021, D5),
            date(20, 12, 2021, D6),
            date(21, 12, 2021, D7),
            paradigmaDocs("google docs", D1, PD1), 
            paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2), 
            paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3), 
            paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4),
            paradigmaDocsRegister(PD4, D4, "fco", "salfate", PD5),
            paradigmaDocsLogin(PD5, "vflores", "hola123", PD6),
            paradigmaDocsCreate(PD6, D5, "doc1", "contenido doc1", PD7),
            paradigmaDocsLogin(PD7, "vflores", "hola123", PD8),
            paradigmaDocsCreate(PD8, D5, "doc2", "contenido doc2", PD9),
            paradigmaDocsLogin(PD9, "crios", "qwert", PD10),
            paradigmaDocsCreate(PD10, D6, "doc3", "contenido doc3", PD11),
            paradigmaDocsLogin(PD11, "alopez", "asdfg", PD12),
            paradigmaDocsCreate(PD12, D6, "doc4", "contenido doc4", PD13),
            paradigmaDocsLogin(PD13, "fco", "salfate", PD14),
            paradigmaDocsCreate(PD14, D7, "doc5", "contenido doc5", PD15).
% Se intenta crear un documento pero falla la autenticación de login, por lo tanto se retorna false
ejemploCreate2(PD7) :-
            date(10, 12, 2015, D1), 
            date(11, 12, 2021, D2), 
            date(13, 12, 2021, D3),
            date(13, 12, 2021, D4),
            date(15, 12, 2021, D5),
            paradigmaDocs("google docs", D1, PD1), 
            paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2), 
            paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3), 
            paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4),
            paradigmaDocsRegister(PD4, D4, "fco", "salfate", PD5),
            paradigmaDocsLogin(PD5, "vflores", "asdfg", PD6),
            paradigmaDocsCreate(PD6, D5, "doc1", "contenido doc1", PD7).
            
%---------------------------------------------------------------------------
% Ejemplos paradigmaDocsShare paradigmaDocsShare(Sn1, DocumentId, ListaPermisos, ListaUsernamesPermitidos, Sn2)
ejemploShare1(PD19) :-
            date(10, 12, 2015, D1), 
            date(11, 12, 2021, D2), 
            date(13, 12, 2021, D3),
            date(13, 12, 2021, D4),
            date(15, 12, 2021, D5),
            date(20, 12, 2021, D6),
            date(21, 12, 2021, D7),
            paradigmaDocs("google docs", D1, PD1), 
            paradigmaDocsRegister(PD1, D2, "vflores", "hola123", PD2), 
            paradigmaDocsRegister(PD2, D2, "crios", "qwert", PD3), 
            paradigmaDocsRegister(PD3, D3, "alopez", "asdfg", PD4),
            paradigmaDocsRegister(PD4, D4, "fco", "salfate", PD5),
            paradigmaDocsLogin(PD5, "vflores", "hola123", PD6),
            paradigmaDocsCreate(PD6, D5, "doc1", "contenido doc1", PD7),
            paradigmaDocsLogin(PD7, "vflores", "hola123", PD8),
            paradigmaDocsCreate(PD8, D5, "doc2", "contenido doc2", PD9),
            paradigmaDocsLogin(PD9, "crios", "qwert", PD10),
            paradigmaDocsCreate(PD10, D6, "doc3", "contenido doc3", PD11),
            paradigmaDocsLogin(PD11, "alopez", "asdfg", PD12),
            paradigmaDocsCreate(PD12, D6, "doc4", "contenido doc4", PD13),
            paradigmaDocsLogin(PD13, "fco", "salfate", PD14),
            paradigmaDocsCreate(PD14, D7, "doc5", "contenido doc5", PD15),
            paradigmaDocsLogin(PD15, "vflores", "hola123", PD16),
            paradigmaDocsShare(PD16, 0, ["R"], ["crios"], PD17),
            paradigmaDocsLogin(PD17, "crios", "qwert", PD18),
            paradigmaDocsShare(PD18, 2, ["R", "C"], ["fco", "alopez"], PD19).
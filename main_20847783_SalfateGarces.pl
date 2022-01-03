/*
*******************************************
TDA date
*******************************************
El TDA date se representa a traves de una lista que almacena un dia
de tipo entero, un mes de tipo entero, y un anho de tipo entero.

Dominios:       
                Dia: Entero      
                Mes: Entero
                Year: Entero
                Fecha: date
                StrOut: String

Predicados:
                date(Dia,Mes,Year, Fecha).                                                              Aridad = 4
                getdia(Fecha, Dia).                                                                     Aridad = 2
                getmes(Fecha, Mes).                                                                     Aridad = 2
                datetostring(Fecha, StrOut).                                                            Aridad = 2

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

% Clausulas:
% Reglas:

% Descripción: Constructor del TDA Fecha
% Dominio: Entero X Entero X Entero X Fecha
date(Dia,Mes,Year, [Dia,Mes,Year]):-
            number(Dia),number(Mes),number(Year),
            Mes > 0, (Mes < 12; Mes = 12).

% Descripción: Selector de día del TDA date
% Dominio: Fecha X Entero
getdia([Dia, _, _], Dia).

% Descripción: Selector de mes del TDA date
% Dominio: Fecha X Entero
getmes([_, Mes, _], Mes).

% Descripción: Selector de año del TDA date
% Dominio: 
getanho([_, _, Year], Year).

% Descripción: Predicado que convierte una fecha en un string
% Dominio: Fecha X String
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

Dominios:       
                Name: String
                Date: fecha
                PD: paradigmaDocs
                Listausers: List
                Listadocs: List
                SesionActiva: List
                UsernamesList: List
                ListadePermisos: List
                ListaDeAccesos: List
                Listausersregistrados: List
                ListStrUsers: List
                ListStrDocs: List
                ListVersions: List
                ListStrversion: List
                ListStrAccesses: List
                ListaWithUser: List
                Username: String
                ListaUserEncontrado: List
                EstadoSesion: List
                LargoSesion: Entero


Predicados:
                paradigmaDocs(Name, Date, PD).                                                          Aridad = 3
                getplatformname(PD, Name).                                                              Aridad = 2
                getplatformdate(PD, Date).                                                              Aridad = 2
                getlistausers(PD, Listausers).                                                          Aridad = 2
                getlistadocs(PD, Listadocs).                                                            Aridad = 2
                getsesionactiva(PD, SesionActiva).                                                      Aridad = 2
                getuserlogueado(SesionActiva).                                                          Aridad = 1
                obtenerusuario(Username, Listausers, ListaWithUser).                                    Aridad = 3
                getusuarioencontrado(ListaUserEncontrado, Usuario).                                     Aridad = 2
                getallusernames(Listausers, UsernamesList).                                             Aridad = 2
                crearaccesos(ListadePermisos, ListaUsers, ListaDeAccesos).                              Aridad = 3
                verificadorusers(Listausers, Listausersregistrados).                                    Aridad = 2
                alluserstostring(ListaUsers, ListStrUsers).                                             Aridad = 2
                allaccessestostring(ListaDeAccesos, ListStrAccesses).                                   Aridad = 2
                allversionstostring(ListVersions, ListStrVersion).                                      Aridad = 2
                alldocumentstostring(Listadocs, ListStrDocs).                                           Aridad = 2
                userloggedexists(SesionActiva).                                                         Aridad = 1
                largoestadosesion(EstadoSesion, LargoSesion).                                           Aridad = 2

Metas primarias:
                getplatformname
                getplatformdate
                getlistausers
                getlistadocs
                getsesionactiva
                getuserlogueado
                paradigmaDocs
                user_registered
                userautenticado
                agregaruser
                largolistadocs
                agregardocumento
                seleccionardocumento
                actualizardocumento
                getallusernames
                crearaccesos
                alluserstostring
                crearstring_users
                allaccessestostring
                allversionstostring
                alldocumentstostring
                crearstring_docs
                crearstring_paradigmadocs
                userloggedexists
                obtenerusuario
                getusuarioencontrado
                largoestadosesion

Metas secundarias:
                listset
                getbyIndex
                ownmember
                atomics_to_string
                length
                append
                
*/

% Clausulas:
% Reglas:

% Descripción: Predicado Constructor del TDA paradigmaDocs
% Dominio: String X Date X paradigmaDocs
paradigmaDocs(Name, Date, [Name, Date, [], [], []]).

% Descripción: Predicado selector del nombre de la platforma paradigmaDocs
% Dominio: paradigmaDocs X String
getplatformname([Name,_,_,_,_], Name).

% Descripción: Predicado selector de la fecha de creación de la plataforma  paradigmaDocs
% Dominio: paradigmaDocs X Date
getplatformdate([_,Date,_,_,_], Date).

% Descripción: Predicado selector de la lista de usuarios de la plataforma  paradigmaDocs
% Dominio: paradigmaDocs X List
getlistausers([_,_,Listausers,_,_], Listausers).

% Descripción: Predicado selector de la lista de documentos de la plataforma paradigmaDocs 
% Dominio: paradigmaDocs X List
getlistadocs([_,_,_,Listadocs,_], Listadocs).

% Descripción: Predicado selector del estado de sesión de la plataforma paradigmaDocs
% Dominio: paradigmaDocs X List
getsesionactiva([_,_,_,_,SesionActiva], SesionActiva).

% Descripción: Predicado que obtiene el nombre de usuario de la sesión activa
% Dominio: List X String
getuserlogueado([S], S).

% Descripción: Predicado que agrega un nuevo usuario a la lista de usuarios de la plataforma paradigmaDocs
% Dominio: String X List
user_registered(Username, UsernameList) :-
            ownmember(Username, UsernameList).

% Descripción: Predicado que autentica si un usuario existe o si su contraseña es correcta 
% Dominio: user X List
autenticarusuario(Usuario, ListaUsers) :-
            ownmember(Usuario, ListaUsers).

% Descripción: Al autenticarse un usuario con el predicado autenticarusuario/2, este predicado lo agrega al estado de sesión
% Dominio: List X String X List
userautenticado(EstadoSesion, Username, SesionLogueada) :-
            append(EstadoSesion, [Username], SesionLogueada).

% Descripción: Predicado que agrega un nuevo usuario a la plataforma paradigmaDocs
% Dominio: List X usuario X List
agregaruser(ListaUsers, NuevoUser, NuevaListaUsers) :-
            append(ListaUsers, [NuevoUser], NuevaListaUsers).

largoestadosesion(EstadoSesion, LargoSesion) :-
            length(EstadoSesion, LargoSesion).

% Descripción: Predicado que consigue el largo de la lista de documentos de la plataforma paradigmaDocs
% Dominio: List X Entero
largolistadocs(ListaDocumentos, LargoDocs) :-
            length(ListaDocumentos, LargoDocs).

% Descripción: Agrega un nuevo documento a la plataforma paradigmaDocs 
% Dominio: List X documento X List
agregardocumento(ListaDocs, NuevoDocumento, NuevaListaDocs) :-
            append(ListaDocs, [NuevoDocumento], NuevaListaDocs).

% Descripción: Predicado que consigue un documento de la platforma a partir de su ID 
% Dominio: Entero X List X documento
seleccionardocumento(DocumentId, ListaDocs, Documento) :-
            getbyIndex(DocumentId, ListaDocs, Documento).

% Descripción: Predicado que sobreescribe un documento en la lista de documentos en la plataforma paradigmaDocs
% Dominio: List X Entero X documento X List
actualizardocumento(ListaDocs, DocumentId, DocModded, NuevalistaDocs) :-
            listset(ListaDocs, DocumentId, DocModded, NuevalistaDocs).

% Descripción: Predicado que obtiene una lista que contiene a un usuario especificado.
% Dominio: String X List X List
obtenerusuario(_, [], []) :- !.
obtenerusuario(Username, [User|NextUsers], [User|UserOut]) :-
            ownmember(Username, User),
            obtenerusuario(Username, NextUsers, UserOut), !.
obtenerusuario(Username, [_|NextUsers], UserOut) :-
            obtenerusuario(Username, NextUsers, UserOut).

% Descripción: Predicado que consigue al usuario filtrado en obtenerusuario/3
% Dominio: List X usuario
getusuarioencontrado(ListaUserEncontrado, Usuario) :-
            getbyIndex(0, ListaUserEncontrado, Usuario).

% Descripción: Predicado que consigue todos los nombres de usuario de la lista de usuarios de la plataforma paradigmaDocs
% Dominio: List X List
getallusernames(ListaUsers, UsernamesList) :- maplist(getbyIndex(0), ListaUsers, UsernamesList), !.

% Descripción: Predicado que crea los accesos a partir de una lista de usuarios con una lista de accesos
% Dominio: List X List X List
crearaccesos(ListadePermisos, ListaUsers, ListaDeAccesos) :- maplist(append_final([ListadePermisos]), ListaUsers, ListaDeAccesos).

% Descripción: Predicado que transforma toda la lista de accesos de la plataforma paradigmaDocs en una lista de strings
% Dominio: List X List
alluserstostring(ListUsers, ListStrUsers) :- maplist(usertostring(), ListUsers, ListStrUsers).

% Descripción: Predicado que transforma la lista de strings generada a partir del predicado allusertostring/2 en un solo string 
% Dominio: List X String
crearstring_users(ListaUserString, StrUsers) :-
            atomics_to_string(ListaUserString, StrUsers).

% Descripción: Predicado que transforma la lista de accesos de un documento en una lista de strings
% Dominio: List X List
allaccessestostring(ListAccesses, ListStrAccesses) :- maplist(accesotostring(), ListAccesses, ListStrAccesses).

% Descripción: Predicado que transforma la lista de versiones de un documento en una lista de strings
% Dominio: List X List
allversionstostring(ListVersions, ListStrVersion) :- maplist(versiontostring(), ListVersions, ListStrVersion).

% Descripción: Predicado que transforma la lista de documentos de la plataforma paradigmaDocs en una lista de strings
% Dominio: List X List
alldocumentstostring(ListDocs, ListStrDocs) :- maplist(documentotostring(), ListDocs, ListStrDocs).

% Descripción: Predicado que transforma la lista de strings generada a partir del predicado alldocumentstostring/2 en un solo string
% Dominio: List X String
crearstring_docs(ListaDocsString, StrDocs) :-
            atomics_to_string(ListaDocsString, StrDocs).

% Descripción: Predicado que transforma la lista de strings generada a partir del predicado paradigmaDocsToString/2 en un solo string
% Dominio: List X String
crearstring_paradigmadocs(ListParadigmaDocs, StrParadigmaDocs) :-
            atomics_to_string(ListParadigmaDocs, StrParadigmaDocs).

% Descripción: Predicado que verifica que exista un usuario loggeado en el estado de sesión de la plataforma paradigmaDocs
% Dominio: List
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

Dominios:       
                Username: String
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

% Clausulas:
% Reglas:

% Descripción: Predicado constructor del TDA usuario
% Dominio: String X String X date X usuario
usuario(Username, Password, UserDate, [Username, Password, UserDate]).


% Descripción: Predicado selector del nombre de usuario del TDA usuario
% Dominio: usuario X String
getusername([Username,_,_], Username).

% Descripción: Predicado selector de la contraseña de un usuario del TDA usuario
% Dominio: usuario X String
getpassword([_, Password,_], Password).

% Descripción: Predicado selector de la fecha de registro de un usuario del TDA usuario 
% Dominio: usuario X date
getUserDate([_,_, UserDate], UserDate).

% Descripción: Predicado que transforma toda la información de un usuario en un string
% Dominio: usuario X String
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

Dominios:       
                Titulo: String
                FechaDoc: date
                Contenido: String
                Id: Entero
                Owner: String
                Doc: documento
                ListaAccesos: List
                ListaVersiones: List
                StrOut: String
                Listadoc: List
                Username: String
                ListaDocsFiltrada: List
                LargoListaVer: Entero
                UserLogged: String
                OwnerDoc: String
                ContentDoc: String
                ContenidoTexto: String
                NuevoContent: String
                ListaDeAccesos: List
                ListaDeAccesosDoc: List
                NuevaListaAccess: List
                IdVersion: Entero
                NuevaVersion: version
                Version: version
                ListaVerDoc: List
                NuevaListaVer: List
                Documento: doc

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
                getdocsbyaccess(ListaDocs, Username, ListaDocsFiltrada).                                Aridad = 3
                largolistaversiones(ListaVersiones, LargoListaVer).                                     Aridad = 2
                verificarowner(UserLogged, OwnerDoc).                                                   Aridad = 2
                agregarcontenido(ContentDoc, ContenidoTexto, NuevoContent).                             Aridad = 3
                agregaraccesos(ListaDeAccesos, ListadeAccesosDoc, NuevaListaAccess).                    Aridad = 3
                seleccionarversion(IdVersion, ListaVersiones, Version).                                 Aridad = 3
                agregarnuevaversion(ListaVerDoc, NuevaVersion, NuevaListaVer).                          Aridad = 3
                documentotostring(Documento, StrOut)                                                    Aridad = 2

Metas primarias:
                documento
                documento2
                getdocsbyaccess
                largolistaversiones
                verificarowner
                agregarcontenido
                agregaraccesos
                seleccionarversion
                agregarnuevaversion
                documentotostring

Metas secundarias:
                gettitulo
                getfechadoc
                getContenido
                getIdDoc
                getOwner
                getAccessList
                getVersionList
                checkAccesses
                length
                string_concat
                append
                getbyIndex
                atomics_to_string
                datetostring
                allversionstostring
                allaccessestostring
*/

% Clausulas:
% Reglas:

% Descripción: Predicado constructor del TDA documento
% Dominio: String X date X String X Entero X String X documento
documento(Titulo, FechaDoc, Contenido, Id, Owner, [Titulo, FechaDoc, Contenido, Id, Owner, [], [[FechaDoc, Contenido, 0]]]).

% Descripción: Otro predicado constructor del TDA documento
% Dominio: String X date X String X Entero X String X List X List X documento
documento2(Titulo, FechaDoc, Contenido, Id, Owner, ListaAccesos, ListaVersiones, [Titulo, FechaDoc, Contenido, Id, Owner, ListaAccesos, ListaVersiones]).

% Descripción: Predicado selector del título del TDA documento
% Dominio: documento X String
gettitulo([Titulo, _, _, _, _, _, _], Titulo).

% Descripción: Predicado selector de la fecha de creación del TDA documento
% Dominio: documento X date
getfechaDoc([_, FechaDoc, _, _, _, _, _], FechaDoc).

% Descripción: Predicado selector del contenido del TDA documento
% Dominio: documento X String
getContenido([_, _, Contenido, _, _, _, _], Contenido).

% Descripción: Predicado selector del ID del TDA documento 
% Dominio: documento X Entero
getIdDoc([_, _, _, IdDoc, _, _, _], IdDoc).

% Descripción: Predicado selector del owner del TDA documento 
% Dominio: documento X String
getOwner([_, _, _, _, Owner, _, _], Owner).

% Descripción: Predicado selector de la lista de accesos del TDA documento
% Dominio: documento X List
getAccessList([_, _, _, _, _ , AccessList, _], AccessList).

% Descripción: Predicado selector de la lista de versiones del TDA documento 
% Dominio: documento X List
getVersionList([_, _, _, _, _, _, VersionList], VersionList).


% Descripción: Predicado que obtiene almacena todos los documentos donde un usuario tenga cualquier tipo de permisos en una lista 
% Dominio: List X String X List
getdocsbyaccess([], _, []).
getdocsbyaccess([FirstDoc|NextDocs], User, [FirstDoc|NewDocs]) :-
            getOwner(FirstDoc, User),
            getdocsbyaccess(NextDocs, User, NewDocs), !.
getdocsbyaccess([FirstDoc|NextDocs], User, [FirstDoc|NewDocs]) :-
            getAccessList(FirstDoc, Accesos),
            checkAccesses(Accesos, User, _),
            getdocsbyaccess(NextDocs, User, NewDocs), !.
getdocsbyaccess([_|NextDocs], User, NewDocs) :-
            getdocsbyaccess(NextDocs, User, NewDocs).


% Descripción: Predicado que consigue el largo de la lista de versiones de un documento en la plataforma paradigmaDocs
% Dominio: List X Entero
largolistaversiones(ListaVersiones, LargoListaVer) :-
            length(ListaVersiones, LargoListaVer).

% Descripción: Predicado que verifica que el owner de un documento sea igual que el usuario cuya sesión esté activa
% Dominio: String X String
verificarowner(UserLogged, OwnerDoc) :-
            UserLogged = OwnerDoc.

% Descripción: Predicado que agrega nuevo contenido al actual contenido de un documento
% Dominio: String X String X String
agregarcontenido(ContentDoc, ContenidoTexto, NuevoContent) :-
            string_concat(ContentDoc, ContenidoTexto, NuevoContent).

% Descripción: Predicado que agrega una lista de nuevos accesos a un documento
% Dominio: List X List X List
agregaraccesos(ListaDeAccesos, ListadeAccesosDoc, NuevaListaAccess) :-
            append(ListaDeAccesos, ListadeAccesosDoc, NuevaListaAccess).

% Descripción: Predicado que consigue una versión de un documento a través de un ID de versión 
% Dominio: Entero X List X version
seleccionarversion(IdVersion, ListaVersiones, Version) :-
            getbyIndex(IdVersion, ListaVersiones, Version).

% Descripción: Predicado que agrega una nueva versión a la lista de versiones de un documento 
% Dominio: List X version X List
agregarnuevaversion(ListaVerDoc, NuevaVersion, NuevaListaVer) :-
            append(ListaVerDoc, [NuevaVersion], NuevaListaVer).

% Descripción: Predicado que convierte toda la información de un documento en un string 
% Dominio: documento X String
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
            ListStr = ["Titulo de documento: ", DocumentoTitulo, "\n", "Fecha de creacion del documento: ", DocumentoFechaStr, "\n", "El contenido del documento es: ", DocumentoContenido, "\n", "ID del documento: ", DocumentoId, "\n", "El propietario de este documento es: ", DocumentoOwner, "\n", "En este documento existen los siguientes accesos: ", DocumentoAccessesStrStr, "\n", "Lista de versiones del documento: ", "\n", DocumentoVersionStrStr, "\n", "-------------", "\n"],
            atomics_to_string(ListStr, StrOut).


/*
*******************************************
TDA Acceso
*******************************************
El TDA Acceso se representa a través de una lista que almacena el nombre de usuario
al que se le ha otorgado el permiso (string), y un tipo de acceso que alterna entre
R, W, C y S (String).

Dominios:       
                NombreUser: String
                TipoAcceso: Lista
                Access: acceso
                ListaDeUsernamesPermitidos: Lista
                UsuariosRegistrados: Lista
                ListaTipoAccesos: Lista
                Letter: String
                User: usuario
                ListaDeAccesosDoc: Lista
                StrOut: String

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

% Clausulas:
% Reglas:

% Descripción: Predicado constructor del TDA acceso
% Dominio: String X List X acceso
acceso(NombreUser, TipoAcceso, [NombreUser, TipoAcceso]).

% Descripción: Predicado selector del nombre de usuario del TDA acceso
% Dominio: acceso X String
getaccessUser([NombreUser, _], NombreUser).

% Descripción: Predicado selector de los tipos de accesos del TDA acceso
% Dominio: acceso X LIst
getaccessType([_, TipoAcceso], TipoAcceso).

% Descripción: Predicado que verifica que la lista de usuarios utilizada en el predicado paradigmaDocsShare/5 contenga solamente usuarios registrados
% Dominio: List X List
verificadorusers([], _) :- !.
verificadorusers([FirstUser|NextUsers], UsuariosRegistrados) :- ownmember(FirstUser, UsuariosRegistrados), 
                                                                verificadorusers(NextUsers, UsuariosRegistrados).
% Descripción: Predicado que verifica si el dueño de un documento se encuentra en a lista de usuarios utilizada en el predicado paradigmaDocsShare/5
% Dominio: String X List
checkifowneraccess(OwnerDoc, ListaUsernamesPermitidos) :-
            ownmember(OwnerDoc, ListaUsernamesPermitidos).

% Descripción: Predicado que verifica si existe un permiso especifico en un acceso
% Dominio: List X String
verifyTypeAccess([], _) :- !, fail.
verifyTypeAccess([H|_], H).
verifyTypeAccess([_|T], AccessType) :- verifyTypeAccess(T, AccessType).

% Descripción: Predicado que verifica si un usuario en especifico posee cierto permiso de acceso
% Dominio: List X String X String
checkAccesses([], _, _) :- !, fail.
checkAccesses([FirstAccess|_], User, Letter) :- 
            getaccessUser(FirstAccess, User), 
            getaccessType(FirstAccess, Accesses),
            verifyTypeAccess(Accesses, Letter), !.
checkAccesses([_|NextAccess], User, Letter) :-
            checkAccesses(NextAccess, User, Letter).

% Descripción: Predicado que transforma un acceso de un documento en un string
% Dominio: acceso X String
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

Dominios:       
                Fecha: date
                Contenido: String
                Id: Entero
                Ver: version
                StrOut: String

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

% Clausulas:
% Reglas:

% Descripción: Predicado constructor del TDA version
% Dominio: date X String X Entero X version
version(Fecha, Contenido, Id, [Fecha, Contenido, Id]).

% Descripción: Predicado selector de la fecha de creación del TDA version
% Dominio: version X date
getfechaVer([Fecha, _, _], Fecha).

% Descripción: Predicado selector del contenido del TDA version
% Dominio: version X String
getcontenidoVer([_, Contenido, _], Contenido).

% Descripción: Predicado selector del ID del TDA version 
% Dominio: version X Entero
getIdVer([_, _, ID], ID).

% Descripción: Predicado que transforma una versión de un documento en un string
% Dominio: version X String
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

% Clausulas:
% Reglas:

% Descripción: Implementación propia del predicado nth0
% Dominio: Entero X Lista X Cualquiera
getbyIndex(0, [X], X).
getbyIndex(0, [H|_], H).
getbyIndex(I, [_|T], E) :- NuevoIndex is I-1, getbyIndex(NuevoIndex, T, E), !.


% Descripción: Implementación propia del predicado member
% Dominio: Cualquiera X Lista
ownmember(L, [L|_]):-!.
ownmember(L, [_|R]):-
            ownmember(L, R).

% Descripción: Implementación de list-set
% Dominio: Lista X Entero X Cualquiera X Lista
listset([_|T], 0, X, [X|T]).
listset([H|T], I, X, [H|R]) :-
            I > 0, NI is I-1, listset(T, NI, X, R).

% Descripción: Implementación alternativa de append
% Dominio: Cualquiera X Lista X Lista
append_final(Item, Lista, [Lista|Item]).

/*
*******************************************
Bloque de código principal de paradigmaDocs
*******************************************

Dominios:       
                Sn1: paradigmaDocs
                Fecha: date
                Username: String
                Password: String
                Sn2: paradigmaDocs
                Nombre: String
                Contenido: String
                DocumentId: Entero
                ListaPermisos: List
                ListaUsernamesPermitidos: List
                Date: date
                ContenidoTexto: String
                idVersion: Entero
                StrOut: String
         
Predicados:     
                paradigmaDocsRegister(Sn1, Fecha, Username, Password, Sn2)                              Aridad = 5
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
                getallusernames
                user_registered
                agregaruser
                autenticarusuarios
                userautenticado
                largolistadocs
                getuserlogueado
                documento
                agregardocumento
                seleccionardocumento
                gettitulo
                getfechaDoc
                getContenido
                getIdDoc
                getOwner
                getAccessList
                getVersionList
                verificarowner
                checkAccesses
                checkifowneraccess
                verificadorusers
                crearaccesos
                agregaraccesos
                documento2
                actualizardocumento
                largolistaversiones
                version
                agregarnuevaversion
                seleccionarversion
                getfechaVer
                getcontenidoVer
                userloggedexists
                datetostring
                getdocsbyaccess
                alldocumentstostring
                crearstring_docs
                alluserstostring
                crearstring_users
                crearstring_paradigmadocs
                obtenerusuario
                getusuarioencontrado
                
*/

% Clausulas:
% Reglas:

% Descripción: Predicado que registra a un nuevo usuario a la plataforma paradigmaDocs, verificando también si es que se trata de un usuario repetido
% Dominio: paradigmaDocs X date X String X String X paradigmaDocs
paradigmaDocsRegister(Sn1, Fecha, Username, Password, Sn2) :-
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            usuario(Username, Password, Fecha, NuevoUsuario),
            getallusernames(U, UsernamesList),
            not(user_registered(Username, UsernamesList)),
            agregaruser(U, NuevoUsuario, NuevaLista),
            Sn2 = [N, F, NuevaLista, D, S], !.

% Descripción: Predicado que inicia la sesión de un usuario, se verifica que el nombre de usuario coincida con la contraseña entregada
% Dominio: paradigmaDocs X String X String x paradigmaDocs
paradigmaDocsLogin(Sn1, Username, Password, Sn2) :-
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            autenticarusuario([Username, Password, _], U),
            userautenticado(S, Username, SesionLogueada),
            largoestadosesion(SesionLogueada, LargoSesion),
            LargoSesion =< 1,
            Sn2 = [N, F, U, D, SesionLogueada], !.

% Descripción: Predicado que crea nuevos documentos en la plataforma paradigmaDocs
% Dominio: paradigmaDocs X date X String X String X paradigmaDocs           
paradigmaDocsCreate(Sn1, Fecha, Nombre, Contenido, Sn2) :-
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            largolistadocs(D, LargoDocs),
            getuserlogueado(S, UserLogueado),
            documento(Nombre, Fecha, Contenido, LargoDocs, UserLogueado, NuevoDoc),
            agregardocumento(D, NuevoDoc, NuevaListaDocs),
            Sn2 = [N, F, U, NuevaListaDocs, []].


% Descripción: Predicado que permite conceder permisos especiales a otros usuarios sobre un documento
%              Se debe tener en cuenta que los permisos para conceder corresponden a cuatro:
%              Lectura (R), Escritura (W), Comentar (C), Compartir (S)

% Dominio: paradigmaDocs X Entero X List X List X paradigmaDocs
paradigmaDocsShare(Sn1, DocumentId, ListaPermisos, ListaUsernamesPermitidos, Sn2) :-
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            getuserlogueado(S, UserLogged),
            getallusernames(U, ListadeUsernames),
            seleccionardocumento(DocumentId, D, DocumentoMod),
            gettitulo(DocumentoMod, TituloDoc),
            getfechaDoc(DocumentoMod, FechaDocs),
            getContenido(DocumentoMod, ContentDoc),
            getIdDoc(DocumentoMod, IdDocumento),
            getOwner(DocumentoMod, Ownerdoc),
            getAccessList(DocumentoMod, ListadeAccesosDoc),
            getVersionList(DocumentoMod, ListaVerDoc),
            (verificarowner(UserLogged, Ownerdoc) ; checkAccesses(ListadeAccesosDoc, UserLogged, "S")),
            not(checkifowneraccess(Ownerdoc, ListaUsernamesPermitidos)),
            verificadorusers(ListaUsernamesPermitidos, ListadeUsernames),
            crearaccesos(ListaPermisos, ListaUsernamesPermitidos, ListaDeAccesos),
            agregaraccesos(ListaDeAccesos, ListadeAccesosDoc, NuevaListaAccess),
            documento2(TituloDoc, FechaDocs, ContentDoc, IdDocumento, Ownerdoc, NuevaListaAccess, ListaVerDoc, NuevoDocAccess),
            actualizardocumento(D, DocumentId, NuevoDocAccess, NuevalistaDocs),
            Sn2 = [N, F, U, NuevalistaDocs, []].


% Descripción: Predicado que agrega más contenido al contenido de un documento, se verifica que el usuario logueado sea el propietario
%              del documento o que tenga accesos de escritura en él. Como efecto de este predicado, también se crean versiones
%              del documento.

% Dominio: paradigmaDocs X Entero X date X String X paradigmaDocs
paradigmaDocsAdd(Sn1, DocumentId, Date, ContenidoTexto, Sn2) :-
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            getuserlogueado(S, UserLogged),
            seleccionardocumento(DocumentId, D, DocumentoMod),
            gettitulo(DocumentoMod, TituloDoc),
            getfechaDoc(DocumentoMod, FechaDocs),
            getContenido(DocumentoMod, ContentDoc),
            getIdDoc(DocumentoMod, IdDocumento),
            getOwner(DocumentoMod, Ownerdoc),
            getAccessList(DocumentoMod, ListadeAccesosDoc),
            getVersionList(DocumentoMod, ListaVerDoc),
            (checkAccesses(ListadeAccesosDoc, UserLogged, "W") ; verificarowner(UserLogged, Ownerdoc)),
            agregarcontenido(ContentDoc, ContenidoTexto, NuevoContent),
            largolistaversiones(ListaVerDoc, LargoListaVer),
            version(Date, NuevoContent, LargoListaVer, NuevaVersion),
            agregarnuevaversion(ListaVerDoc, NuevaVersion, NuevaListaVer),
            documento2(TituloDoc, FechaDocs, NuevoContent, IdDocumento, Ownerdoc, ListadeAccesosDoc, NuevaListaVer, NuevoDocsVer),
            actualizardocumento(D, DocumentId, NuevoDocsVer, NuevalistaDocs),
            Sn2 = [N, F, U, NuevalistaDocs, []].

% Descripción: Predicado que restaura una versión de un documento a partir de un ID
% Dominio: paradigmaDocs X Entero X Entero X paradigmaDocs
paradigmaDocsRestoreVersion(Sn1, DocumentId, IdVersion, Sn2) :-
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            getuserlogueado(S, UserLogged),
            verificarowner(UserLogged, Ownerdoc),
            seleccionardocumento(DocumentId, D, DocumentoMod),
            gettitulo(DocumentoMod, TituloDoc),
            getfechaDoc(DocumentoMod, FechaDocs),
            getIdDoc(DocumentoMod, IdDocumento),
            getOwner(DocumentoMod, Ownerdoc),
            getAccessList(DocumentoMod, ListadeAccesosDoc),
            getVersionList(DocumentoMod, ListaVerDoc),
            seleccionarversion(IdVersion, ListaVerDoc, VersionRestaurar),
            getfechaVer(VersionRestaurar, FechaVerRest),
            getcontenidoVer(VersionRestaurar, ContenidoVerRest),
            largolistaversiones(ListaVerDoc, LargoListaVer),
            version(FechaVerRest, ContenidoVerRest, LargoListaVer, VersionRestaurada),
            agregarnuevaversion(ListaVerDoc, VersionRestaurada, NuevaListaVerRest),
            documento2(TituloDoc, FechaDocs, ContenidoVerRest, IdDocumento, Ownerdoc, ListadeAccesosDoc, NuevaListaVerRest, NuevoDocsVerRestored),
            actualizardocumento(D, DocumentId, NuevoDocsVerRestored, NuevalistaDocs),
            Sn2 = [N, F, U, NuevalistaDocs, []].


% Descripción: Predicado que traduce todo el contenido de la plataforma paradigmaDocs en un string dependiendo del estado de sesión
% Dominio: paradigmaDocs X String
paradigmaDocsToString(Sn1, StrOut) :-
            getplatformname(Sn1, N),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            getsesionactiva(Sn1, S),
            userloggedexists(S),
            getuserlogueado(S, UserLogged),
            obtenerusuario(UserLogged, U, ListaUserSearch),
            getusuarioencontrado(ListaUserSearch, UserSearch),
            usertostring(UserSearch, UserSearchStr),
            getdocsbyaccess(D, UserLogged, ListaDocsUser),
            alldocumentstostring(ListaDocsUser, DStr),
            crearstring_docs(DStr, DStrStr),
            ListStr = ["Plataforma ", N, "\n", "\n" ,UserSearchStr, "\n", "El usuario ", UserLogged, " es propietario o tiene accesos en los siguientes documentos: ", "\n", "\n", DStrStr],
            crearstring_paradigmadocs(ListStr, StrOut).

paradigmaDocsToString(Sn1, StrOut) :-
            getsesionactiva(Sn1, S),
            not(userloggedexists(S)),
            getplatformname(Sn1, N),
            getplatformdate(Sn1, F),
            getlistausers(Sn1, U),
            getlistadocs(Sn1, D),
            alldocumentstostring(D, DStr),
            crearstring_docs(DStr, DStrStr),
            alluserstostring(U, UStr),
            crearstring_users(UStr, UStrStr),
            datetostring(F, FStr),
            ListStr = ["Nombre de plataforma: ", N, "\n", "La fecha de creacion de la plataforma corresponde a: ", FStr, "\n", "Los usuarios registrados en esta plaforma corresponden a: ", "\n", "\n", UStrStr, "\n", "En esta plataforma estan creados los siguientes documentos:", "\n", DStrStr, "\n"],
            crearstring_paradigmadocs(ListStr, StrOut).

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
% Ejemplos paradigmaDocsLogin

% Se loguea el usuario "vflores" a la plataforma
ejemploLogin1(PD1) :-
            ejemploRegister1(X),
            paradigmaDocsLogin(X, "vflores", "hola123", PD1).

% La contraseña no coincide con el usuario vflores, retorna false
ejemploLogin2(PD1) :-
            ejemploRegister1(X),
            paradigmaDocsLogin(X, "vflores", "hola12345", PD1).

% El usuario no existe, retorna false
ejemploLogin3(PD1) :-
            ejemploRegister1(X),
            paradigmaDocsLogin(X, "vfloresdsdsds", "hola123", PD1).

% Se loguean dos usuarios seguidos, retorna false
ejemploLogin4(PD2) :-
            ejemploRegister1(X),
            paradigmaDocsLogin(X, "vflores", "hola123", PD1),
            paradigmaDocsLogin(PD1, "fco", "salfate", PD2).

%---------------------------------------------------------------------------
% Ejemplos de paradigmaDocsCreate
% Se crean 5 documentos, dos documentos pertenecen a "vflores", y el resto de los documentos son uno por cada usuario registrado
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
% Ejemplos paradigmaDocsShare

% el usuario "vflores" concede accesos de lectura a "crios" en un documento de su propiedad, luego
% el usuario "crios" concede accesos de lectura, comentar y compartir a los usuarios "fco" y "alopez", y luego
% el usuario "fco" quien tiene permisos de compartir el documento de "crios", comparte el documento junto con "vflores" en forma de lectura
% y "fco" comparte su propio documento en modo de escritura y lectura con "vflores" y "crios"
ejemploShare1(PD23) :-
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
            paradigmaDocsShare(PD18, 2, ["R", "C", "S"], ["fco", "alopez"], PD19),
            paradigmaDocsLogin(PD19, "fco", "salfate", PD20),
            paradigmaDocsShare(PD20, 2, ["R"], ["vflores"], PD21),
            paradigmaDocsLogin(PD21, "fco", "salfate", PD22),
            paradigmaDocsShare(PD22, 4, ["W", "R"], ["vflores", "crios"], PD23).

% Un usuario que no es dueño de un documento o que no posee permisos para compartir intenta compartir el documento
% Por lo tanto retorna false
ejemploShare2(PD17) :-
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
            paradigmaDocsShare(PD16, 4, ["R"], ["crios"], PD17).

% Fallo en la autenticación de sesión, por lo tanto retorna false
ejemploShare3(PD17) :-
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
            paradigmaDocsLogin(PD15, "vflores", "hola12345", PD16),
            paradigmaDocsShare(PD16, 4, ["R"], ["crios"], PD17).

%---------------------------------------------------------------------------
% Ejemplos paradigmaDocsAdd

% El usuario "vflores" quien tiene permisos de escritura y lectura en el documento de ID 4, agrega contenido al documento
% El usuario "vflores" quien es propietario del documento de ID 0, agrega contenido al documento
% El usuario "crios" quien también tiene permisos de escritura y lectura en el documento de ID 4, agrega más contenido al documento
ejemploAdd1(PD29) :-
            date(10, 12, 2015, D1), 
            date(11, 12, 2021, D2), 
            date(13, 12, 2021, D3),
            date(13, 12, 2021, D4),
            date(15, 12, 2021, D5),
            date(20, 12, 2021, D6),
            date(21, 12, 2021, D7),
            date(22, 12, 2021, D8),
            date(23, 12, 2021, D9),
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
            paradigmaDocsShare(PD18, 2, ["R", "C", "S"], ["fco", "alopez"], PD19),
            paradigmaDocsLogin(PD19, "fco", "salfate", PD20),
            paradigmaDocsShare(PD20, 2, ["R"], ["vflores"], PD21),
            paradigmaDocsLogin(PD21, "fco", "salfate", PD22),
            paradigmaDocsShare(PD22, 4, ["W", "R"], ["vflores", "crios"], PD23),
            paradigmaDocsLogin(PD23, "vflores", "hola123", PD24),
            paradigmaDocsAdd(PD24, 4, D8, " un poco mas de contenido", PD25),
            paradigmaDocsLogin(PD25, "vflores", "hola123", PD26),
            paradigmaDocsAdd(PD26, 0, D8, " me gusta prolog pero hacer ejemplos cansa un poquito", PD27),
            paradigmaDocsLogin(PD27, "crios", "qwert", PD28),
            paradigmaDocsAdd(PD28, 4, D9, " malditos ejemplos!!", PD29).

% El usuario "vflores" no es dueño del documento y tampoco tiene accesos para modificar el documento, 
% al intentar modificar el documento de ID 3 retorna false
ejemploAdd2(PD25) :-
            date(10, 12, 2015, D1), 
            date(11, 12, 2021, D2), 
            date(13, 12, 2021, D3),
            date(13, 12, 2021, D4),
            date(15, 12, 2021, D5),
            date(20, 12, 2021, D6),
            date(21, 12, 2021, D7),
            date(22, 12, 2021, D8),
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
            paradigmaDocsShare(PD18, 2, ["R", "C", "S"], ["fco", "alopez"], PD19),
            paradigmaDocsLogin(PD19, "fco", "salfate", PD20),
            paradigmaDocsShare(PD20, 2, ["R"], ["vflores"], PD21),
            paradigmaDocsLogin(PD21, "fco", "salfate", PD22),
            paradigmaDocsShare(PD22, 4, ["W", "R"], ["vflores", "crios"], PD23),
            paradigmaDocsLogin(PD23, "vflores", "hola123", PD24),
            paradigmaDocsAdd(PD24, 3, D8, " un poco mas de contenido", PD25).

% El usuario "vflores" tiene permisos en el documento 2, pero no los necesarios para modificar el contenido del documento
% Por lo tanto retorna false
ejemploAdd3(PD25) :-
            date(10, 12, 2015, D1), 
            date(11, 12, 2021, D2), 
            date(13, 12, 2021, D3),
            date(13, 12, 2021, D4),
            date(15, 12, 2021, D5),
            date(20, 12, 2021, D6),
            date(21, 12, 2021, D7),
            date(22, 12, 2021, D8),
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
            paradigmaDocsShare(PD18, 2, ["R", "C", "S"], ["fco", "alopez"], PD19),
            paradigmaDocsLogin(PD19, "fco", "salfate", PD20),
            paradigmaDocsShare(PD20, 2, ["R"], ["vflores"], PD21),
            paradigmaDocsLogin(PD21, "fco", "salfate", PD22),
            paradigmaDocsShare(PD22, 4, ["W", "R"], ["vflores", "crios"], PD23),
            paradigmaDocsLogin(PD23, "vflores", "hola123", PD24),
            paradigmaDocsAdd(PD24, 2, D8, " un poco mas de contenido", PD25).

%---------------------------------------------------------------------------
% Ejemplos paradigmaDocsRestoreVersion

% el usuario "fco" restaura la versión 1 de su documento de ID 4
% el usuario "fco" nuevamente realiza una restauración de la versión 2 de su documento de ID 4
% el usuario "vflores" restaura la versión original de su documento de ID 0
ejemploRestoreVersion1(PD35) :-
            date(10, 12, 2015, D1), 
            date(11, 12, 2021, D2), 
            date(13, 12, 2021, D3),
            date(13, 12, 2021, D4),
            date(15, 12, 2021, D5),
            date(20, 12, 2021, D6),
            date(21, 12, 2021, D7),
            date(22, 12, 2021, D8),
            date(23, 12, 2021, D9),
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
            paradigmaDocsShare(PD18, 2, ["R", "C", "S"], ["fco", "alopez"], PD19),
            paradigmaDocsLogin(PD19, "fco", "salfate", PD20),
            paradigmaDocsShare(PD20, 2, ["R"], ["vflores"], PD21),
            paradigmaDocsLogin(PD21, "fco", "salfate", PD22),
            paradigmaDocsShare(PD22, 4, ["W", "R"], ["vflores", "crios"], PD23),
            paradigmaDocsLogin(PD23, "vflores", "hola123", PD24),
            paradigmaDocsAdd(PD24, 4, D8, " un poco mas de contenido", PD25),
            paradigmaDocsLogin(PD25, "vflores", "hola123", PD26),
            paradigmaDocsAdd(PD26, 0, D8, " me gusta prolog pero hacer ejemplos cansa un poquito", PD27),
            paradigmaDocsLogin(PD27, "crios", "qwert", PD28),
            paradigmaDocsAdd(PD28, 4, D9, " malditos ejemplos!!", PD29),
            paradigmaDocsLogin(PD29, "fco", "salfate", PD30),
            paradigmaDocsRestoreVersion(PD30, 4, 1, PD31),
            paradigmaDocsLogin(PD31, "vflores", "hola123", PD32),
            paradigmaDocsRestoreVersion(PD32, 0, 0, PD33),
            paradigmaDocsLogin(PD33, "fco", "salfate", PD34),
            paradigmaDocsRestoreVersion(PD34, 4, 2, PD35).

% vflores tiene varios accesos al documento de ID 4, pero él no es el propietario de el documento
% por lo tanto se retorna false
ejemploRestoreVersion2(PD31) :-
            date(10, 12, 2015, D1), 
            date(11, 12, 2021, D2), 
            date(13, 12, 2021, D3),
            date(13, 12, 2021, D4),
            date(15, 12, 2021, D5),
            date(20, 12, 2021, D6),
            date(21, 12, 2021, D7),
            date(22, 12, 2021, D8),
            date(23, 12, 2021, D9),
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
            paradigmaDocsShare(PD18, 2, ["R", "C", "S"], ["fco", "alopez"], PD19),
            paradigmaDocsLogin(PD19, "fco", "salfate", PD20),
            paradigmaDocsShare(PD20, 2, ["R"], ["vflores"], PD21),
            paradigmaDocsLogin(PD21, "fco", "salfate", PD22),
            paradigmaDocsShare(PD22, 4, ["W", "R"], ["vflores", "crios"], PD23),
            paradigmaDocsLogin(PD23, "vflores", "hola123", PD24),
            paradigmaDocsAdd(PD24, 4, D8, " un poco mas de contenido", PD25),
            paradigmaDocsLogin(PD25, "vflores", "hola123", PD26),
            paradigmaDocsAdd(PD26, 0, D8, " me gusta prolog pero hacer ejemplos cansa un poquito", PD27),
            paradigmaDocsLogin(PD27, "crios", "qwert", PD28),
            paradigmaDocsAdd(PD28, 4, D9, " malditos ejemplos!!", PD29),
            paradigmaDocsLogin(PD29, "vflores", "hola123", PD30),
            paradigmaDocsRestoreVersion(PD30, 4, 1, PD31).


%---------------------------------------------------------------------------
% Ejemplos paradigmaDocsToString

% Se muestra toda la información de la plataforma en sus etapas más tempranas
ejemploToString1(PD) :-
            ejemploRegister1(X),
            paradigmaDocsToString(X, PD).

% Se muestra toda la información de la plataforma en una etapa más avanzada
ejemploToString2(PD) :-
            ejemploAdd1(X),
            paradigmaDocsToString(X, PD).

% Se muestra toda la información de la plataforma nuevamente
ejemploToString3(PD) :-
            ejemploRestoreVersion1(X),
            paradigmaDocsToString(X, PD).

% Se muestra la misma información del ejemplo 3 pero enfocada en un usuario en particular a través de login
ejemploToString4(PD) :-
            ejemploRestoreVersion1(X),
            paradigmaDocsLogin(X, "vflores", "hola123", SesionIniciada),
            paradigmaDocsToString(SesionIniciada, PD).
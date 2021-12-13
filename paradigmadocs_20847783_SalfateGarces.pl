:- use_module(library(theme/dark)). % Permite utilizar modo oscuro

% TDA Fecha
% El TDA Fecha se representa a traves de una lista que almacena un dia
% de tipo entero, un mes de tipo entero, y un anho de tipo entero.

% Constructor
fecha(Dia,Mes,Year, [Dia,Mes,Year]):-
            number(Dia),number(Mes),number(Year),
            Mes > 0, (Mes < 12; Mes = 12).

% Selectores
getdia([Dia, _, _], Dia).

getmes([_, Mes, _], Mes).

getanho([_, _, Year], Year).

% Pertenencia
isfecha([Dia,Mes,Year]) :-
    fecha(Dia,Mes,Year,_).




% TDA Paradigmadocs
% El TDA Paradigmadocs se representa a traves de una lista que almacena
% el nombre de la plataforma (string), y su fecha de creacion (tipo
% fecha) junto a dos listas que almacenaran los usuarios y sus
% documentos creados.

% Constructor
paradigmadocs(Name, Date, [Name, Date, [], []]).

%Selectores
getplatformname([Name,_,_,_], Name).

getplatformdate([_,Date,_,_], Date).

getlistausers([_,_,Listausers,_], Listausers).

getlistadocs([_,_,_,Listadocs], Listadocs).




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

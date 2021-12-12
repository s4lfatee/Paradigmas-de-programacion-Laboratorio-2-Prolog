:- use_module(library(theme/dark)). % Permite utilizar modo oscuro

% TDA Fecha
% El TDA Fecha se representa a traves de una lista que almacena un dia
% de tipo entero, un mes de tipo entero, y un anho de tipo entero.

% Constructor
fecha(D,M,Y, [D,M,Y]):-
            number(D),number(M),number(Y),
            M > 0, (M < 12; M = 12).

% Selectores
getdia([DIA, _, _], DIA).

getmes([_, MES, _], MES).

getanho([_, _, ANHO], ANHO).

% Pertenencia
isfecha([D,M,Y]) :-
    fecha(D,M,Y,_).


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


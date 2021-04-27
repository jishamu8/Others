/* *****************************************************
//  INS JOAN D'AUSTRIA
//	CFGS DAW
//	M2: Bases de dades. UF2: Llenguatge SQL
//	PRÀCTICA UF2. FASE 2
//	AUTOR: 
//	DATA: 
****************************************************** */

/*                ATENCIÓ:                   */
/*  NO MODIFIQUEU RES ENTRE AQUESTA LINEA I LA 60 */

/* BORRAT DE TAULES */
/* QUAN ESTIGUIN CREADES LES CLAUS FORANES CALDRÀ TENIR PRESENT L'ORDRE: */
/* PARTIDO PREVIA A EQUIP. ESTADISTICAS PREVIA A JUGADOR. JUGADOR PREVIA A EQUIP */
DROP TABLE PARTIDO;
DROP TABLE ESTADISTICAS;
DROP TABLE JUGADOR;
DROP TABLE EQUIPO;

/* CREACIO DE LA TAULA EQUIP */
CREATE TABLE equipo (
  Nombre varchar2(20),
  Ciudad varchar2(20) NOT NULL,
  Conferencia varchar2(4) NOT NULL,
  Division varchar2(9) NOT NULL
);

/* CREACIO DE LA TAULA JUGADOR */
CREATE TABLE jugador (
  codigo int,
  Nombre varchar2(30) NOT NULL,
  Procedencia varchar2(20),
  Altura varchar2(4),
  Peso int,
  Posicion varchar2(5),
  Nombre_equipo varchar2(20) NOT NULL
);

/* CREACIO DE LA TAULA ESTADISTICAS */
CREATE TABLE estadisticas (
  codigo int,
  temporada varchar2(5),
  Puntos_por_partido NUMBER(3,1) DEFAULT 0,
  Asistencias_por_partido NUMBER(3,1) DEFAULT 0,
  Tapones_por_partido NUMBER(3,1) DEFAULT 0,
  Rebotes_por_partido NUMBER(3,1) DEFAULT 0
);

/* CREACIO DE LA TAULA PARTIDO */
CREATE TABLE partido (
  codigo int,
  equipo_local varchar2(20) NOT NULL,
  equipo_visitante varchar2(20) NOT NULL,
  puntos_local int,
  puntos_visitante int,
  temporada varchar2(5) NOT NULL
);

/* AFEGIU A PARTIR D'AQUI LA VOSTRA SOLUCIO A LA FASE 2 */

/* CONSTRAINTS SOBRE LA TAULA EQUIP */
ALTER TABLE EQUIPO 
ADD CONSTRAINT PK_EQUIP PRIMARY KEY(Nombre);

ALTER TABLE EQUIPO 
ADD CONSTRAINT CH_CONFERENCIA CHECK (conferencia='East' OR conferencia='West');

ALTER TABLE EQUIPO 
ADD CONSTRAINT CH_DIVISION CHECK (division IN ('Atlantic', 'Central', 'SouthEast', 'NorthWest', 'Pacific' ,'SouthWest'));

/* CONSTRAINTS SOBRE LA TAULA JUGADOR */
ALTER TABLE JUGADOR 
ADD CONSTRAINT PK_JUGADOR PRIMARY KEY(codigo);

ALTER TABLE JUGADOR
ADD CONSTRAINT FK_JUG_EQUIP FOREIGN KEY(nombre_equipo) REFERENCES EQUIPO(nombre);

ALTER TABLE JUGADOR 
ADD CONSTRAINT CH_PESO CHECK (PESO>=130 AND PESO<=400);

ALTER TABLE JUGADOR 
ADD CONSTRAINT CH_POSICION CHECK (
   posicion IN('C','F','G','C-F','C-G','F-C','F-G','G-C','G-F','C-F-G','C-G-F','F-C-G','F-G-C','G-C-F','G-F-C')
);


/* CONSTRAINTS SOBRE LA TAULA ESTADISTICAS */
ALTER TABLE ESTADISTICAS 
ADD CONSTRAINT PK_ESTADISTICAS PRIMARY KEY(codigo, temporada);

ALTER TABLE ESTADISTICAS
ADD CONSTRAINT FK_EST_JUG FOREIGN KEY(codigo) REFERENCES JUGADOR(codigo)
ON DELETE CASCADE;

ALTER TABLE ESTADISTICAS 
ADD CONSTRAINT CH_DATOS_OK CHECK (Puntos_por_partido>=0 AND  Asistencias_por_partido >=0 AND
  Tapones_por_partido>=0 AND Rebotes_por_partido >=0);


/* CONSTRAINTS SOBRE LA TAULA PARTIDO */
ALTER TABLE PARTIDO 
ADD CONSTRAINT PK_PARTIDO PRIMARY KEY(codigo);

ALTER TABLE PARTIDO
ADD CONSTRAINT FK_PART_LOCAL FOREIGN KEY(equipo_local) REFERENCES EQUIPO(Nombre);

ALTER TABLE PARTIDO
ADD CONSTRAINT FK_PART_VISIT FOREIGN KEY(equipo_visitante) REFERENCES EQUIPO(Nombre);




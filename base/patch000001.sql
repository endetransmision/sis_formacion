/***********************************I-SCP-YAC-SIGEFO-0-02/05/2017****************************************/

CREATE TABLE sigefo.tplanificacion (
  id_planificacion SERIAL NOT NULL,
  id_gestion INTEGER,
  nombre_planificacion VARCHAR(150),
  contenido_basico TEXT,
  necesidad TEXT,
  cantidad_personas INTEGER,
  horas_previstas INTEGER,
  PRIMARY KEY(id_planificacion)
) INHERITS (pxp.tbase)

WITH (oids = false)
TABLESPACE pg_default;

/***********************************F-SCP-YAC-SIGEFO-0-02/05/2017****************************************/
/***********************************I-SCP-YAC-SIGEFO-0-04/05/2017****************************************/
 
CREATE TABLE sigefo.tplanificacion_critico (
  id_planificacion INTEGER,
  cod_criterio VARCHAR(10)
) INHERITS (pxp.tbase)

WITH (oids = false);


CREATE TABLE sigefo.tcompetencia (
  id_competencia SERIAL NOT NULL,
  competencia VARCHAR(200),
  tipo VARCHAR(15),
  PRIMARY KEY(id_competencia)
) INHERITS (pxp.tbase)

WITH (oids = false);


CREATE TABLE sigefo.tcargo_competencia (
  id_cargo INTEGER,
  id_competencia INTEGER
) INHERITS (pxp.tbase)

WITH (oids = false);


CREATE TABLE sigefo.tplanificacion_competencia (
  id_planificacion INTEGER,
  id_competencia INTEGER
) INHERITS (pxp.tbase)

WITH (oids = false);


CREATE TABLE sigefo.tplanificacion_cargo (
  id_planificacion INTEGER,
  id_cargo INTEGER
) INHERITS (pxp.tbase)

WITH (oids = false);

/***********************************F-SCP-YAC-SIGEFO-0-04/05/2017****************************************/


/***********************************I-SCP-JUAN-SIGEFO-0-05/05/2017****************************************/

CREATE TABLE sigefo.tcurso (
  id_curso SERIAL NOT NULL,
  id_gestion INTEGER,
  nombre_curso VARCHAR(50),
  cod_tipo VARCHAR(50),
  cod_clasificacion VARCHAR(50),
  objetivo VARCHAR(1000),
  contenido VARCHAR(1000),
  fecha_inicio DATE,
  fecha_fin DATE,
  horas INTEGER,
  id_lugar INTEGER,
  origen VARCHAR(50),
  expositor VARCHAR(50),
  id_proveedor INTEGER,
  PRIMARY KEY(id_curso)
) INHERITS (pxp.tbase)

WITH (oids = false);


CREATE TABLE sigefo.tcurso_competencia (
  id_curso_competencia SERIAL NOT NULL,
  id_curso INTEGER,
  id_competencia INTEGER,
  PRIMARY KEY(id_curso_competencia)
) INHERITS (pxp.tbase)

WITH (oids = false);


CREATE TABLE sigefo.tcurso_planificacion (
  id_curso_planificacion SERIAL NOT NULL,
  id_curso INTEGER,
  id_planificacion INTEGER,
  PRIMARY KEY(id_curso_planificacion)
) INHERITS (pxp.tbase)

WITH (oids = false);
/***********************************F-SCP-JUAN-SIGEFO-0-05/05/2017****************************************/

/***********************************I-SCP-YAC-SIGEFO-0-05/05/2017****************************************/

CREATE TABLE sigefo.tplanificacion_proveedor (
  id_planificacion INTEGER,
  id_proveedor INTEGER
) INHERITS (pxp.tbase)

WITH (oids = false);

/***********************************F-SCP-YAC-SIGEFO-0-05/05/2017****************************************/

/***********************************I-SCP-JUAN-SIGEFO-0-08/05/2017****************************************/

CREATE TABLE sigefo.tcurso_funcionario (
  id_curso_funcionario SERIAL NOT NULL,
  id_curso INTEGER,
  id_funcionario INTEGER,
  PRIMARY KEY(id_curso_funcionario)
  ) INHERITS (pxp.tbase)

WITH (oids = false);
  
/***********************************F-SCP-JUAN-SIGEFO-0-08/05/2017****************************************/

/***********************************I-SCP-YAC-SIGEFO-0-08/05/2017****************************************/

ALTER TABLE sigefo.tplanificacion_critico
  RENAME TO tplanificacion_criterio;

/***********************************F-SCP-YAC-SIGEFO-0-08/05/2017****************************************/
/***********************************I-SCP-YAC-SIGEFO-0-10/05/2017****************************************/

CREATE TABLE sigefo.tplanificacion_uo (
  id_planificacion INTEGER,
  id_uo INTEGER
) INHERITS (pxp.tbase)

WITH (oids = false);
/***********************************F-SCP-YAC-SIGEFO-0-10/05/2017****************************************/

/***********************************I-SCP-YAC-SIGEFO-0-15/05/2017****************************************/
ALTER TABLE sigefo.tcurso
  ADD COLUMN id_lugar_pais INTEGER;
/***********************************F-SCP-YAC-SIGEFO-0-15/05/2017****************************************/



/***********************************I-SCP-MANU-SIGEFO-0-30/06/2017****************************************/
ALTER TABLE sigefo.tcurso
  ADD COLUMN cod_prioridad VARCHAR(10);
  
ALTER TABLE sigefo.tcurso
  ADD COLUMN peso INTEGER;
/***********************************F-SCP-MANU-SIGEFO-0-30/06/2017****************************************/


/***********************************I-SCP-MANU-SIGEFO-0-18/07/2017****************************************/
CREATE TABLE sigefo.tavance_real (
  id_avance_real SERIAL NOT NULL,
  id_uo INTEGER,
  id_curso INTEGER,
  mes VARCHAR(50),
  avance_real NUMERIC(10,2),
  PRIMARY KEY(id_avance_real)
) INHERITS (pxp.tbase)

WITH (oids = false);

/***********************************F-SCP-MANU-SIGEFO-0-18/07/2017****************************************/


/***********************************I-SCP-MANU-SIGEFO-0-12/09/2017****************************************/
CREATE TABLE sigefo.tcategoria (
  id_categoria SERIAL NOT NULL,
  categoria VARCHAR(50),
  tipo VARCHAR(15),
  PRIMARY KEY(id_categoria)
) INHERITS (pxp.tbase)

WITH (oids = false);

ALTER TABLE sigefo.tcategoria
  ALTER COLUMN id_categoria SET STATISTICS 0;
  

CREATE TABLE sigefo.tpreguntas (
  id_pregunta SERIAL NOT NULL,
  id_categoria INTEGER,
  pregunta VARCHAR(1500),
  habilitado BOOLEAN,
  tipo VARCHAR(10),
  seccion INTEGER,
  PRIMARY KEY(id_pregunta)
) INHERITS (pxp.tbase)

WITH (oids = false);


ALTER TABLE sigefo.tpreguntas
  ADD CONSTRAINT tpreguntas_fk FOREIGN KEY (id_categoria)
    REFERENCES sigefo.tcategoria(id_categoria)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/***********************************F-SCP-MANU-SIGEFO-0-12/09/2017****************************************/


/***********************************I-SCP-JUAN-SIGEFO-0-09/11/2017****************************************/

ALTER TABLE sigefo.tplanificacion
  ADD COLUMN id_gerencia INTEGER;
  
--------------- SQL ---------------

ALTER TABLE sigefo.tplanificacion
  ADD COLUMN id_unidad_organizacional INTEGER;
  
/***********************************F-SCP-JUAN-SIGEFO-0-09/11/2017****************************************/


/***********************************I-SCP-JUAN-SIGEFO-0-10/11/2017****************************************/

ALTER TABLE sigefo.tcurso
  ADD COLUMN id_gerencia INTEGER;
  
--------------- SQL ---------------

ALTER TABLE sigefo.tcurso
  ADD COLUMN id_unidad_organizacional INTEGER;

--------------- SQL ---------------

ALTER TABLE sigefo.tcurso
  ADD COLUMN id_planificacion INTEGER;
  
--------------- SQL ---------------

ALTER TABLE sigefo.tplanificacion
  ADD COLUMN id_proveedor INTEGER;
  
--------------- SQL ---------------

ALTER TABLE sigefo.tcurso
  ALTER COLUMN peso TYPE NUMERIC(10,2);
  
--------------- SQL ---------------

ALTER TABLE sigefo.tcurso
  ALTER COLUMN peso TYPE NUMERIC;
/***********************************F-SCP-JUAN-SIGEFO-0-10/11/2017****************************************/


/***********************************I-SCP-JUAN-SIGEFO-0-17/11/2017****************************************/
ALTER TABLE sigefo.tcategoria
  ADD COLUMN habilitado BOOLEAN;
/***********************************F-SCP-JUAN-SIGEFO-0-17/11/2017****************************************/
  
/***********************************I-SCP-JUAN-SIGEFO-0-21/11/2017****************************************/
CREATE TABLE sigefo.tcurso_funcionario_eval (
  id_curso_funcionario_eval SERIAL NOT NULL,
  id_pregunta INTEGER,
  cod_respuesta INTEGER,
  id_funcionario INTEGER,
  id_curso INTEGER,
  respuesta_texto TEXT,
  PRIMARY KEY(id_curso_funcionario_eval)
) 
WITH (oids = false);
/***********************************F-SCP-JUAN-SIGEFO-0-21/11/2017****************************************/
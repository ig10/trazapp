--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: actividades; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE actividades (
    id integer NOT NULL,
    proyecto_id integer,
    nombre character varying(255),
    estado character varying(255),
    revision date,
    progreso double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    puntos integer DEFAULT 0,
    evaluacion double precision DEFAULT 0.0
);


--
-- Name: actividades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE actividades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: actividades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE actividades_id_seq OWNED BY actividades.id;


--
-- Name: configuraciones; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE configuraciones (
    id integer NOT NULL,
    autor integer,
    nombre_archivo character varying(255),
    formato character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status integer DEFAULT 0
);


--
-- Name: configuraciones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE configuraciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: configuraciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE configuraciones_id_seq OWNED BY configuraciones.id;


--
-- Name: estructuras; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE estructuras (
    id integer NOT NULL,
    nombre character varying(255),
    json hstore,
    data text
);


--
-- Name: estructuras_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE estructuras_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: estructuras_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE estructuras_id_seq OWNED BY estructuras.id;


--
-- Name: proyectos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE proyectos (
    id integer NOT NULL,
    nombre character varying(255),
    estado character varying(255) DEFAULT 'activo'::character varying,
    fecha_cierre date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    estructura_id integer,
    seccion_id integer
);


--
-- Name: proyectos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE proyectos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: proyectos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE proyectos_id_seq OWNED BY proyectos.id;


--
-- Name: proyectos_usuarios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE proyectos_usuarios (
    proyecto_id integer,
    usuario_id integer
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: secciones; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE secciones (
    id integer NOT NULL,
    nombre character varying(255),
    jornada character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sigla character varying(255)
);


--
-- Name: secciones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE secciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: secciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE secciones_id_seq OWNED BY secciones.id;


--
-- Name: secciones_usuarios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE secciones_usuarios (
    seccion_id integer,
    usuario_id integer
);


--
-- Name: solicitudes_usuarios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE solicitudes_usuarios (
    solicitud_id integer,
    usuario_id integer
);


--
-- Name: tareas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tareas (
    id integer NOT NULL,
    actividad_id integer,
    descripcion text,
    revision date,
    estado character varying(255) DEFAULT 'incompleta'::character varying,
    evaluacion double precision DEFAULT 0.0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    puntos integer DEFAULT 0,
    nombre character varying(255)
);


--
-- Name: tareas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tareas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tareas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tareas_id_seq OWNED BY tareas.id;


--
-- Name: tmp_actividades; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tmp_actividades (
    id integer NOT NULL,
    proyecto_id integer,
    modulo character varying(255),
    funcionalidad character varying(255),
    complejidad integer,
    estado character varying(255),
    revision date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: tmp_actividades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tmp_actividades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tmp_actividades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tmp_actividades_id_seq OWNED BY tmp_actividades.id;


--
-- Name: tmp_proyectos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tmp_proyectos (
    id integer NOT NULL,
    nombre character varying(255),
    estado character varying(255) DEFAULT 'pendiente'::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fecha_expiracion date,
    expire_date date,
    descripcion text,
    seccion_id integer
);


--
-- Name: tmp_proyectos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tmp_proyectos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tmp_proyectos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tmp_proyectos_id_seq OWNED BY tmp_proyectos.id;


--
-- Name: tmp_proyectos_usuarios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tmp_proyectos_usuarios (
    tmp_proyecto_id integer,
    usuario_id integer
);


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE usuarios (
    id integer NOT NULL,
    rut character varying(255),
    nombre_completo character varying(255),
    correo_electronico character varying(255),
    perfil character varying(255),
    sede character varying(255),
    carrera character varying(255),
    activo boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    password character varying(255)
);


--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE usuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE usuarios_id_seq OWNED BY usuarios.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY actividades ALTER COLUMN id SET DEFAULT nextval('actividades_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY configuraciones ALTER COLUMN id SET DEFAULT nextval('configuraciones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY estructuras ALTER COLUMN id SET DEFAULT nextval('estructuras_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY proyectos ALTER COLUMN id SET DEFAULT nextval('proyectos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY secciones ALTER COLUMN id SET DEFAULT nextval('secciones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tareas ALTER COLUMN id SET DEFAULT nextval('tareas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tmp_actividades ALTER COLUMN id SET DEFAULT nextval('tmp_actividades_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tmp_proyectos ALTER COLUMN id SET DEFAULT nextval('tmp_proyectos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY usuarios ALTER COLUMN id SET DEFAULT nextval('usuarios_id_seq'::regclass);


--
-- Name: actividades_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY actividades
    ADD CONSTRAINT actividades_pkey PRIMARY KEY (id);


--
-- Name: configuraciones_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY configuraciones
    ADD CONSTRAINT configuraciones_pkey PRIMARY KEY (id);


--
-- Name: estructuras_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY estructuras
    ADD CONSTRAINT estructuras_pkey PRIMARY KEY (id);


--
-- Name: proyectos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT proyectos_pkey PRIMARY KEY (id);


--
-- Name: secciones_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY secciones
    ADD CONSTRAINT secciones_pkey PRIMARY KEY (id);


--
-- Name: tareas_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tareas
    ADD CONSTRAINT tareas_pkey PRIMARY KEY (id);


--
-- Name: tmp_actividades_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tmp_actividades
    ADD CONSTRAINT tmp_actividades_pkey PRIMARY KEY (id);


--
-- Name: tmp_proyectos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tmp_proyectos
    ADD CONSTRAINT tmp_proyectos_pkey PRIMARY KEY (id);


--
-- Name: usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: index_proyectos_usuarios_on_proyecto_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_proyectos_usuarios_on_proyecto_id ON proyectos_usuarios USING btree (proyecto_id);


--
-- Name: index_proyectos_usuarios_on_usuario_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_proyectos_usuarios_on_usuario_id ON proyectos_usuarios USING btree (usuario_id);


--
-- Name: index_secciones_usuarios_on_seccion_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_secciones_usuarios_on_seccion_id ON secciones_usuarios USING btree (seccion_id);


--
-- Name: index_secciones_usuarios_on_usuario_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_secciones_usuarios_on_usuario_id ON secciones_usuarios USING btree (usuario_id);


--
-- Name: index_solicitudes_usuarios_on_solicitud_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_solicitudes_usuarios_on_solicitud_id ON solicitudes_usuarios USING btree (solicitud_id);


--
-- Name: index_solicitudes_usuarios_on_usuario_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_solicitudes_usuarios_on_usuario_id ON solicitudes_usuarios USING btree (usuario_id);


--
-- Name: index_tmp_proyectos_usuarios_on_tmp_proyecto_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tmp_proyectos_usuarios_on_tmp_proyecto_id ON tmp_proyectos_usuarios USING btree (tmp_proyecto_id);


--
-- Name: index_tmp_proyectos_usuarios_on_usuario_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tmp_proyectos_usuarios_on_usuario_id ON tmp_proyectos_usuarios USING btree (usuario_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20131008161820');

INSERT INTO schema_migrations (version) VALUES ('20131008161925');

INSERT INTO schema_migrations (version) VALUES ('20131008162232');

INSERT INTO schema_migrations (version) VALUES ('20131029155839');

INSERT INTO schema_migrations (version) VALUES ('20131029164311');

INSERT INTO schema_migrations (version) VALUES ('20131029230436');

INSERT INTO schema_migrations (version) VALUES ('20131029230818');

INSERT INTO schema_migrations (version) VALUES ('20131112141301');

INSERT INTO schema_migrations (version) VALUES ('20131112142344');

INSERT INTO schema_migrations (version) VALUES ('20131112225053');

INSERT INTO schema_migrations (version) VALUES ('20131113011844');

INSERT INTO schema_migrations (version) VALUES ('20140929232835');

INSERT INTO schema_migrations (version) VALUES ('20140930003159');

INSERT INTO schema_migrations (version) VALUES ('20140930003518');

INSERT INTO schema_migrations (version) VALUES ('20141003000916');

INSERT INTO schema_migrations (version) VALUES ('20141031232950');

INSERT INTO schema_migrations (version) VALUES ('20141031235033');

INSERT INTO schema_migrations (version) VALUES ('20141101002421');

INSERT INTO schema_migrations (version) VALUES ('20141106023125');

INSERT INTO schema_migrations (version) VALUES ('20141106221005');

INSERT INTO schema_migrations (version) VALUES ('20141205001419');

INSERT INTO schema_migrations (version) VALUES ('20141211014050');

INSERT INTO schema_migrations (version) VALUES ('20141211015131');

INSERT INTO schema_migrations (version) VALUES ('20141211020605');

INSERT INTO schema_migrations (version) VALUES ('20141211025006');

INSERT INTO schema_migrations (version) VALUES ('20141211033714');

INSERT INTO schema_migrations (version) VALUES ('20141211034328');

INSERT INTO schema_migrations (version) VALUES ('20141211041102');

INSERT INTO schema_migrations (version) VALUES ('20141211043140');

INSERT INTO schema_migrations (version) VALUES ('20141211191741');
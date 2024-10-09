--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.0

-- Started on 2024-09-09 21:54:43

-- TOC entry 7 (class 2615 OID 16815)
-- Name: content; Type: SCHEMA; Schema: -; Owner: app
--

CREATE SCHEMA content;

ALTER SCHEMA content OWNER TO app;


-- TOC entry 217 (class 1259 OID 16816)
-- Name: film_work; Type: TABLE; Schema: content; Owner: app
--

CREATE TABLE content.film_work (
    id uuid NOT NULL,
    title text NOT NULL,
    description text,
    creation_date date,
    rating double precision,
    type text NOT NULL,
    created timestamp with time zone,
    modified timestamp with time zone
);

ALTER TABLE content.film_work OWNER TO app;

ALTER TABLE ONLY content.film_work
    ADD CONSTRAINT film_work_pkey PRIMARY KEY (id);

CREATE INDEX film_work_creation_date_idx ON content.film_work USING btree (creation_date);
CREATE UNIQUE INDEX title_creation_date_idx ON content.film_work USING btree (title, creation_date);

--
-- TOC entry 218 (class 1259 OID 16823)
-- Name: genre; Type: TABLE; Schema: content; Owner: app
--

CREATE TABLE content.genre (
    id uuid NOT NULL,
    name text NOT NULL,
    description text,
    created timestamp with time zone,
    modified timestamp with time zone
);


ALTER TABLE content.genre OWNER TO app;

ALTER TABLE ONLY content.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (id);

CREATE UNIQUE INDEX name_idx ON content.genre USING btree (name);

--
-- TOC entry 219 (class 1259 OID 16830)
-- Name: genre_film_work; Type: TABLE; Schema: content; Owner: app
--

CREATE TABLE content.genre_film_work (
    id uuid NOT NULL,
    film_work_id uuid NOT NULL,
    genre_id uuid NOT NULL,
    created timestamp with time zone
);


ALTER TABLE content.genre_film_work OWNER TO app;

ALTER TABLE ONLY content.genre_film_work
    ADD CONSTRAINT genre_film_work_pkey PRIMARY KEY (id);
ALTER TABLE ONLY content.genre_film_work
    ADD CONSTRAINT genre_film_work_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES content.film_work(id) ON DELETE CASCADE;
ALTER TABLE ONLY content.genre_film_work
    ADD CONSTRAINT genre_film_work_film_work_id_fkey FOREIGN KEY (film_work_id) REFERENCES content.film_work(id) ON DELETE CASCADE;

CREATE INDEX film_work_id_idx ON content.genre_film_work USING btree (film_work_id);
CREATE INDEX genre_id_idx ON content.genre_film_work USING btree (genre_id);

--
-- TOC entry 220 (class 1259 OID 16845)
-- Name: person; Type: TABLE; Schema: content; Owner: app
--

CREATE TABLE content.person (
    id uuid NOT NULL,
    full_name character varying(200) NOT NULL,
    created timestamp with time zone,
    modified timestamp with time zone
);


ALTER TABLE content.person OWNER TO app;

ALTER TABLE ONLY content.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);
CREATE INDEX full_name_idx ON content.person USING btree (full_name);


--
-- TOC entry 221 (class 1259 OID 16868)
-- Name: person_film_work; Type: TABLE; Schema: content; Owner: postgres
--

CREATE TABLE content.person_film_work (
    id uuid NOT NULL,
    person_id uuid NOT NULL,
    film_work_id uuid NOT NULL,
    role character varying(100),
    created timestamp with time zone
);


ALTER TABLE content.person_film_work OWNER TO postgres;

ALTER TABLE ONLY content.person_film_work
    ADD CONSTRAINT person_film_work_pkey PRIMARY KEY (id);
ALTER TABLE ONLY content.person_film_work
    ADD CONSTRAINT person_film_work_person_id_fkey FOREIGN KEY (person_id) REFERENCES content.person(id) ON DELETE CASCADE;
ALTER TABLE ONLY content.person_film_work
    ADD CONSTRAINT person_film_work_film_work_id_fkey FOREIGN KEY (film_work_id) REFERENCES content.film_work(id) ON DELETE CASCADE;

CREATE INDEX person_id_idx ON content.person_film_work USING btree (person_id);
CREATE UNIQUE INDEX film_work_person_idx ON content.person_film_work USING btree (film_work_id, person_id);


--
-- TOC entry 4663 (class 2606 OID 16822)
-- Name: film_work film_work_pkey; Type: CONSTRAINT; Schema: content; Owner: app
--


-- Completed on 2024-09-09 21:54:44

--
-- PostgreSQL database dump complete
--


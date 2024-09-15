--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.0

-- Started on 2024-09-14 23:07:20

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16815)
-- Name: content; Type: SCHEMA; Schema: -; Owner: app
--

CREATE SCHEMA content;


ALTER SCHEMA content OWNER TO app;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
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
    modified timestamp with time zone,
    certificate character varying(512) NOT NULL,
    file_path character varying(100) NOT NULL
);


ALTER TABLE content.film_work OWNER TO app;

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

--
-- TOC entry 4702 (class 2606 OID 16822)
-- Name: film_work film_work_pkey; Type: CONSTRAINT; Schema: content; Owner: app
--

ALTER TABLE ONLY content.film_work
    ADD CONSTRAINT film_work_pkey PRIMARY KEY (id);


--
-- TOC entry 4709 (class 2606 OID 16834)
-- Name: genre_film_work genre_film_work_pkey; Type: CONSTRAINT; Schema: content; Owner: app
--

ALTER TABLE ONLY content.genre_film_work
    ADD CONSTRAINT genre_film_work_pkey PRIMARY KEY (id);


--
-- TOC entry 4705 (class 2606 OID 16829)
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: content; Owner: app
--

ALTER TABLE ONLY content.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (id);


--
-- TOC entry 4716 (class 2606 OID 16872)
-- Name: person_film_work person_film_work_pkey; Type: CONSTRAINT; Schema: content; Owner: postgres
--

ALTER TABLE ONLY content.person_film_work
    ADD CONSTRAINT person_film_work_pkey PRIMARY KEY (id);


--
-- TOC entry 4713 (class 2606 OID 16849)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: content; Owner: app
--

ALTER TABLE ONLY content.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- TOC entry 4700 (class 1259 OID 16894)
-- Name: film_work_creation_date_idx; Type: INDEX; Schema: content; Owner: app
--

CREATE INDEX film_work_creation_date_idx ON content.film_work USING btree (creation_date);


--
-- TOC entry 4707 (class 1259 OID 25017)
-- Name: film_work_id_idx; Type: INDEX; Schema: content; Owner: app
--

CREATE INDEX film_work_id_idx ON content.genre_film_work USING btree (film_work_id);


--
-- TOC entry 4714 (class 1259 OID 16895)
-- Name: film_work_person_idx; Type: INDEX; Schema: content; Owner: postgres
--

CREATE UNIQUE INDEX film_work_person_idx ON content.person_film_work USING btree (film_work_id, person_id);


--
-- TOC entry 4711 (class 1259 OID 25016)
-- Name: full_name_idx; Type: INDEX; Schema: content; Owner: app
--

CREATE INDEX full_name_idx ON content.person USING btree (full_name);


--
-- TOC entry 4710 (class 1259 OID 25018)
-- Name: genre_id_idx; Type: INDEX; Schema: content; Owner: app
--

CREATE INDEX genre_id_idx ON content.genre_film_work USING btree (genre_id);


--
-- TOC entry 4706 (class 1259 OID 25015)
-- Name: name_idx; Type: INDEX; Schema: content; Owner: app
--

CREATE UNIQUE INDEX name_idx ON content.genre USING btree (name);


--
-- TOC entry 4717 (class 1259 OID 25019)
-- Name: person_id_idx; Type: INDEX; Schema: content; Owner: postgres
--

CREATE INDEX person_id_idx ON content.person_film_work USING btree (person_id);


--
-- TOC entry 4703 (class 1259 OID 25014)
-- Name: title_creation_date_idx; Type: INDEX; Schema: content; Owner: app
--

CREATE UNIQUE INDEX title_creation_date_idx ON content.film_work USING btree (title, creation_date);


--
-- TOC entry 4718 (class 2606 OID 16835)
-- Name: genre_film_work genre_film_work_film_work_id_fkey; Type: FK CONSTRAINT; Schema: content; Owner: app
--

ALTER TABLE ONLY content.genre_film_work
    ADD CONSTRAINT genre_film_work_film_work_id_fkey FOREIGN KEY (film_work_id) REFERENCES content.film_work(id) ON DELETE CASCADE;


--
-- TOC entry 4719 (class 2606 OID 16840)
-- Name: genre_film_work genre_film_work_genre_id_fkey; Type: FK CONSTRAINT; Schema: content; Owner: app
--

ALTER TABLE ONLY content.genre_film_work
    ADD CONSTRAINT genre_film_work_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES content.film_work(id) ON DELETE CASCADE;


--
-- TOC entry 4720 (class 2606 OID 16878)
-- Name: person_film_work person_film_work_film_work_id_fkey; Type: FK CONSTRAINT; Schema: content; Owner: postgres
--

ALTER TABLE ONLY content.person_film_work
    ADD CONSTRAINT person_film_work_film_work_id_fkey FOREIGN KEY (film_work_id) REFERENCES content.film_work(id) ON DELETE CASCADE;


--
-- TOC entry 4721 (class 2606 OID 16873)
-- Name: person_film_work person_film_work_person_id_fkey; Type: FK CONSTRAINT; Schema: content; Owner: postgres
--

ALTER TABLE ONLY content.person_film_work
    ADD CONSTRAINT person_film_work_person_id_fkey FOREIGN KEY (person_id) REFERENCES content.person(id) ON DELETE CASCADE;


-- Completed on 2024-09-14 23:07:20

--
-- PostgreSQL database dump complete
--


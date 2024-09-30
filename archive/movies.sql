--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.0

-- Started on 2024-09-19 00:36:54

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
-- TOC entry 6 (class 2615 OID 33207)
-- Name: content; Type: SCHEMA; Schema: -; Owner: app
--

CREATE SCHEMA content;


ALTER SCHEMA content OWNER TO app;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 234 (class 1259 OID 33345)
-- Name: film_work; Type: TABLE; Schema: content; Owner: app
--

CREATE TABLE content.film_work (
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    certificate character varying(512) NOT NULL,
    file_path character varying(100) NOT NULL,
    title character varying(300) NOT NULL,
    description text NOT NULL,
    creation_date date NOT NULL,
    rating double precision NOT NULL,
    type character varying NOT NULL
);


ALTER TABLE content.film_work OWNER TO app;

--
-- TOC entry 235 (class 1259 OID 33352)
-- Name: genre; Type: TABLE; Schema: content; Owner: app
--

CREATE TABLE content.genre (
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL
);


ALTER TABLE content.genre OWNER TO app;

--
-- TOC entry 238 (class 1259 OID 33369)
-- Name: genre_film_work; Type: TABLE; Schema: content; Owner: app
--

CREATE TABLE content.genre_film_work (
    id uuid NOT NULL,
    created timestamp with time zone NOT NULL,
    film_work_id uuid NOT NULL,
    genre_id uuid NOT NULL
);


ALTER TABLE content.genre_film_work OWNER TO app;

--
-- TOC entry 236 (class 1259 OID 33359)
-- Name: person; Type: TABLE; Schema: content; Owner: app
--

CREATE TABLE content.person (
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    full_name character varying(200) NOT NULL
);


ALTER TABLE content.person OWNER TO app;

--
-- TOC entry 237 (class 1259 OID 33364)
-- Name: person_film_work; Type: TABLE; Schema: content; Owner: app
--

CREATE TABLE content.person_film_work (
    id uuid NOT NULL,
    role character varying(100),
    created timestamp with time zone NOT NULL,
    film_work_id_id uuid NOT NULL,
    person_id_id uuid NOT NULL
);


ALTER TABLE content.person_film_work OWNER TO app;

--
-- TOC entry 240 (class 1259 OID 33408)
-- Name: temp_table; Type: TABLE; Schema: content; Owner: postgres
--

CREATE TABLE content.temp_table (
    id uuid NOT NULL,
    name text
);


ALTER TABLE content.temp_table OWNER TO postgres;

--
-- TOC entry 4694 (class 2606 OID 33351)
-- Name: film_work film_work_pkey; Type: CONSTRAINT; Schema: content; Owner: app
--

ALTER TABLE ONLY content.film_work
    ADD CONSTRAINT film_work_pkey PRIMARY KEY (id);


--
-- TOC entry 4706 (class 2606 OID 33373)
-- Name: genre_film_work genre_film_work_pkey; Type: CONSTRAINT; Schema: content; Owner: app
--

ALTER TABLE ONLY content.genre_film_work
    ADD CONSTRAINT genre_film_work_pkey PRIMARY KEY (id);


--
-- TOC entry 4696 (class 2606 OID 33358)
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: content; Owner: app
--

ALTER TABLE ONLY content.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (id);


--
-- TOC entry 4702 (class 2606 OID 33368)
-- Name: person_film_work person_film_work_pkey; Type: CONSTRAINT; Schema: content; Owner: app
--

ALTER TABLE ONLY content.person_film_work
    ADD CONSTRAINT person_film_work_pkey PRIMARY KEY (id);


--
-- TOC entry 4698 (class 2606 OID 33363)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: content; Owner: app
--

ALTER TABLE ONLY content.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- TOC entry 4708 (class 2606 OID 33414)
-- Name: temp_table temp_table_pkey; Type: CONSTRAINT; Schema: content; Owner: postgres
--

ALTER TABLE ONLY content.temp_table
    ADD CONSTRAINT temp_table_pkey PRIMARY KEY (id);


--
-- TOC entry 4703 (class 1259 OID 33396)
-- Name: genre_film_work_film_work_id_65abe300; Type: INDEX; Schema: content; Owner: app
--

CREATE INDEX genre_film_work_film_work_id_65abe300 ON content.genre_film_work USING btree (film_work_id);


--
-- TOC entry 4704 (class 1259 OID 33397)
-- Name: genre_film_work_genre_id_88fbcf0d; Type: INDEX; Schema: content; Owner: app
--

CREATE INDEX genre_film_work_genre_id_88fbcf0d ON content.genre_film_work USING btree (genre_id);


--
-- TOC entry 4699 (class 1259 OID 33384)
-- Name: person_film_work_film_work_id_id_0bf9a19b; Type: INDEX; Schema: content; Owner: app
--

CREATE INDEX person_film_work_film_work_id_id_0bf9a19b ON content.person_film_work USING btree (film_work_id_id);


--
-- TOC entry 4700 (class 1259 OID 33385)
-- Name: person_film_work_person_id_id_33bd8260; Type: INDEX; Schema: content; Owner: app
--

CREATE INDEX person_film_work_person_id_id_33bd8260 ON content.person_film_work USING btree (person_id_id);


--
-- TOC entry 4711 (class 2606 OID 33386)
-- Name: genre_film_work genre_film_work_film_work_id_65abe300_fk_film_work_id; Type: FK CONSTRAINT; Schema: content; Owner: app
--

ALTER TABLE ONLY content.genre_film_work
    ADD CONSTRAINT genre_film_work_film_work_id_65abe300_fk_film_work_id FOREIGN KEY (film_work_id) REFERENCES content.film_work(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4712 (class 2606 OID 33391)
-- Name: genre_film_work genre_film_work_genre_id_88fbcf0d_fk_genre_id; Type: FK CONSTRAINT; Schema: content; Owner: app
--

ALTER TABLE ONLY content.genre_film_work
    ADD CONSTRAINT genre_film_work_genre_id_88fbcf0d_fk_genre_id FOREIGN KEY (genre_id) REFERENCES content.genre(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4709 (class 2606 OID 33374)
-- Name: person_film_work person_film_work_film_work_id_id_0bf9a19b_fk_film_work_id; Type: FK CONSTRAINT; Schema: content; Owner: app
--

ALTER TABLE ONLY content.person_film_work
    ADD CONSTRAINT person_film_work_film_work_id_id_0bf9a19b_fk_film_work_id FOREIGN KEY (film_work_id_id) REFERENCES content.film_work(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4710 (class 2606 OID 33379)
-- Name: person_film_work person_film_work_person_id_id_33bd8260_fk_person_id; Type: FK CONSTRAINT; Schema: content; Owner: app
--

ALTER TABLE ONLY content.person_film_work
    ADD CONSTRAINT person_film_work_person_id_id_33bd8260_fk_person_id FOREIGN KEY (person_id_id) REFERENCES content.person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4861 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE temp_table; Type: ACL; Schema: content; Owner: postgres
--

GRANT ALL ON TABLE content.temp_table TO app;


-- Completed on 2024-09-19 00:36:54

--
-- PostgreSQL database dump complete
--


--  Эти параметры автоматически сгенерированы pg_dump и нужны для корректного выполнения операций восстановления
-- Их не рекомендуется удалять, так как они обеспечивают необходимое поведение при импорте данных. 
-- При необходимости их можно заменить

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

-- Эти параметры установлены автоматически pg_dump для обеспечения стандартного поведения при создании таблиц и индексов
-- и для гарантии того, что данные будут восстановлены предскауемо  независимо от конфигурации сервера.
SET default_tablespace = '';
SET default_table_access_method = heap;

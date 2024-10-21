-- Drop and recreate the database
DROP DATABASE IF EXISTS periodic_table;
CREATE DATABASE periodic_table WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';

\connect periodic_table;

-- Create the elements table
CREATE TABLE public.elements (
    atomic_number integer NOT NULL PRIMARY KEY,
    symbol character varying(2) NOT NULL UNIQUE,
    name character varying(40) NOT NULL UNIQUE
);

-- Create the types table
CREATE TABLE public.types (
    type_id integer NOT NULL PRIMARY KEY,
    type character varying(30) NOT NULL
);

-- Create the properties table with foreign key constraints
CREATE TABLE public.properties (
    atomic_number integer NOT NULL,
    atomic_mass numeric(9, 6) NOT NULL,
    melting_point_celsius numeric NOT NULL,
    boiling_point_celsius numeric NOT NULL,
    type_id integer NOT NULL,
    PRIMARY KEY (atomic_number),
    CONSTRAINT fk_atomic_number FOREIGN KEY (atomic_number) REFERENCES public.elements(atomic_number),
    CONSTRAINT fk_type_id FOREIGN KEY (type_id) REFERENCES public.types(type_id)
);

-- Insert values into the elements table
INSERT INTO public.elements (atomic_number, symbol, name) VALUES
(1, 'H', 'Hydrogen'),
(2, 'He', 'Helium'),
(3, 'Li', 'Lithium'),
(4, 'Be', 'Beryllium'),
(5, 'B', 'Boron'),
(6, 'C', 'Carbon'),
(7, 'N', 'Nitrogen'),
(8, 'O', 'Oxygen'),
(9, 'F', 'Fluorine'),
(10, 'Ne', 'Neon');

-- Insert values into the types table
INSERT INTO public.types (type_id, type) VALUES
(0, 'metal'),
(1, 'nonmetal'),
(2, 'metalloid');

-- Insert values into the properties table
INSERT INTO public.properties (atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES
(1, 1.008, -259.1, -252.9, 1),
(2, 4.0026, -272.2, -269, 1),
(3, 6.94, 180.54, 1342, 0),
(4, 9.0122, 1287, 2470, 0),
(5, 10.81, 2075, 4000, 2),
(6, 12.011, 3550, 4027, 1),
(7, 14.007, -210.1, -195.8, 1),
(8, 15.999, -218, -183, 1),
(9, 18.998, -220, -188.1, 1),
(10, 20.18, -248.6, -246.1, 1);

-- Ensure that proper constraints are enforced
ALTER TABLE ONLY public.elements
    ADD CONSTRAINT elements_atomic_number_key UNIQUE (atomic_number);

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT name_unique UNIQUE (name);

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT symbol_unique UNIQUE (symbol);

-- Ensure the foreign key relationships are set up correctly
ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_atomic_number_fkey FOREIGN KEY (atomic_number) REFERENCES public.elements(atomic_number);

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.types(type_id);

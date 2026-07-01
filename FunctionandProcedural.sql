CREATE TABLE student(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    mark1 INT,
    mark2 INT,
    mark3 INT
);

INSERT INTO student(name, mark1, mark2, mark3)
VALUES
('Jeyanthi',60,55,50),
('Aarthi',40,45,35),
('Priya',80,70,65);

CREATE OR REPLACE FUNCTION calculate_total(
    m1 INT,
    m2 INT,
    m3 INT
)
RETURNS INT
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN m1 + m2 + m3;
END;
$$;

CREATE OR REPLACE PROCEDURE student_result(
    m1 INT,
    m2 INT,
    m3 INT
)
LANGUAGE plpgsql
AS
$$
DECLARE
    total INT;
BEGIN

    total := calculate_total(m1,m2,m3);

    RAISE NOTICE 'Total Marks = %', total;

    IF total >= 150 THEN
        RAISE NOTICE 'Result = PASS';
    ELSE
        RAISE NOTICE 'Result = FAIL';
    END IF;

END;
$$;

CALL student_result(60,55,50);

CALL student_result(40,45,35);

CALL student_result(80,70,65);





CREATE OR REPLACE FUNCTION calculate_si(
    p NUMERIC,
    r NUMERIC,
    t NUMERIC
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN (p * r * t) / 100;
END;
$$;

CREATE OR REPLACE PROCEDURE display_interest(
    p NUMERIC,
    r NUMERIC,
    t NUMERIC
)
LANGUAGE plpgsql
AS
$$
DECLARE
    si NUMERIC;
    total NUMERIC;
BEGIN

    si := calculate_si(p, r, t);

    total := p + si;

    RAISE NOTICE 'Principal Amount : %', p;
    RAISE NOTICE 'Simple Interest  : %', si;
    RAISE NOTICE 'Total Amount     : %', total;

END;
$$;

CALL display_interest(10000, 5, 2);

CALL display_interest(20000, 10, 3);
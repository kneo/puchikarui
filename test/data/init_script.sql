DROP TABLE IF EXISTS person;

CREATE TABLE person (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER
);

CREATE TABLE school (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    address TEXT
);

CREATE TABLE hobby (
    pid INTEGER NOT NULL,
    hobby TEXT,
    FOREIGN KEY (pid) REFERENCES person (ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE diary (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    pid INTEGER NOT NULL,
    text TEXT,
    FOREIGN KEY (pid) REFERENCES person (ID) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO
    person (name, age)
VALUES
    ('Ji', 28),
    ('Zen', 25),
    ('Ka', 32),
    ('Anh', 15),
    ('kneo', 40),
    ('Vi', 33);

INSERT INTO
    hobby
VALUES
    (
        (
            SELECT
                ID
            from
                person
            WHERE
                name = 'Anh'
        ),
        'coding'
    );

INSERT INTO
    hobby
VALUES
    (
        (
            SELECT
                ID
            from
                person
            WHERE
                name = 'kneo'
        ),
        'linguistics'
    );

CREATE UNIQUE INDEX hobby_hobby ON hobby (hobby);

CREATE VIEW IF NOT EXISTS person_hobby_view AS
SELECT
    person.name AS pname,
    person.age AS page,
    hobby.hobby AS phobby
FROM
    person
    LEFT JOIN hobby ON hobby.pid = person.ID;

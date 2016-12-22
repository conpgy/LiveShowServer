DROP TABLE IF EXISTS tbl_access_statistic;
DROP TABLE IF EXISTS tbl_anchor;
DROP TABLE IF EXISTS tbl_live_url;
DROP TABLE IF EXISTS tbl_user;

CREATE TABLE tbl_access_statistic (
    id          SERIAL PRIMARY KEY,
    pv          INTEGER NOT NULL,
    created     TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0)
);

CREATE TABLE tbl_user (
    id          SERIAL PRIMARY KEY,
    nickname    TEXT NOT NULL,
    email       TEXT NOT NULL,
    password    TEXT NOT NULL,
    mobile      TEXT,
    gender      SMALLINT NOT NULL,
    city        TEXT,
    created     TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0)
);

CREATE TABLE tbl_anchor (
    id          SERIAL PRIMARY KEY,
    uid         INTEGER NOT NULL REFERENCES tbl_user,
    name        TEXT NOT NULL,
    is_live     SMALLINT NOT NULL,
    focus       INTEGER NOT NULL,
    push        SMALLINT NOT NULL,
    room_id     INTEGER NOT NULL,
    type        SMALLINT NOT NULL,
    pic51       TEXT,
    pic74       TEXT,
    created     TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0),
    modified    TIMESTAMP NOT NULL
);

CREATE TABLE tbl_live_url (
    id          SERIAL PRIMARY KEY,
    room_id     INTEGER NOT NULL,
    url         TEXT NOT NULL,
    created     TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0)
);

INSERT INTO tbl_access_statistic (pv) VALUES (0);

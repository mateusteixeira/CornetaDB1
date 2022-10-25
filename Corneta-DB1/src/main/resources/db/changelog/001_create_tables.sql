--liquibase formatted sql

--changeset 001:1
CREATE TABLE IF NOT EXISTS TEAM (
  ID NUMERIC(18) NOT NULL,
  NAME VARCHAR(100) NOT NULL,
  INITIALS VARCHAR(20) NOT NULL,
  GROUPS VARCHAR(5) NOT NULL,
  FLAG VARCHAR(10) NOT NULL
  PRIMARY KEY (ID)
);

--changeset 001:2
CREATE TABLE IF NOT EXISTS ROUND (
  ID NUMERIC(18) NOT NULL,
  NAME VARCHAR(100) NOT NULL,
  INITIAL_DATE DATE NOT NULL,
  END_DATE DATE NOT NULL,
  PRIMARY KEY (ID)
);

--changeset 001:3
CREATE TABLE IF NOT EXISTS MATCHES (
  ID NUMERIC(18) NOT NULL,
  ID_HOME_TEAM NUMERIC(18) NOT NULL,
  ID_VISITING_TEAM NUMERIC(18) NOT NULL,
  ID_ROUND NUMERIC(18) NOT NULL,
  GAME_DATE DATE NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (ID_HOME_TEAM) REFERENCES TEAM (ID),
  FOREIGN KEY (ID_VISITING_TEAM) REFERENCES TEAM (ID),
  FOREIGN KEY (ID_ROUND) REFERENCES ROUND (ID)
);

--changeset 001:4
CREATE TABLE IF NOT EXISTS BET (
  ID NUMERIC(18) NOT NULL,
  contract_hash_code VARCHAR(1000) NOT NULL,
  ID_MATCH NUMERIC(18) NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (ID_MATCH) REFERENCES MATCHES (ID)
);

--changeset 001:5
CREATE TABLE IF NOT EXISTS "user" (
  ID NUMERIC(18) NOT NULL,
  NAME VARCHAR(256) NOT NULL,
  LAST_NAME VARCHAR(256) NOT NULL,
  NICK_NAME VARCHAR(256) NOT NULL,
  EMAIL VARCHAR(256) NOT NULL,
  BLOCK_CHAIN_CODE VARCHAR(1000) NOT NULL,
  ROLE VARCHAR(50) VARCHAR NOT NULL,
  PRIMARY KEY (ID)
);

--changeset 001:6
CREATE TABLE IF NOT EXISTS USER_BET (
  ID NUMERIC(18) NOT NULL,
  ID_USER NUMERIC(18) NOT NULL,
  ID_BET NUMERIC(18) NOT NULL,
  GUESS_HOME_TEAM NUMERIC(6) NOT NULL,
  GUESS_VISITING_TEAM NUMERIC(6) NOT NULL,
  BET_MADE boolean NOT NULL,
  BET_DATE DATE NOT NULL,
  BET_MADE_DATE DATE NOT NULL,
  DISCOUNT_FROM_WALLET boolean NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (ID_USER) REFERENCES "user" (ID),
  FOREIGN KEY (ID_BET) REFERENCES BET (ID)
);

--changeset 001:7
CREATE SEQUENCE IF NOT EXISTS BET_SEQ INCREMENT BY 1 OWNED BY BET.ID

--changeset 001:8
CREATE SEQUENCE IF NOT EXISTS MATCHES_SEQ INCREMENT BY 1 OWNED BY MATCHES.ID

--changeset 001:9
CREATE SEQUENCE IF NOT EXISTS USER_SEQ INCREMENT BY 1 OWNED BY "user".ID

--changeset 001:10
CREATE SEQUENCE IF NOT EXISTS USER_BET_SEQ INCREMENT BY 1 OWNED BY USER_BET.ID

--changeset 001:11
CREATE SEQUENCE IF NOT EXISTS TEAM_SEQ INCREMENT BY 1 OWNED BY TEAM.ID

--changeset 001:12
CREATE SEQUENCE IF NOT EXISTS ROUND_SEQ INCREMENT BY 1 OWNED BY ROUND.ID

--changeset 001:13
INSERT INTO "user" (ID, NAME, LAST_NAME, NICK_NAME, EMAIL, BLOCK_CHAIN_CODE, ROLE) VALUES (1, 'Mateus', 'Teixeira', 'mateus.teixeira', 'mateus.teixeira@db1.com.br', 'mateus.teixeira', 'ROLE_ADMIN');
--changeset 001:14
INSERT INTO "user" (ID, NAME, LAST_NAME, NICK_NAME, EMAIL, BLOCK_CHAIN_CODE, ROLE) VALUES (1, 'Narayane', 'Luvizutto', 'narayane.teixeira', 'narayane.teixeira@db1.com.br', 'narayane.teixeira', 'ROLE_ADMIN');
INSERT INTO "user" (ID, NAME, LAST_NAME, NICK_NAME, EMAIL, BLOCK_CHAIN_CODE, ROLE) VALUES (1, 'Cleber', 'Dorneles', 'cleber.dorneles', 'cleber.dorneles@db1.com.br', 'cleber.dorneles', 'ROLE_ADMIN');
INSERT INTO "user" (ID, NAME, LAST_NAME, NICK_NAME, EMAIL, BLOCK_CHAIN_CODE, ROLE) VALUES (1, 'Lucas', 'Farias', 'lucas.farias', 'lucas.farias@db1.com.br', 'lucas.farias', 'ROLE_ADMIN');
INSERT INTO "user" (ID, NAME, LAST_NAME, NICK_NAME, EMAIL, BLOCK_CHAIN_CODE, ROLE) VALUES (1, 'Ricardo', 'Silva', 'ricardo.silva', 'ricardo.silva@db1.com.br', 'ricardo.silva', 'ROLE_ADMIN');

INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (1, 'Catar', 'CAT', 'qa', 'A');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (2, 'Equador', 'EQU', 'ec', 'A');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (3, 'Holanda', 'HOL', 'nl', 'A');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (4, 'Senegal', 'SEN', 'sn', 'A');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (5, 'Estados Unidos', 'EUA', 'us', 'B');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (6, 'Inglaterra', 'ING', 'gb eng', 'B');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (7, 'Irã', 'IRA', 'ir', 'B');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (8, 'País de Gales', 'GAL', 'gb wls', 'B');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (9, 'Argentina', 'ARG', 'ar', 'C');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (10, 'Arábia Saudita', 'ARA', 'sa', 'C');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (11, 'México', 'MEX', 'mx', 'C');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (12, 'Polônia', 'POL', 'pl', 'C');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (13, 'Austrália', 'AUS', 'au', 'D');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (14, 'Dinamarca', 'DIN', 'dk', 'D');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (15, 'França', 'FRA', 'fr', 'D');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (16, 'Tunísia', 'TUN', 'tn', 'D');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (17, 'Alemanha', 'ALE', 'de', 'E');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (18, 'Costa Rica', 'CRC', 'cr', 'E');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (19, 'Espanha', 'ESP', 'es', 'E');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (20, 'Japão', 'JAP', 'jp', 'E');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (21, 'Bélgica', 'BEL', 'be', 'F');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (22, 'Canadá', 'CAN', 'ca', 'F');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (23, 'Croácia', 'CRO', 'hr', 'F');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (24, 'Marrocos', 'MAR', 'ma', 'F');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (25, 'Brasil', 'BRA', 'br', 'G');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (26, 'Camarões', 'CAM', 'cm', 'G');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (27, 'Suíça', 'SUI', 'ch', 'G');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (28, 'Sérvia', 'SER', 'rs', 'G');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (29, 'Coreia do Sul', 'COR', 'kr', 'H');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (30, 'Gana', 'GAN', 'gh', 'H');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (31, 'Portugal', 'POR', 'pt', 'H');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUP) VALUES (32, 'Uruguai', 'URU', 'uy', 'H');

INSERT INTO ROUND (ID, NAME, INITIAL_DATE, END_DATE) VALUES (1, 'Grupos 1', to_date('YYYY/MM/dd HH:mm:ss', 2022/11/20 00:00:00), to_date('YYYY/MM/dd HH:mm:ss', 2022/11/24 00:00:00);
INSERT INTO ROUND (ID, NAME, INITIAL_DATE, END_DATE) VALUES (2, 'Grupos 2', to_date('YYYY/MM/dd HH:mm:ss', 2022/11/25 00:00:00), to_date('YYYY/MM/dd HH:mm:ss', 2022/11/28 00:00:00);
INSERT INTO ROUND (ID, NAME, INITIAL_DATE, END_DATE) VALUES (3, 'Grupos 3', to_date('YYYY/MM/dd HH:mm:ss', 2022/11/29 00:00:00), to_date('YYYY/MM/dd HH:mm:ss', 2022/12/02 00:00:00);
INSERT INTO ROUND (ID, NAME, INITIAL_DATE, END_DATE) VALUES (4, 'Oitavas', to_date('YYYY/MM/dd HH:mm:ss', 2022/12/03 00:00:00), to_date('YYYY/MM/dd HH:mm:ss', 2022/12/06 00:00:00);
INSERT INTO ROUND (ID, NAME, INITIAL_DATE, END_DATE) VALUES (5, 'Quartas', to_date('YYYY/MM/dd HH:mm:ss', 2022/12/09 00:00:00), to_date('YYYY/MM/dd HH:mm:ss', 2022/12/10 00:00:00);
INSERT INTO ROUND (ID, NAME, INITIAL_DATE, END_DATE) VALUES (6, 'Semifinal', to_date('YYYY/MM/dd HH:mm:ss', 2022/12/13 00:00:00), to_date('YYYY/MM/dd HH:mm:ss', 2022/12/14 00:00:00);
INSERT INTO ROUND (ID, NAME, INITIAL_DATE, END_DATE) VALUES (7, 'Final', to_date('YYYY/MM/dd HH:mm:ss', 2022/12/17 00:00:00), to_date('YYYY/MM/dd HH:mm:ss', 2022/12/18 00:00:00);



INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (1, 1, 2, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/20 00:00:00), 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (2, 4, 3, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/21 00:00:00), 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (3, 6, 7, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/21 00:00:00), 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (4, 5, 8, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/21 00:00:00), 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (5, 9, 10, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/22 00:00:00), 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (6, 14, 16, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/22 00:00:00), 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (7, 11, 12, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/22 00:00:00), 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (8, 15, 13, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/22 00:00:00), 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (9, 24, 23, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/23 00:00:00), 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (10, 17, 20, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/23 00:00:00), 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (11, 19, 18, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/23 00:00:00), 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (12, 21, 22, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/23 00:00:00), 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (13, 27, 26, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/24 00:00:00), 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (14, 32, 29, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/24 00:00:00), 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (15, 31, 30, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/24 00:00:00), 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (16, 25, 28, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/24 00:00:00), 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (17, 8, 7, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/25 00:00:00), 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (18, 1, 4, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/25 00:00:00), 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (19, 3, 2, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/25 00:00:00), 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (20, 6, 5, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/25 00:00:00), 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (21, 16, 13, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/26 00:00:00), 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (22, 12, 10, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/26 00:00:00), 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (23, 15, 14, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/26 00:00:00), 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (24, 9, 11, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/26 00:00:00), 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (25, 20, 18, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/27 00:00:00), 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (26, 21, 24, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/27 00:00:00), 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (27, 23, 22, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/27 00:00:00), 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (28, 19, 17, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/27 00:00:00), 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (29, 26, 28, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/28 00:00:00), 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (30, 29, 30, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/28 00:00:00), 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (31, 25, 27, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/28 00:00:00), 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (32, 31, 32, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/28 00:00:00), 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (33, 2, 4, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/29 00:00:00), 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (34, 3, 1, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/29 00:00:00), 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (35, 8, 6, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/29 00:00:00), 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (36, 7, 5, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/29 00:00:00), 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (37, 13, 14, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/30 00:00:00), 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (38, 16, 15, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/30 00:00:00), 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (39, 12, 9, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/30 00:00:00), 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (40, 10, 11, to_date('YYYY/MM/dd HH:mm:ss', 2022/11/30 00:00:00), 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (41, 23, 21, to_date('YYYY/MM/dd HH:mm:ss', 2022/12/01 00:00:00), 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (42, 22, 24, to_date('YYYY/MM/dd HH:mm:ss', 2022/12/01 00:00:00), 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (43, 20, 19, to_date('YYYY/MM/dd HH:mm:ss', 2022/12/01 00:00:00), 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (44, 18, 17, to_date('YYYY/MM/dd HH:mm:ss', 2022/12/01 00:00:00), 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (45, 30, 32, to_date('YYYY/MM/dd HH:mm:ss', 2022/12/02 00:00:00), 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (46, 29, 31, to_date('YYYY/MM/dd HH:mm:ss', 2022/12/02 00:00:00), 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (47, 28, 27, to_date('YYYY/MM/dd HH:mm:ss', 2022/12/02 00:00:00), 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (48, 26, 25, to_date('YYYY/MM/dd HH:mm:ss', 2022/12/02 00:00:00), 3);

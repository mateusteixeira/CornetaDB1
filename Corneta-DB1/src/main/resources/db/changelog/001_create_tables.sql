--liquibase formatted sql

--changeset 001:1
CREATE TABLE IF NOT EXISTS TEAM (ID NUMERIC(18) NOT NULL, NAME VARCHAR(100) NOT NULL, INITIALS VARCHAR(20) NOT NULL, GROUPS VARCHAR(5) NOT NULL, FLAG VARCHAR(10) NOT NULL, PRIMARY KEY (ID));

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
  ROLE VARCHAR(50) NOT NULL,
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
INSERT INTO "user" (ID, NAME, LAST_NAME, NICK_NAME, EMAIL, BLOCK_CHAIN_CODE, ROLE) VALUES (nextval('user_seq'), 'Mateus', 'Teixeira', 'mateus.teixeira', 'mateus.teixeira@db1.com.br', 'mateus.teixeira', 'ROLE_ADMIN');
INSERT INTO "user" (ID, NAME, LAST_NAME, NICK_NAME, EMAIL, BLOCK_CHAIN_CODE, ROLE) VALUES (nextval('user_seq'), 'Narayane', 'Luvizutto', 'narayane.teixeira', 'narayane.teixeira@db1.com.br', 'narayane.teixeira', 'ROLE_ADMIN');
INSERT INTO "user" (ID, NAME, LAST_NAME, NICK_NAME, EMAIL, BLOCK_CHAIN_CODE, ROLE) VALUES (nextval('user_seq'), 'Cleber', 'Dorneles', 'cleber.dorneles', 'cleber.dorneles@db1.com.br', 'cleber.dorneles', 'ROLE_ADMIN');
INSERT INTO "user" (ID, NAME, LAST_NAME, NICK_NAME, EMAIL, BLOCK_CHAIN_CODE, ROLE) VALUES (nextval('user_seq'), 'Lucas', 'Farias', 'lucas.farias', 'lucas.farias@db1.com.br', 'lucas.farias', 'ROLE_ADMIN');
INSERT INTO "user" (ID, NAME, LAST_NAME, NICK_NAME, EMAIL, BLOCK_CHAIN_CODE, ROLE) VALUES (nextval('user_seq'), 'Ricardo', 'Silva', 'ricardo.silva', 'ricardo.silva@db1.com.br', 'ricardo.silva', 'ROLE_ADMIN');

--changeset 001:14
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (1, 'Catar', 'CAT', 'qa', 'A');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (2, 'Equador', 'EQU', 'ec', 'A');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (3, 'Holanda', 'HOL', 'nl', 'A');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (4, 'Senegal', 'SEN', 'sn', 'A');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (5, 'Estados Unidos', 'EUA', 'us', 'B');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (6, 'Inglaterra', 'ING', 'gb eng', 'B');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (7, 'Ir??', 'IRA', 'ir', 'B');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (8, 'Pa??s de Gales', 'GAL', 'gb wls', 'B');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (9, 'Argentina', 'ARG', 'ar', 'C');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (10, 'Ar??bia Saudita', 'ARA', 'sa', 'C');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (11, 'M??xico', 'MEX', 'mx', 'C');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (12, 'Pol??nia', 'POL', 'pl', 'C');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (13, 'Austr??lia', 'AUS', 'au', 'D');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (14, 'Dinamarca', 'DIN', 'dk', 'D');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (15, 'Fran??a', 'FRA', 'fr', 'D');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (16, 'Tun??sia', 'TUN', 'tn', 'D');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (17, 'Alemanha', 'ALE', 'de', 'E');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (18, 'Costa Rica', 'CRC', 'cr', 'E');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (19, 'Espanha', 'ESP', 'es', 'E');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (20, 'Jap??o', 'JAP', 'jp', 'E');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (21, 'B??lgica', 'BEL', 'be', 'F');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (22, 'Canad??', 'CAN', 'ca', 'F');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (23, 'Cro??cia', 'CRO', 'hr', 'F');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (24, 'Marrocos', 'MAR', 'ma', 'F');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (25, 'Brasil', 'BRA', 'br', 'G');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (26, 'Camar??es', 'CAM', 'cm', 'G');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (27, 'Su????a', 'SUI', 'ch', 'G');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (28, 'S??rvia', 'SER', 'rs', 'G');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (29, 'Coreia do Sul', 'COR', 'kr', 'H');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (30, 'Gana', 'GAN', 'gh', 'H');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (31, 'Portugal', 'POR', 'pt', 'H');
INSERT INTO TEAM (ID, NAME, INITIALS, FLAG, GROUPS) VALUES (32, 'Uruguai', 'URU', 'uy', 'H');

--changeset 001:15
INSERT INTO ROUND (ID, NAME, INITIAL_DATE, END_DATE) VALUES (1, 'Grupos 1', '2022/11/20', '2022/11/24');
INSERT INTO ROUND (ID, NAME, INITIAL_DATE, END_DATE) VALUES (2, 'Grupos 2', '2022/11/25', '2022/11/28');
INSERT INTO ROUND (ID, NAME, INITIAL_DATE, END_DATE) VALUES (3, 'Grupos 3', '2022/11/29', '2022/12/02');
INSERT INTO ROUND (ID, NAME, INITIAL_DATE, END_DATE) VALUES (4, 'Oitavas', '2022/12/03', '2022/12/06');
INSERT INTO ROUND (ID, NAME, INITIAL_DATE, END_DATE) VALUES (5, 'Quartas', '2022/12/09', '2022/12/10');
INSERT INTO ROUND (ID, NAME, INITIAL_DATE, END_DATE) VALUES (6, 'Semifinal', '2022/12/13', '2022/12/14');
INSERT INTO ROUND (ID, NAME, INITIAL_DATE, END_DATE) VALUES (7, 'Final', '2022/12/17', '2022/12/18');

--changeset 001:16
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (1, 1, 2, '2022/11/20', 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (2, 4, 3, '2022/11/21', 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (3, 6, 7, '2022/11/21', 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (4, 5, 8, '2022/11/21', 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (5, 9, 10, '2022/11/22', 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (6, 14, 16, '2022/11/22', 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (7, 11, 12, '2022/11/22', 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (8, 15, 13, '2022/11/22', 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (9, 24, 23, '2022/11/23', 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (10, 17, 20, '2022/11/23', 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (11, 19, 18, '2022/11/23', 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (12, 21, 22, '2022/11/23', 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (13, 27, 26, '2022/11/24', 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (14, 32, 29, '2022/11/24', 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (15, 31, 30, '2022/11/24', 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (16, 25, 28, '2022/11/24', 1);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (17, 8, 7, '2022/11/25', 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (18, 1, 4, '2022/11/25', 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (19, 3, 2, '2022/11/25', 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (20, 6, 5, '2022/11/25', 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (21, 16, 13, '2022/11/26', 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (22, 12, 10, '2022/11/26', 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (23, 15, 14, '2022/11/26', 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (24, 9, 11, '2022/11/26', 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (25, 20, 18, '2022/11/27', 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (26, 21, 24, '2022/11/27', 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (27, 23, 22, '2022/11/27', 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (28, 19, 17, '2022/11/27', 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (29, 26, 28, '2022/11/28', 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (30, 29, 30, '2022/11/28', 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (31, 25, 27, '2022/11/28', 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (32, 31, 32, '2022/11/28', 2);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (33, 2, 4, '2022/11/29', 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (34, 3, 1, '2022/11/29', 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (35, 8, 6, '2022/11/29', 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (36, 7, 5, '2022/11/29', 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (37, 13, 14, '2022/11/30', 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (38, 16, 15, '2022/11/30', 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (39, 12, 9, '2022/11/30', 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (40, 10, 11, '2022/11/30', 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (41, 23, 21, '2022/12/01', 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (42, 22, 24, '2022/12/01', 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (43, 20, 19, '2022/12/01', 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (44, 18, 17, '2022/12/01', 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (45, 30, 32, '2022/12/02', 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (46, 29, 31, '2022/12/02', 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (47, 28, 27, '2022/12/02', 3);
INSERT INTO MATCHES (ID, ID_HOME_TEAM, ID_VISITING_TEAM, GAME_DATE, ID_ROUND) VALUES (48, 26, 25, '2022/12/02', 3);

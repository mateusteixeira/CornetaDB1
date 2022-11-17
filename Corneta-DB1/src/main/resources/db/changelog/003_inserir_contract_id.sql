--liquibase formatted sql

--changeset 003:1
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (1, 1, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom01');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (3, 3, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom03');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (5, 5, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom05');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (8, 8, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom08');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (9, 9, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom09');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (10, 10, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom10');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (15, 15, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom15');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (16, 16, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom16');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (18, 18, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom18');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (20, 20, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom20');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (23, 23, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom23');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (24, 24, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom24');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (26, 26, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom26');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (28, 28, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom28');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (31, 31, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom31');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (32, 32, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom32');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (33, 33, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom33');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (36, 36, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom36');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (38, 38, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom38');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (39, 39, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom39');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (41, 41, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom41');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (43, 43, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom43');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (46, 46, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom46');
INSERT INTO BET (ID, ID_MATCH, CONTRACT_HASH_CODE) VALUES (48, 48, 'ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.corneta-hom48');

--changeset 003:2
ALTER TABLE "user" ALTER COLUMN LAST_NAME DROP NOT NULL;
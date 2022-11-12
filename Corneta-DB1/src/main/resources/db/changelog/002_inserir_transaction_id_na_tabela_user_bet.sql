--liquibase formatted sql

--changeset 002:1
ALTER TABLE user_bet ADD COLUMN transaction_id VARCHAR(256);
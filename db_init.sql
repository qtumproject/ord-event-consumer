

CREATE TABLE IF not exists ord_transfers (
                                             id BIGINT NOT NULL AUTO_INCREMENT,
                                             inscription_id TEXT NOT NULL,
                                             block_height INT NOT NULL,
                                             old_satpoint TEXT,
                                             new_satpoint TEXT NOT NULL,
                                             new_pkscript TEXT NOT NULL,
                                             new_wallet TEXT,
                                             sent_as_fee BOOLEAN NOT NULL,
                                             new_output_value BIGINT NOT NULL,
                                             PRIMARY KEY (id)
    );
CREATE INDEX ord_transfers_block_height_idx ON ord_transfers (block_height);
CREATE INDEX ord_transfers_inscription_id_idx ON ord_transfers (inscription_id(255));

CREATE TABLE ord_number_to_id (
                                  id BIGINT NOT NULL AUTO_INCREMENT,
                                  inscription_number BIGINT NOT NULL,
                                  inscription_id TEXT NOT NULL,
                                  cursed_for_brc20 BOOLEAN NOT NULL,
                                  block_height INT NOT NULL,
                                  PRIMARY KEY (id)
);
CREATE INDEX ord_number_to_id_block_height_idx ON ord_number_to_id (block_height);
CREATE UNIQUE INDEX ord_number_to_id_inscription_id_idx ON ord_number_to_id (inscription_id(255));
CREATE UNIQUE INDEX ord_number_to_id_inscription_number_idx ON ord_number_to_id (inscription_number);

CREATE TABLE ord_content (
                             id BIGINT NOT NULL AUTO_INCREMENT,
                             inscription_id TEXT NOT NULL,
                             content JSON,
                             text_content TEXT,
                             content_type TEXT NOT NULL,
                             metaprotocol TEXT,
                             block_height INT NOT NULL,
                             PRIMARY KEY (id)
);
CREATE INDEX ord_content_block_height_idx ON ord_content (block_height);
CREATE UNIQUE INDEX ord_content_inscription_id_idx ON ord_content (inscription_id(255));

CREATE TABLE block_hashes (
                              id BIGINT NOT NULL AUTO_INCREMENT,
                              block_height INT NOT NULL,
                              block_hash TEXT NOT NULL,
                              PRIMARY KEY (id)
);
CREATE UNIQUE INDEX block_hashes_block_height_idx ON block_hashes (block_height);

CREATE TABLE ord_indexer_reorg_stats (
                                         id BIGINT NOT NULL AUTO_INCREMENT,
                                         reorg_tm BIGINT NOT NULL,
                                         old_block_height INT NOT NULL,
                                         new_block_height INT NOT NULL,
                                         PRIMARY KEY (id)
);

CREATE TABLE ord_indexer_work_stats (
                                        id BIGINT NOT NULL AUTO_INCREMENT,
                                        main_min_block_height INT,
                                        main_max_block_height INT,
                                        ord_sql_query_count INT,
                                        new_inscription_count INT,
                                        transfer_count INT,
                                        ord_index_tm INT,
                                        ord_sql_tm INT,
                                        update_log_tm INT,
                                        all_tm INT,
                                        ts TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                        PRIMARY KEY (id)
);

CREATE TABLE ord_network_type (
                                  id BIGINT NOT NULL AUTO_INCREMENT,
                                  network_type TEXT NOT NULL,
                                  PRIMARY KEY (id)
);

CREATE TABLE ord_indexer_version (
                                     id BIGINT NOT NULL AUTO_INCREMENT,
                                     indexer_version TEXT NOT NULL,
                                     db_version INT NOT NULL,
                                     PRIMARY KEY (id)
);
INSERT INTO ord_indexer_version (indexer_version, db_version) VALUES ('OPI V0.3.1', 4);

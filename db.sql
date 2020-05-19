CREATE TABLE `user`
(
    `id`            INT(11)  NOT NULL AUTO_INCREMENT,
    `email`         TEXT     NOT NULL,
    `password`      TEXT     NOT NULL,
    `reg_date`      DATETIME NOT NULL,
    `last_active`   DATETIME NOT NULL,
    `name`          TEXT     NOT NULL,
    `last_name`     TEXT     NOT NULL,
    `patronym_name` TEXT,
    `birthday`      DATE,
    `bio`           TEXT,
    `avatar_path`   TEXT,
    `viewing_count` INT(11)  NOT NULL DEFAULT '0',
    `role`          ENUM(''),
    `phone`         varchar(11),
    `skype`         varchar(255),
    `telegram`      varchar(255),
    `user_status`   ENUM(''),
    PRIMARY KEY (`id`)
);

CREATE TABLE `task`
(
    `id`              INT(11)  NOT NULL AUTO_INCREMENT,
    `publish_date`    DATETIME NOT NULL,
    `status_id`       ENUM(''),
    `title`           TEXT     NOT NULL,
    `description`     TEXT     NOT NULL,
    `budget`          INT(11),
    `customer_id`     INT(11)  NOT NULL,
    `category_id`     INT(11)  NOT NULL,
    `latitude`        FLOAT,
    `longitude`       FLOAT,
    `city_id`         INT(11),
    `enforcer_id`     INT(11),
    `additional_text` TEXT,
    `messages`        INT      NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `task_category`
(
    `id`   INT(11)      NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `city`
(
    `id`        INT(11)      NOT NULL AUTO_INCREMENT,
    `name`      varchar(255) NOT NULL,
    `latitude`  FLOAT        NOT NULL,
    `longitude` FLOAT        NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `task_response`
(
    `id`          INT(11) NOT NULL AUTO_INCREMENT,
    `task_id`     INT(11) NOT NULL,
    `enfoncer_id` INT(11) NOT NULL,
    `price`       INT(11) NOT NULL,
    `comment`     TEXT,
    PRIMARY KEY (`id`)
);

CREATE TABLE `user_review`
(
    `id`          INT(11) NOT NULL AUTO_INCREMENT,
    `user_id`     INT(11) NOT NULL,
    `task_id`     INT(11) NOT NULL,
    `reviewer_id` INT(11) NOT NULL,
    `message`     TEXT    NOT NULL,
    `rating`      INT(1)  NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `photo`
(
    `id`      INT(11)      NOT NULL AUTO_INCREMENT,
    `path`    varchar(255) NOT NULL,
    `alt`     TEXT,
    `user_id` INT(11)      NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `messages`
(
    `id`           INT(11) NOT NULL AUTO_INCREMENT,
    `sender_id`    INT(11) NOT NULL,
    `recipient_id` INT(11) NOT NULL,
    `message`      TEXT    NOT NULL,
    `status`       INT     NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `category`
(
    `id`   INT(11)      NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `user_category`
(
    `user_id`     INT(11) NOT NULL,
    `category_id` INT(11) NOT NULL
);


ALTER TABLE `task`
    ADD CONSTRAINT `customer_id_fk` FOREIGN KEY (`customer_id`) REFERENCES `user` (`id`);

ALTER TABLE `task`
    ADD CONSTRAINT `task_category_fk` FOREIGN KEY (`category_id`) REFERENCES `task_category` (`id`);

ALTER TABLE `task`
    ADD CONSTRAINT `city_fk` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`);

ALTER TABLE `task`
    ADD CONSTRAINT `enforcer_id_fk` FOREIGN KEY (`enforcer_id`) REFERENCES `user` (`id`);

ALTER TABLE `task`
    ADD CONSTRAINT `task_messages_fk` FOREIGN KEY (`messages`) REFERENCES `messages` (`id`);

ALTER TABLE `task_response`
    ADD CONSTRAINT `task_task_response_fk` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`);

ALTER TABLE `task_response`
    ADD CONSTRAINT `user_task_response_fk` FOREIGN KEY (`enfoncer_id`) REFERENCES `user` (`id`);

ALTER TABLE `user_review`
    ADD CONSTRAINT `user_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

ALTER TABLE `user_review`
    ADD CONSTRAINT `task_user_review_fk` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`);

ALTER TABLE `user_review`
    ADD CONSTRAINT `user_reviewer_id_fk` FOREIGN KEY (`reviewer_id`) REFERENCES `user` (`id`);

ALTER TABLE `photo`
    ADD CONSTRAINT `photo_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

ALTER TABLE `messages`
    ADD CONSTRAINT `messages_sender_id_fk` FOREIGN KEY (`sender_id`) REFERENCES `user` (`id`);

ALTER TABLE `messages`
    ADD CONSTRAINT `messages_recipient_id_fk` FOREIGN KEY (`recipient_id`) REFERENCES `user` (`id`);

ALTER TABLE `user_category`
    ADD CONSTRAINT `user_category_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

ALTER TABLE `user_category`
    ADD CONSTRAINT `user_category_category_fk` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);

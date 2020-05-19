CREATE TABLE `user`
(
    `id`            INT(11)      NOT NULL AUTO_INCREMENT,
    `email`         varchar(255) NOT NULL,
    `password`      varchar(255) NOT NULL,
    `reg_date`      DATETIME     NOT NULL,
    `last_active`   DATETIME     NOT NULL,
    `name`          varchar(255) NOT NULL,
    `last_name`     varchar(255) NOT NULL,
    `patronym_name` varchar(255),
    `birthday`      DATE,
    `bio`           TEXT,
    `avatar_path`   varchar(255) NOT NULL DEFAULT 'null',
    `rating`        INT(11),
    `viewing_count` INT(11)      NOT NULL DEFAULT '0',
    `role`          INT(11)      NOT NULL,
    `phone`         varchar(11),
    `skype`         varchar(255),
    `telegram`      varchar(255),
    `user_status`   INT(255)     NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `user_role`
(
    `id`   INT(11)      NOT NULL AUTO_INCREMENT,
    `role` varchar(255) NOT NULL DEFAULT 'user',
    PRIMARY KEY (`id`)
);

CREATE TABLE `task`
(
    `id`              INT(11)      NOT NULL AUTO_INCREMENT,
    `publish_date`    DATETIME     NOT NULL,
    `status_id`       INT(11)      NOT NULL,
    `title`           varchar(255) NOT NULL,
    `description`     TEXT         NOT NULL,
    `budget`          INT(11)      NOT NULL,
    `customer`        INT(11)      NOT NULL,
    `category_id`     INT(11)      NOT NULL,
    `latitude`        varchar(255),
    `longitude`       varchar(255),
    `city_id`         INT(11),
    `enforcer`        INT(11),
    `additional_text` TEXT,
    `messages`        INT          NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `task_status`
(
    `id`   INT(11)      NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
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
    `id`   INT(11)      NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
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
    `id`                INT(11) NOT NULL AUTO_INCREMENT,
    `sender_id`         INT(11) NOT NULL,
    `recipient_id`      INT(11) NOT NULL,
    `message`           TEXT    NOT NULL,
    `message_status_id` INT(11) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `message_status`
(
    `id`     INT(11)     NOT NULL AUTO_INCREMENT,
    `status` varchar(11) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `user_status`
(
    `id`   INT(11)      NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
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
    `categody_id` INT(11) NOT NULL
);

ALTER TABLE `user`
    ADD FOREIGN KEY (`role`) REFERENCES `user_role` (`id`);

ALTER TABLE `user`
    ADD FOREIGN KEY (`user_status`) REFERENCES `user_status` (`id`);

ALTER TABLE `task`
    ADD FOREIGN KEY (`status_id`) REFERENCES `task_status` (`id`);

ALTER TABLE `task`
    ADD FOREIGN KEY (`customer`) REFERENCES `user` (`id`);

ALTER TABLE `task`
    ADD FOREIGN KEY (`category_id`) REFERENCES `task_category` (`id`);

ALTER TABLE `task`
    ADD FOREIGN KEY (`city_id`) REFERENCES `city` (`id`);

ALTER TABLE `task`
    ADD FOREIGN KEY (`enforcer`) REFERENCES `user` (`id`);

ALTER TABLE `task`
    ADD FOREIGN KEY (`messages`) REFERENCES `messages` (`id`);

ALTER TABLE `task_response`
    ADD FOREIGN KEY (`task_id`) REFERENCES `task` (`id`);

ALTER TABLE `task_response`
    ADD FOREIGN KEY (`enfoncer_id`) REFERENCES `user` (`id`);

ALTER TABLE `user_review`
    ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

ALTER TABLE `user_review`
    ADD FOREIGN KEY (`task_id`) REFERENCES `task` (`id`);

ALTER TABLE `user_review`
    ADD FOREIGN KEY (`reviewer_id`) REFERENCES `user` (`id`);

ALTER TABLE `photo`
    ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

ALTER TABLE `messages`
    ADD FOREIGN KEY (`sender_id`) REFERENCES `user` (`id`);

ALTER TABLE `messages`
    ADD FOREIGN KEY (`recipient_id`) REFERENCES `user` (`id`);

ALTER TABLE `messages`
    ADD FOREIGN KEY (`message_status_id`) REFERENCES `message_status` (`id`);

ALTER TABLE `user_category`
    ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

ALTER TABLE `user_category`
    ADD CONSTRAINT `user_category_fk1` FOREIGN KEY (`categody_id`) REFERENCES `category` (`id`);

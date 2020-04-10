CREATE TABLE `users` (
                         `id` INT(11) NOT NULL AUTO_INCREMENT,
                         `email` varchar(255) NOT NULL,
                         `password` varchar(255) NOT NULL,
                         `reg_date` DATETIME NOT NULL,
                         `last_active` DATETIME NOT NULL,
                         `name` varchar(255) NOT NULL,
                         `last_name` varchar(255) NOT NULL,
                         `patronym_name` varchar(255),
                         `birthday` DATE,
                         `bio` TEXT,
                         `avatar_path` varchar(255) NOT NULL DEFAULT '0',
                         `categories` INT(11) NOT NULL,
                         `rating` INT(11),
                         `viewing_count` INT(11) NOT NULL DEFAULT '0',
                         `role` INT(11) NOT NULL,
                         `phone` varchar(255),
                         `skype` varchar(255),
                         `telegram` varchar(255),
                         `user_status` INT(255) NOT NULL,
                         PRIMARY KEY (`id`)
);

CREATE TABLE `users_role` (
                              `id` INT(11) NOT NULL AUTO_INCREMENT,
                              `role` varchar(255) NOT NULL DEFAULT 'user',
                              PRIMARY KEY (`id`)
);

CREATE TABLE `tasks` (
                         `id` INT(11) NOT NULL AUTO_INCREMENT,
                         `publish_date` DATETIME NOT NULL,
                         `status_id` INT(11) NOT NULL,
                         `title` varchar(255) NOT NULL,
                         `description` TEXT NOT NULL,
                         `budget` INT(11) NOT NULL,
                         `customer` INT(11) NOT NULL,
                         `category_id` INT(11) NOT NULL,
                         `latitude` varchar(255),
                         `longitude` varchar(255),
                         `town_id` INT(11),
                         `enforcer` INT(11),
                         `rating` INT(11) NOT NULL DEFAULT '0',
                         `additional_text` TEXT,
                         `messages` INT NOT NULL,
                         PRIMARY KEY (`id`)
);

CREATE TABLE `task_statuses` (
                                 `id` INT(11) NOT NULL AUTO_INCREMENT,
                                 `name` varchar(255) NOT NULL,
                                 PRIMARY KEY (`id`)
);

CREATE TABLE `tasks_categories` (
                                    `id` INT(11) NOT NULL AUTO_INCREMENT,
                                    `name` varchar(255) NOT NULL,
                                    PRIMARY KEY (`id`)
);

CREATE TABLE `towns` (
                         `id` INT(11) NOT NULL AUTO_INCREMENT,
                         `name` varchar(255) NOT NULL,
                         `name_ru` varchar(255) NOT NULL,
                         PRIMARY KEY (`id`)
);

CREATE TABLE `task_response` (
                                 `id` INT(11) NOT NULL AUTO_INCREMENT,
                                 `task_id` INT(11) NOT NULL,
                                 `enfoncer_id` INT(11) NOT NULL,
                                 `price` INT(11) NOT NULL,
                                 `comment` TEXT,
                                 PRIMARY KEY (`id`)
);

CREATE TABLE `users_reviews` (
                                 `id` INT(11) NOT NULL AUTO_INCREMENT,
                                 `user_id` INT(11) NOT NULL,
                                 `task_id` INT(11) NOT NULL,
                                 `reviewer_id` INT(11) NOT NULL,
                                 `message` TEXT NOT NULL,
                                 `rating` INT(1) NOT NULL,
                                 PRIMARY KEY (`id`)
);

CREATE TABLE `photoes` (
                           `id` INT(11) NOT NULL AUTO_INCREMENT,
                           `path` varchar(255) NOT NULL,
                           `alt` TEXT,
                           `user_id` INT(11) NOT NULL,
                           PRIMARY KEY (`id`)
);

CREATE TABLE `messages` (
                            `id` INT(11) NOT NULL AUTO_INCREMENT,
                            `sender_id` INT(11) NOT NULL,
                            `recipient_id` INT(11) NOT NULL,
                            `message` TEXT NOT NULL,
                            `message_status_id` INT(11) NOT NULL,
                            PRIMARY KEY (`id`)
);

CREATE TABLE `message_status` (
                                  `id` INT(11) NOT NULL AUTO_INCREMENT,
                                  `status` varchar(11) NOT NULL,
                                  PRIMARY KEY (`id`)
);

CREATE TABLE `user_statuses` (
                                 `id` INT(11) NOT NULL AUTO_INCREMENT,
                                 `name` varchar(255) NOT NULL,
                                 PRIMARY KEY (`id`)
);

ALTER TABLE `users` ADD CONSTRAINT `users_fk0` FOREIGN KEY (`categories`) REFERENCES `tasks_categories`(`id`);

ALTER TABLE `users` ADD CONSTRAINT `users_fk1` FOREIGN KEY (`role`) REFERENCES `users_role`(`id`);

ALTER TABLE `users` ADD CONSTRAINT `users_fk2` FOREIGN KEY (`user_status`) REFERENCES `user_statuses`(`id`);

ALTER TABLE `tasks` ADD CONSTRAINT `tasks_fk0` FOREIGN KEY (`status_id`) REFERENCES `task_statuses`(`id`);

ALTER TABLE `tasks` ADD CONSTRAINT `tasks_fk1` FOREIGN KEY (`customer`) REFERENCES `users`(`id`);

ALTER TABLE `tasks` ADD CONSTRAINT `tasks_fk2` FOREIGN KEY (`category_id`) REFERENCES `tasks_categories`(`id`);

ALTER TABLE `tasks` ADD CONSTRAINT `tasks_fk3` FOREIGN KEY (`town_id`) REFERENCES `towns`(`id`);

ALTER TABLE `tasks` ADD CONSTRAINT `tasks_fk4` FOREIGN KEY (`enforcer`) REFERENCES `users`(`id`);

ALTER TABLE `tasks` ADD CONSTRAINT `tasks_fk5` FOREIGN KEY (`messages`) REFERENCES `messages`(`id`);

ALTER TABLE `task_response` ADD CONSTRAINT `task_response_fk0` FOREIGN KEY (`task_id`) REFERENCES `tasks`(`id`);

ALTER TABLE `task_response` ADD CONSTRAINT `task_response_fk1` FOREIGN KEY (`enfoncer_id`) REFERENCES `users`(`id`);

ALTER TABLE `users_reviews` ADD CONSTRAINT `users_reviews_fk0` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`);

ALTER TABLE `users_reviews` ADD CONSTRAINT `users_reviews_fk1` FOREIGN KEY (`task_id`) REFERENCES `tasks`(`id`);

ALTER TABLE `users_reviews` ADD CONSTRAINT `users_reviews_fk2` FOREIGN KEY (`reviewer_id`) REFERENCES `users`(`id`);

ALTER TABLE `photoes` ADD CONSTRAINT `photoes_fk0` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`);

ALTER TABLE `messages` ADD CONSTRAINT `messages_fk0` FOREIGN KEY (`sender_id`) REFERENCES `users`(`id`);

ALTER TABLE `messages` ADD CONSTRAINT `messages_fk1` FOREIGN KEY (`recipient_id`) REFERENCES `users`(`id`);

ALTER TABLE `messages` ADD CONSTRAINT `messages_fk2` FOREIGN KEY (`message_status_id`) REFERENCES `message_status`(`id`);

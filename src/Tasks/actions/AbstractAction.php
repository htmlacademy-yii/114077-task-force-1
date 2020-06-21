<?php

namespace TaskForce\Tasks\Actions;

use TaskForce\Tasks\Task;

abstract class AbstractAction
{
    abstract static function getName(): string;

    abstract static function getCode(): string;

    abstract static function verifyAbility(int $userId, Task $task): string;
}

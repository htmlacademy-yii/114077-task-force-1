<?php

namespace TaskForce\Tasks\Actions;

use TaskForce\Tasks\Task;

class RefuseAction extends AbstractAction
{
    static function getName(): string
    {
        return 'Отказаться';
    }

    static function getCode(): string
    {
        return self::class;
    }

    public static function isAllowed(string $role, string $status): bool
    {
        return ($role === Task::ROLE_WORKER && $status === Task::STATUS_PROCEED);
    }
}

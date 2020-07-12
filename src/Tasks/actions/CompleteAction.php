<?php

namespace TaskForce\Tasks\Actions;

use TaskForce\Tasks\Task;

class CompleteAction extends AbstractAction
{
    public static function getName(): string
    {
        return 'Выполнено';
    }

    public static function getCode(): string
    {
        return self::class;
    }

    public static function isAllowed(string $role, string $status): bool
    {
        return ($role === Task::ROLE_CLIENT && $status === Task::STATUS_PROCEED);
    }
}

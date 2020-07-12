<?php

namespace TaskForce\Tasks\Actions;

use TaskForce\Tasks\Task;

class CallAction extends AbstractAction
{
    public static function getName(): string
    {
        return 'Откликнуться';
    }

    public static function getCode(): string
    {
        return self::class;
    }

    public static function isAllowed(string $role, string $status): bool
    {
        return ($role === Task::ROLE_WORKER && $status === Task::STATUS_NEW);
    }
}
<?php

namespace TaskForce\Tasks\Actions;

use TaskForce\Tasks\Task;

class CancelAction extends AbstractAction {
    public static function getName(): string
    {
        return self::class;
    }

    public static function getCode(): string
    {
        return 'action_cancel';
    }

    public static function verifyAbility(int $userId, Task $task): string
    {
        if ($task->getStatusValues() !== Task::STATUS_CANCEL) {
            return false;
        }

        if ($userId !==  $task->getClientId()) {
            return false;
        }

        return true;
    }
}

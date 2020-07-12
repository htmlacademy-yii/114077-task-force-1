<?php

require_once '../vendor/autoload.php';
use TaskForce\Tasks\Task;

use TaskForce\Tasks\Actions\CallAction;
use TaskForce\Tasks\Actions\CancelAction;
use TaskForce\Tasks\Actions\CompleteAction;
use TaskForce\Tasks\Actions\RefuseAction;

use PHPUnit\Framework\TestCase;

class TaskTest extends TestCase
{
    public function testGetStatusValues()
    {
        $task = new Task(1,1);

        $incomeArray = $task->getStatusValues();
        $expArray = [
            $task::STATUS_NEW => 'Новое',
            $task::STATUS_CANCEL => 'Отменено',
            $task::STATUS_PROCEED => 'В работе',
            $task::STATUS_COMPLETE => 'Выполнено',
            $task::STATUS_FAIL => 'Провалено',
        ];

        $this->assertEquals($expArray, $incomeArray);
    }


    public function testGetActionValues()
    {
        $task = new Task(1,2);
        $incomeArray = $task->getActionValues();

        $expArray = [
            CancelAction::class,
            CallAction::class,
            CompleteAction::class,
            RefuseAction::class,
        ];

        $this->assertEquals($expArray, $incomeArray);
    }

    public function testGetNextStatus()
    {
        $task = new Task(1,2);

        $income = $task->getNextStatus($task::ACTION_CANCEL);
        $exp = $task::STATUS_CANCEL;

        $this->assertEquals($exp, $income);
    }

    public function testGetAvailableAction()
    {
        $task = new Task(1,2);

        $incomeArray = $task->getAvailableAction($task::STATUS_NEW);
        $expArray = [
            $task::STATUS_NEW => [$task::ACTION_CANCEL, $task::ACTION_CALL],
        ];

        $this->assertEquals($expArray[$task::STATUS_NEW], $incomeArray);
    }

    public function testAvailableAction() {
        $task_new = new Task(1, 2);
        $this->assertEquals($task_new->getAvailableAction(1), [CancelAction::getName()]);

        $task_proceed = new Task(1, 2, 'in_work');
        $this->assertEquals($task_proceed->getAvailableAction(2), [RefuseAction::getName()]);
        $this->assertEquals($task_proceed->getAvailableAction(1), [CompleteAction::getName()]);
    }
}

<?php

namespace TaskForce\Tasks;

use PHPUnit\Framework\TestCase;

class TaskTest extends TestCase
{
    public function testGetStatusVaules()
    {
        $task = new Task(1,1);

        $incomeArray = $task->getStatusValues();
        $expArray = [
            $task::STATUS_NEW => 'Новое',
            $task::STATUS_CANCEL => 'Отменено',
            $task::STATUS_PROCEED => 'В работе',
            $task::STATUS_DONE => 'Выполнено',
            $task::STATUS_FAIL => 'Провалено',
        ];

        $this->assertEquals($expArray, $incomeArray);
    }


    public function testGetActionVaules()
    {
        $task = new Task(1,1);

        $incomeArray = $task->getActionVaules();
        $expArray = [
            $task::ACTION_CANCEL => 'Отменить',
            $task::ACTION_CALL => 'Откликнуться',
            $task::ACTION_DONE => 'Выполнено',
            $task::ACTION_REFUSE => 'Отказаться'
        ];

        $this->assertEquals($expArray, $incomeArray);
    }

    public function testGetNextStatus()
    {
        $task = new Task(1,1);

        $income = $task->getNextStatus($task::ACTION_CANCEL);
        $exp = $task::STATUS_CANCEL;

        $this->assertEquals($exp, $income);
    }

    public function testGetAvailableAction()
    {
        $task = new Task(1,1);

        $incomeArray = $task->getAvailableAction($task::STATUS_NEW);
        $expArray = [
            $task::STATUS_NEW => [$task::ACTION_CANCEL, $task::ACTION_CALL],
        ];

        $this->assertEquals($expArray[$task::STATUS_NEW], $incomeArray);
    }

}

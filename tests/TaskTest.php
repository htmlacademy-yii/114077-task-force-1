<?php

namespace TaskForce;

use PHPUnit\Framework\TestCase;

class TaskTest extends TestCase
{

    public function testGetNextStatus()
    {
        $task = new Task(1,1);

        $income = $task->getNextStatus('ACTION_CANCEL');
        $exp = 'STATUS_CANCEL';

        $this->assertEquals($exp, $income);
    }
}

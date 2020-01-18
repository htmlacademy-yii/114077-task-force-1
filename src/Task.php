<?php

namespace TaskForce;

class Task
{
    const STATUS_NEW = 'new';
    const STATUS_CANCEL = 'cancel';
    const STATUS_PROCEED = 'in_work';
    const STATUS_DONE = 'done';
    const STATUS_FAIL = 'fail';

    const ACTION_CANCEL = 'do_cancel';
    const ACTION_CALL = 'do_call';
    const ACTION_DONE = 'do_done';
    const ACTION_REFUSE = 'do_refuse';

    public $status_values = [
        self::STATUS_NEW => 'Новое',
        self::STATUS_CANCEL => 'Отменено',
        self::STATUS_PROCEED => 'В работе',
        self::STATUS_DONE => 'Выполнено',
        self::STATUS_FAIL => 'Провалено',
    ];

    public $action_values = [
        self::ACTION_CANCEL => 'Отменить',
        self::ACTION_CALL => 'Откликнуться',
        self::ACTION_DONE => 'Выполнено',
        self::ACTION_REFUSE => 'Отказаться'
    ];

    public $next_statuses = [
        'ACTION_CANCEL' => 'STATUS_CANCEL',
        'ACTION_CALL' => 'STATUS_PROCEED',
        'ACTION_DONE' => 'STATUS_DONE',
        'ACTION_REFUSE' => 'STATUS_FAIL',
    ];

    public $available_actions = [
        'STATUS_NEW' => ['ACTION_CANCEL', 'ACTION_CALL'],
        'STATUS_PROCEED' => ['ACTION_DONE', 'ACTION_REFUSE']
    ];

    private $id_client;
    private $id_worker;

    public function __construct($id_client, $id_worker) {
        $this->id_client = $id_client;
        $this->id_worker = $id_worker;
    }

    public function getStatusVaules() {
        return $this->status_values;
    }

    public function getActionVaules() {
        return $this->action_values;
    }

    public function getNextStatus($action) {
        return $this->next_statuses[$action];
    }

    public function getAvailableAction($status) {
        return $this->available_actions[$status];
    }
}

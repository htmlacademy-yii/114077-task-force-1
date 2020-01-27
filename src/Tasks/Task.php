<?php

namespace TaskForce\Tasks;

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

    private $status_values = [
        self::STATUS_NEW => 'Новое',
        self::STATUS_CANCEL => 'Отменено',
        self::STATUS_PROCEED => 'В работе',
        self::STATUS_DONE => 'Выполнено',
        self::STATUS_FAIL => 'Провалено',
    ];

    private $action_values = [
        self::ACTION_CANCEL => 'Отменить',
        self::ACTION_CALL => 'Откликнуться',
        self::ACTION_DONE => 'Выполнено',
        self::ACTION_REFUSE => 'Отказаться'
    ];

    private $next_statuses = [
        self::ACTION_CANCEL => self::STATUS_CANCEL,
        self::ACTION_CALL => self::STATUS_PROCEED,
        self::ACTION_DONE => self::STATUS_DONE,
        self::ACTION_REFUSE => self::STATUS_FAIL,
    ];

    private $available_actions = [
        self::STATUS_NEW => [self::ACTION_CANCEL, self::ACTION_CALL],
        self::STATUS_PROCEED => [self::ACTION_DONE, self::ACTION_REFUSE]
    ];

    private $client_id;
    private $worker_id;

    public function __construct($id_client, $id_worker) {
        $this->id_client = $id_client;
        $this->id_worker = $id_worker;
    }

    public function getStatusValues() {
        return $this->status_values;
    }

    public function getActionVaules() {
        return $this->action_values;
    }

    public function getNextStatus($action) {
        $next_status = false;
        if (array_key_exists ($action, $this->next_statuses)) {
            $next_status = $this->next_statuses[$action];
        }
        return $next_status;
    }

    public function getAvailableAction($status) {
        $available_actions = false;
        if (array_key_exists ($status, $this->available_actions)) {
            $available_actions = $this->available_actions[$status];;
        }
        return $available_actions;
    }
}

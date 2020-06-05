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

    private $statusValues = [
        self::STATUS_NEW => 'Новое',
        self::STATUS_CANCEL => 'Отменено',
        self::STATUS_PROCEED => 'В работе',
        self::STATUS_DONE => 'Выполнено',
        self::STATUS_FAIL => 'Провалено',
    ];

    private $actionValues = [
        self::ACTION_CANCEL => 'Отменить',
        self::ACTION_CALL => 'Откликнуться',
        self::ACTION_DONE => 'Выполнено',
        self::ACTION_REFUSE => 'Отказаться'
    ];

    private $nextStatuses = [
        self::ACTION_CANCEL => self::STATUS_CANCEL,
        self::ACTION_CALL => self::STATUS_PROCEED,
        self::ACTION_DONE => self::STATUS_DONE,
        self::ACTION_REFUSE => self::STATUS_FAIL,
    ];

    private $availableActions = [
        self::STATUS_NEW => [self::ACTION_CANCEL, self::ACTION_CALL],
        self::STATUS_PROCEED => [self::ACTION_DONE, self::ACTION_REFUSE]
    ];

    private $clientId;
    private $workerId;

    /**
     * Task constructor
     *
     * @param int $clientId - интификатор заказчика
     * @param int $workerId - идентификатор исполнителя
     */
    public function __construct($clientId, $workerId) {
        $this->clientId = $clientId;
        $this->workerId = $workerId;
    }

    /**
     * @return array - расшифровка статусов
     */
    public function getStatusValues() {
        return $this->statusValues;
    }

    /**
     * @return array - расшифровка действий заказчика
     */
    public function getActionValues() {
        return $this->actionValues;
    }

    /**
     * Возвращает следующий статус, в соответствии с выбором действия (отклика) на заказ
     *
     * @param string $action - ключ, по которому определяется следующий статус
     * @return bool|string
     */
    public function getNextStatus($action) {
        $next_status = false;
        if (array_key_exists ($action, $this->nextStatuses)) {
            $next_status = $this->nextStatuses[$action];
        }
        return $next_status;
    }

    /**
     * Возвращает список доступных действий для текущего статуса
     *
     * @param string $status - текущий статус
     * @return bool|array
     */
    public function getAvailableAction($status) {
        $availableActions = false;
        if (array_key_exists ($status, $this->availableActions)) {
            $availableActions = $this->availableActions[$status];
        }
        return $availableActions;
    }
}

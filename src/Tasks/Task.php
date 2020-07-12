<?php

namespace TaskForce\Tasks;

use TaskForce\Tasks\Actions\AbstractAction;
use TaskForce\Tasks\Actions\CallAction;
use TaskForce\Tasks\Actions\CancelAction;
use TaskForce\Tasks\Actions\CompleteAction;
use TaskForce\Tasks\Actions\RefuseAction;

class Task
{
    const ROLE_CLIENT = 'Client';
    const ROLE_WORKER = 'Worker';

    const ACTION_CANCEL = CancelAction::class;
    const ACTION_CALL = CallAction::class;
    const ACTION_COMPLETE = CompleteAction::class;
    const ACTION_REFUSE = RefuseAction::class;

    const ACTIONS = [
        self::ACTION_CANCEL,
        self::ACTION_CALL,
        self::ACTION_COMPLETE,
        self::ACTION_REFUSE
    ];

    const STATUS_NEW = 'new';
    const STATUS_CANCEL = 'cancel';
    const STATUS_PROCEED = 'in_work';
    const STATUS_COMPLETE = 'done';
    const STATUS_FAIL = 'fail';

    const ACTION_TO_STATUS = [
        self::ACTION_CANCEL => self::STATUS_CANCEL,
        self::ACTION_COMPLETE => self::STATUS_COMPLETE,
        self::ACTION_CALL => self::STATUS_PROCEED,
        self::ACTION_REFUSE => self::STATUS_FAIL
    ];

    const STATUS_VALUES = [
        self::STATUS_NEW => 'Новое',
        self::STATUS_CANCEL => 'Отменено',
        self::STATUS_PROCEED => 'В работе',
        self::STATUS_COMPLETE => 'Выполнено',
        self::STATUS_FAIL => 'Провалено',
    ];

    private $clientId;
    private $workerId;
    private $status;

    /**
     * Task constructor
     *
     * @param int $clientId - интификатор заказчика
     * @param int $workerId - идентификатор исполнителя
     * @param string $status - текущий статус задания (новый -- по умолчанию)
     */
    public function __construct($clientId, $workerId, string $status = self::STATUS_NEW)
    {
        $this->clientId = $clientId;
        $this->workerId = $workerId;
        $this->status = $status;
    }

    /**
     * @return array
     */
    public function getStatusValues() : array
    {
        return self::STATUS_VALUES;
    }

    /**
     * @return array
     */
    public function getActionValues() : array
    {
        return self::ACTIONS;
    }

    /**
     * @param int $id
     * @return string
     */
    public function getCurrentRole(int $id): string
    {
        $role = '';

        if ($id === $this->workerId) {
            $role = self::ROLE_WORKER;
        };

        if ($id === $this->clientId) {
            $role = self::ROLE_CLIENT;
        }

        return $role;
    }

    /**
     * @param AbstractAction $action
     * @return string
     */
    public function getNextStatus(AbstractAction $action): string
    {
        return self::ACTION_TO_STATUS[$action::getName()];
    }

    /**
     * @param int $userId
     * @return array
     */
    public function getAvailableAction(int $userId) : array
    {
        $availableActions = [];

        foreach(self::ACTIONS as $action) {
            if ($action::isAllowed($this->getCurrentRole($userId), $this->status)) {
                array_push($availableActions, $action::getName());
            }
        }

        return $availableActions;
    }
}

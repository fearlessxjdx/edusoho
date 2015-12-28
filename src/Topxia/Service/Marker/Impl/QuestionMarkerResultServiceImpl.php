<?php
namespace Topxia\Service\Marker\Impl;

use Topxia\Service\Common\BaseService;
use Topxia\Service\Marker\QuestionMarkerResultService;

class QuestionMarkerResultServiceImpl extends BaseService implements QuestionMarkerResultService
{
    public function getQuestionMarkerResult($id)
    {
        return $this->getQuestionMarkerResultDao()->getQuestionMarkerResult($id);
    }

    public function addQuestionMarkerResult($result)
    {
        $result['createdTime'] = time();

        return $this->getQuestionMarkerResultDao()->addQuestionMarkerResult($result);
    }

    public function updateQuestionMarkerResult($id, $result)
    {
        $result['updatedTime'] = time();

        return $this->getQuestionMarkerResultDao()->updateQuestionMarkerResult($id, $result);
    }

    public function finishCurrentQuestion($userId, $questionMarkerId, $answer, $type)
    {
        if ($type == 'single_choice') {
            $questionMarker = $this->getQuestionMarkerService()->getQuestionMarker($questionMarkerId);
            $status         = in_array($answer, $questionMarker['answer']) ? 'right' : 'wrong';
        }

        if ($type == 'uncertain_choice') {
            $questionMarker = $this->getQuestionMarkerService()->getQuestionMarker($questionMarkerId);
            $status         = in_array($answer, $questionMarker['answer']) ? 'right' : 'wrong';
        }

        $questionMarkerResult = $this->findByUserIdAndQuestionMarkerId($userId, $questionMarkerId);
        $this->updateQuestionMarkerResult($questionMarkerResult['id'], array(
            'status'      => $status,
            'updatedTime' => time()
        ));
    }

    public function deleteByQuestionMarkerId($questionMarkerId)
    {
        return $this->getQuestionMarkerResultDao()->deleteByQuestionMarkerId($questionMarkerId);
    }

    public function findByUserIdAndMarkerId($userId, $markerId)
    {
        return $this->getQuestionMarkerResultDao()->findByUserIdAndMarkerId($userId, $markerId);
    }

    public function findByUserIdAndQuestionMarkerId($userId, $questionMarkerId)
    {
        return $this->getQuestionMarkerResultDao()->findByUserIdAndQuestionMarkerId($userId, $questionMarkerId);
    }

    protected function getQuestionMarkerResultDao()
    {
        return $this->createDao('Marker.QuestionMarkerResultDao');
    }

    protected function getQuestionMarkerService()
    {
        return $this->createService('Marker.QuestionMarkerService');
    }
}

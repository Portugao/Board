<?php
/**
 * MUBoard.
 *
 * @copyright Michael Ueberschaer
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package MUBoard
 * @author Michael Ueberschaer <kontakt@webdesign-in-bremen.com>.
 * @link http://www.webdesign-in-bremen.com
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.5.4 (http://modulestudio.de) at Sun Oct 14 15:42:51 CEST 2012.
 */

/**
 * Validator class for encapsulating entity validation methods.
 *
 * This is the base validation class for user entities.
 */
class MUBoard_Entity_Validator_Base_User extends MUBoard_Validator
{

    /**
     * Performs all validation rules.
     *
     * @return mixed either array with error information or true on success
     */
    public function validateAll()
    {
        $errorInfo = array('message' => '', 'code' => 0, 'debugArray' => array());
        $dom = ZLanguage::getModuleDomain('MUBoard');
        if (!$this->isValidInteger('userid')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('userid'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotEmpty('userid')) {
            $errorInfo['message'] = __f('Error! Field value must not be 0 (%s).', array('userid'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotLongerThan('userid', 11)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('userid', 11), $dom);
            return $errorInfo;
        }
        if (!$this->isValidInteger('numberPostings')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('numberPostings'), $dom);
            return $errorInfo;
        }
       /* if (!$this->isNumberNotEmpty('numberPostings')) {
            $errorInfo['message'] = __f('Error! Field value must not be 0 (%s).', array('numberPostings'), $dom);
            return $errorInfo;
        }*/
        if (!$this->isNumberNotLongerThan('numberPostings', 11)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('numberPostings', 11), $dom);
            return $errorInfo;
        }
        if (!$this->isValidDateTime('lastVisit')) {
            $errorInfo['message'] = __f('Error! Field value must be a valid datetime (%s).', array('lastVisit'), $dom);
            return $errorInfo;
        }
        return true;
    }

    /**
     * Check for unique values.
     *
     * This method determines if there already exist users with the same user.
     *
     * @param string $fieldName The name of the property to be checked
     * @return boolean result of this check, true if the given user does not already exist
     */
    public function isUniqueValue($fieldName)
    {
        if (empty($this->entity[$fieldName])) {
            return false;
        }

        $serviceManager = ServiceUtil::getManager();
        $entityManager = $serviceManager->getService('doctrine.entitymanager');
        $repository = $entityManager->getRepository('MUBoard_Entity_User');

        $excludeid = $this->entity['id'];
        return $repository->detectUniqueState($fieldName, $this->entity[$fieldName], $excludeid);
    }

    /**
     * Get entity.
     *
     * @return Zikula_EntityAccess
     */
    public function getEntity()
    {
        return $this->entity;
    }

    /**
     * Set entity.
     *
     * @param Zikula_EntityAccess $entity.
     *
     * @return void
     */
    public function setEntity(Zikula_EntityAccess $entity = null)
    {
        $this->entity = $entity;
    }

}

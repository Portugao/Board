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
 * @version Generated by ModuleStudio 0.5.4 (http://modulestudio.de) at Fri Jun 15 09:09:36 CEST 2012.
 */

use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
use Gedmo\Mapping\Annotation as Gedmo;
use DoctrineExtensions\StandardFields\Mapping\Annotation as ZK;

/**
 * Entity class that defines the entity structure and behaviours.
 *
 * This is the concrete entity class for posting entities.
 * @ORM\Entity(repositoryClass="MUBoard_Entity_Repository_Posting")
 * @ORM\Table(name="muboard_posting")
 * @ORM\HasLifecycleCallbacks
 */
class MUBoard_Entity_Posting extends MUBoard_Entity_Base_Posting
{
	/**
	 * Collect available actions for this entity.
	 */
	protected function prepareItemActions()
	{
		if (!empty($this->_actions)) {
			return;
		}

		$currentType = FormUtil::getPassedValue('type', 'user', 'GETPOST', FILTER_SANITIZE_STRING);
		$currentFunc = FormUtil::getPassedValue('func', 'main', 'GETPOST', FILTER_SANITIZE_STRING);
		$dom = ZLanguage::getModuleDomain('MUBoard');
		if ($currentType == 'admin') {
			if (in_array($currentFunc, array('main', 'view'))) {
				$this->_actions[] = array(
                        'url' => array('type' => 'user', 'func' => 'display', 'arguments' => array('ot' => 'posting', 'id' => $this['id'])),
                        'icon' => 'preview',
                        'linkTitle' => __('Open preview page', $dom),
                        'linkText' => __('Preview', $dom)
				);
				$this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'display', 'arguments' => array('ot' => 'posting', 'id' => $this['id'])),
                        'icon' => 'display',
                        'linkTitle' => str_replace('"', '', $this['title']),
                        'linkText' => __('Details', $dom)
				);
			}

			if (in_array($currentFunc, array('main', 'view', 'display'))) {
				if (SecurityUtil::checkPermission('MUBoard::', '.*', ACCESS_EDIT)) {

					$this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'edit', 'arguments' => array('ot' => 'posting', 'id' => $this['id'])),
                        'icon' => 'edit',
                        'linkTitle' => __('Edit', $dom),
                        'linkText' => __('Edit', $dom)
					);
					$this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'edit', 'arguments' => array('ot' => 'posting', 'astemplate' => $this['id'])),
                        'icon' => 'saveas',
                        'linkTitle' => __('Reuse for new item', $dom),
                        'linkText' => __('Reuse', $dom)
					);
				}
				if (SecurityUtil::checkPermission('MUBoard::', '.*', ACCESS_DELETE)) {
					$this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'delete', 'arguments' => array('ot' => 'posting', 'id' => $this['id'])),
                        'icon' => 'delete',
                        'linkTitle' => __('Delete', $dom),
                        'linkText' => __('Delete', $dom)
					);
				}
			}
			if ($currentFunc == 'display') {
				$this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'view', 'arguments' => array('ot' => 'posting')),
                        'icon' => 'back',
                        'linkTitle' => __('Back to overview', $dom),
                        'linkText' => __('Back to overview', $dom)
				);
			}
		}
		if ($currentType == 'user') {
			if (in_array($currentFunc, array('main', 'view'))) {
				$this->_actions[] = array(
                        'url' => array('type' => 'user', 'func' => 'display', 'arguments' => array('ot' => 'posting', 'id' => $this['id'])),
                        'icon' => 'display',
                        'linkTitle' => str_replace('"', '', $this['title']),
                        'linkText' => __('Details', $dom)
				);
			}

			if (in_array($currentFunc, array('main', 'view', 'display'))) {
				if (SecurityUtil::checkPermission('MUBoard::', '.*', ACCESS_EDIT)) {

					/*$this->_actions[] = array(
					 'url' => array('type' => 'user', 'func' => 'edit', 'arguments' => array('ot' => 'posting')),
					 'icon' => 'save',
					 'linkTitle' => __('Create new issue', $dom),
					 'linkText' => __('', $dom)
					 );
					 $this->_actions[] = array(
					 'url' => array('type' => 'user', 'func' => 'edit', 'arguments' => array('ot' => 'posting', 'id' => $this['id'])),
					 'icon' => 'edit',
					 'linkTitle' => __('Edit', $dom),
					 'linkText' => __('Edit', $dom)
					 );
					 $this->_actions[] = array(
					 'url' => array('type' => 'user', 'func' => 'edit', 'arguments' => array('ot' => 'posting', 'astemplate' => $this['id'])),
					 'icon' => 'saveas',
					 'linkTitle' => __('Reuse for new item', $dom),
					 'linkText' => __('Reuse', $dom)
					 );*/
				}
			}
			if ($currentFunc == 'display') {
				$this->_actions[] = array(
                        'url' => array('type' => 'user', 'func' => 'display', 'arguments' => array('ot' => 'forum', 'id' => $posting.Forum.id)),
                        'icon' => 'back',
                        'linkTitle' => __('Back to forum ', $dom) . $posting.Forum.title,
                        'linkText' => __('Back to forum overview', $dom)
				);
				$this->_actions[] = array(
                        'url' => array('type' => 'user', 'func' => 'view', 'arguments' => array('ot' => 'category')),
                        'icon' => 'back',
                        'linkTitle' => __('Back to forum overview', $dom),
                        'linkText' => __('', $dom)
				);
			}
		}
	}



	/**
	 * Post-Process the data after the entity has been constructed by the entity manager.
	 *
	 * @ORM\PostLoad
	 * @see MUBoard_Entity_Base_Posting::performPostLoadCallback()
	 * @return void.
	 */
	public function postLoadCallback()
	{
		$uid = UserUtil::getVar('uid');
		MUBoard_Util_View::modifyPostings($uid);
		$this->performPostLoadCallback();
	}

	/**
	 * Pre-Process the data prior to an insert operation.
	 *
	 * @ORM\PrePersist
	 * @see MUBoard_Entity_Base_Posting::performPrePersistCallback()
	 * @return void.
	 */
	public function prePersistCallback()
	{
		$text = $this->getText();
		$text = str_replace('\n', '<br />', $text);
		$this->setText($text);
		$this->performPrePersistCallback();
	}

	/**
	 * Post-Process the data after an insert operation.
	 *
	 * @ORM\PostPersist
	 * @see MUBoard_Entity_Base_Posting::performPostPersistCallback()
	 * @return void.
	 */
	public function postPersistCallback()
	{
		$createdUserId = $this->getCreatedUserId();
		MUBoard_Util_View::actualUser($createdUserId, 2);
			
		$args['id'] = $this->getId();
		$parent = $this->getParent(); // does not work bug in MOST TODO
		if ($parent != NULL) {
			$args['parent'] = $parent->getId();
			$args['title'] = $parent->getTitle();
		}
		else {

			$args['title'] = $this->getTitle();
		}
		$args['text'] = $this->getText();

		MUBoard_Util_Base_Abonnements::aboMailing($args);
		$args['text'] = str_replace('\n', '<br />', $args['text']);
		$this->setText($args['text']);
		$this->performPostPersistCallback();
	}

	/**
	 * Pre-Process the data prior a delete operation.
	 *
	 * @ORM\PreRemove
	 * @see MUBoard_Entity_Base_Posting::performPreRemoveCallback()
	 * @return void.
	 */
	public function preRemoveCallback()
	{
		$this->performPreRemoveCallback();
	}

	/**
	 * Post-Process the data after a delete.
	 *
	 * @ORM\PostRemove
	 * @see MUBoard_Entity_Base_Posting::performPostRemoveCallback()
	 * @return void
	 */
	public function postRemoveCallback()
	{
		$this->performPostRemoveCallback();
	}

	/**
	 * Pre-Process the data prior to an update operation.
	 *
	 * @ORM\PreUpdate
	 * @see MUBoard_Entity_Base_Posting::performPreUpdateCallback()
	 * @return void.
	 */
	public function preUpdateCallback()
	{
		$this->performPreUpdateCallback();
	}

	/**
	 * Post-Process the data after an update operation.
	 *
	 * @ORM\PostUpdate
	 * @see MUBoard_Entity_Base_Posting::performPostUpdateCallback()
	 * @return void.
	 */
	public function postUpdateCallback()
	{
		$this->performPostUpdateCallback();
	}

	/**
	 * Pre-Process the data prior to a save operation.
	 *
	 * @ORM\PrePersist
	 * @ORM\PreUpdate
	 * @see MUBoard_Entity_Base_Posting::performPreSaveCallback()
	 * @return void.
	 */
	public function preSaveCallback()
	{
		$this->performPreSaveCallback();
	}

	/**
	 * Post-Process the data after a save operation.
	 *
	 * @ORM\PostPersist
	 * @ORM\PostUpdate
	 * @see MUBoard_Entity_Base_Posting::performPostSaveCallback()
	 * @return void.
	 */
	public function postSaveCallback()
	{
		$this->performPostSaveCallback();
	}

}

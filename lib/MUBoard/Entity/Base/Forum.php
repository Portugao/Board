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

use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
use Gedmo\Mapping\Annotation as Gedmo;
use DoctrineExtensions\StandardFields\Mapping\Annotation as ZK;

/**
 * Entity class that defines the entity structure and behaviours.
 *
 * This is the base entity class for forum entities.
 *
 * @abstract
 */
abstract class MUBoard_Entity_Base_Forum extends Zikula_EntityAccess
{

    /**
     * @var string The tablename this object maps to
     */
    protected $_objectType = 'forum';

    /**
     * @var array List of primary key field names
     */
    protected $_idFields = array();

    /**
     * @var MUBoard_Entity_Validator_Forum The validator for this entity
     */
    protected $_validator = null;

    /**
     * @var boolean Whether this entity supports unique slugs
     */
    protected $_hasUniqueSlug = false;

    /**
     * @var array List of available item actions
     */
    protected $_actions = array();



    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer", unique=true)
     * @var integer $id.
     */
    protected $id = 0;


    /**
     * @ORM\Column(length=255)
     * @var string $title.
     */
    protected $title = '';


    /**
     * @ORM\Column(length=2000)
     * @var string $description.
     */
    protected $description = '';


    /**
     * @ORM\Column(type="smallint")
     * @var smallint $pos.
     */
    protected $pos;


    /**
     * @ORM\Column(type="integer")
     * @ZK\StandardFields(type="userid", on="create")
     * @var integer $createdUserId.
     */
    protected $createdUserId;

    /**
     * @ORM\Column(type="integer")
     * @ZK\StandardFields(type="userid", on="update")
     * @var integer $updatedUserId.
     */
    protected $updatedUserId;

    /**
     * @ORM\Column(type="datetime")
     * @Gedmo\Timestampable(on="create")
     * @var datetime $createdDate.
     */
    protected $createdDate;

    /**
     * @ORM\Column(type="datetime")
     * @Gedmo\Timestampable(on="update")
     * @var datetime $updatedDate.
     */
    protected $updatedDate;


    /**
     * Bidirectional - Many forum [forums] are linked by one category [category] (OWNING SIDE).
     *
     * @ORM\ManyToOne(targetEntity="MUBoard_Entity_Category", inversedBy="forum")
     * @ORM\JoinTable(name="muboard_category")
     * @var MUBoard_Entity_Category $category.
     */
    protected $category;



    /**
     * Bidirectional - One forum [forum] has many posting [postings] (INVERSE SIDE).
     *
     * @ORM\OneToMany(targetEntity="MUBoard_Entity_Posting", mappedBy="forum", cascade={"remove"})
     * @ORM\JoinTable(name="muboard_forumposting")
     * @ORM\OrderBy({"createdDate" = "DESC"})
     * @var MUBoard_Entity_Posting[] $posting.
     */
    protected $posting = null;

    /**
     * Constructor.
     * Will not be called by Doctrine and can therefore be used
     * for own implementation purposes. It is also possible to add
     * arbitrary arguments as with every other class method.
     */
    public function __construct()
    {
        $this->id = 1;
        $this->pos = 1;
        $this->_idFields = array('id');
        $this->initValidator();
        $this->_hasUniqueSlug = false;
        $this->posting = new ArrayCollection();
    }

    /**
     * Get _object type.
     *
     * @return string
     */
    public function get_objectType()
    {
        return $this->_objectType;
    }

    /**
     * Set _object type.
     *
     * @param string $_objectType.
     *
     * @return void
     */
    public function set_objectType($_objectType)
    {
        $this->_objectType = $_objectType;
    }


    /**
     * Get _id fields.
     *
     * @return array
     */
    public function get_idFields()
    {
        return $this->_idFields;
    }

    /**
     * Set _id fields.
     *
     * @param array $_idFields.
     *
     * @return void
     */
    public function set_idFields(array $_idFields = Array())
    {
        $this->_idFields = $_idFields;
    }


    /**
     * Get _validator.
     *
     * @return MUBoard_Entity_Validator_Forum
     */
    public function get_validator()
    {
        return $this->_validator;
    }

    /**
     * Set _validator.
     *
     * @param MUBoard_Entity_Validator_Forum $_validator.
     *
     * @return void
     */
    public function set_validator(MUBoard_Entity_Validator_Forum $_validator = null)
    {
        $this->_validator = $_validator;
    }


    /**
     * Get _has unique slug.
     *
     * @return boolean
     */
    public function get_hasUniqueSlug()
    {
        return $this->_hasUniqueSlug;
    }

    /**
     * Set _has unique slug.
     *
     * @param boolean $_hasUniqueSlug.
     *
     * @return void
     */
    public function set_hasUniqueSlug($_hasUniqueSlug)
    {
        $this->_hasUniqueSlug = $_hasUniqueSlug;
    }


    /**
     * Get _actions.
     *
     * @return array
     */
    public function get_actions()
    {
        return $this->_actions;
    }

    /**
     * Set _actions.
     *
     * @param array $_actions.
     *
     * @return void
     */
    public function set_actions(array $_actions = Array())
    {
        $this->_actions = $_actions;
    }



    /**
     * Get id.
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set id.
     *
     * @param integer $id.
     *
     * @return void
     */
    public function setId($id)
    {
        if ($id != $this->id) {
            $this->id = $id;
        }
    }

    /**
     * Get title.
     *
     * @return string
     */
    public function getTitle()
    {
        return $this->title;
    }

    /**
     * Set title.
     *
     * @param string $title.
     *
     * @return void
     */
    public function setTitle($title)
    {
        if ($title != $this->title) {
            $this->title = $title;
        }
    }

    /**
     * Get description.
     *
     * @return string
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * Set description.
     *
     * @param string $description.
     *
     * @return void
     */
    public function setDescription($description)
    {
        if ($description != $this->description) {
            $this->description = $description;
        }
    }

    /**
     * Get pos.
     *
     * @return smallint
     */
    public function getPos()
    {
        return $this->pos;
    }

    /**
     * Set pos.
     *
     * @param smallint $pos.
     *
     * @return void
     */
    public function setPos($pos)
    {
        if ($pos != $this->pos) {
            $this->pos = $pos;
        }
    }


    /**
     * Get created user id.
     *
     * @return integer[]
     */
    public function getCreatedUserId()
    {
        return $this->createdUserId;
    }

    /**
     * Set created user id.
     *
     * @param integer[] $createdUserId.
     *
     * @return void
     */
    public function setCreatedUserId($createdUserId)
    {
        $this->createdUserId = $createdUserId;
    }

    /**
     * Get updated user id.
     *
     * @return integer[]
     */
    public function getUpdatedUserId()
    {
        return $this->updatedUserId;
    }

    /**
     * Set updated user id.
     *
     * @param integer[] $updatedUserId.
     *
     * @return void
     */
    public function setUpdatedUserId($updatedUserId)
    {
        $this->updatedUserId = $updatedUserId;
    }

    /**
     * Get created date.
     *
     * @return datetime[]
     */
    public function getCreatedDate()
    {
        return $this->createdDate;
    }

    /**
     * Set created date.
     *
     * @param datetime[] $createdDate.
     *
     * @return void
     */
    public function setCreatedDate($createdDate)
    {
        $this->createdDate = $createdDate;
    }

    /**
     * Get updated date.
     *
     * @return datetime[]
     */
    public function getUpdatedDate()
    {
        return $this->updatedDate;
    }

    /**
     * Set updated date.
     *
     * @param datetime[] $updatedDate.
     *
     * @return void
     */
    public function setUpdatedDate($updatedDate)
    {
        $this->updatedDate = $updatedDate;
    }

    /**
     * Get category.
     *
     * @return MUBoard_Entity_Category
     */
    public function getCategory()
    {
        return $this->category;
    }

    /**
     * Set category.
     *
     * @param MUBoard_Entity_Category $category.
     *
     * @return void
     */
    public function setCategory(MUBoard_Entity_Category $category = null)
    {
        $this->category = $category;
    }


    /**
     * Adds an instance of MUBoard_Entity_Category to the list of category.
     *
     * @param MUBoard_Entity_Category $category.
     *
     * @return void
     */
    public function addCategory(MUBoard_Entity_Category $category)
    {
        $this->category[] = $category;
        $nameSingle->setForum($this);
    }

    /**
     * Removes an instance of MUBoard_Entity_Category from the list of category.
     *
     * @param MUBoard_Entity_Category $category.
     *
     * @return void
     */
    public function removeCategory(MUBoard_Entity_Category $category)
    {
        $this->category->removeElement($category);
        $nameSingle->setForum(null);
    }

    /**
     * Removes an instance of MUBoard_Entity_Category from the list of category by it's identifier.
     *
     * @param integer $category.
     *
     * @return void
     */
    public function removeCategoryById($id)
    {
        $this->category->remove($id);
        $nameSingle->setForum(null);
    }


    /**
     * Get posting.
     *
     * @return MUBoard_Entity_Posting[]
     */
    public function getPosting()
    {
        return $this->posting;
    }

    /**
     * Set posting.
     *
     * @param MUBoard_Entity_Posting[] $posting.
     *
     * @return void
     */
    public function setPosting($posting)
    {
        $this->posting = $posting;
    }


    /**
     * Adds an instance of MUBoard_Entity_Posting to the list of posting.
     *
     * @param MUBoard_Entity_Posting $posting.
     *
     * @return void
     */
    public function addPosting(MUBoard_Entity_Posting $posting)
    {
        $this->posting[] = $posting;
    }

    /**
     * Removes an instance of MUBoard_Entity_Posting from the list of posting.
     *
     * @param MUBoard_Entity_Posting $posting.
     *
     * @return void
     */
    public function removePosting(MUBoard_Entity_Posting $posting)
    {
        $this->posting->removeElement($posting);
    }

    /**
     * Removes an instance of MUBoard_Entity_Posting from the list of posting by it's identifier.
     *
     * @param integer $posting.
     *
     * @return void
     */
    public function removePostingById($id)
    {
        $this->posting->remove($id);
    }



    /**
     * Initialise validator and return it's instance.
     *
     * @return MUBoard_Entity_Validator_Forum The validator for this entity.
     */
    public function initValidator()
    {
        if (!is_null($this->_validator)) {
            return $this->_validator;
        }
        $this->_validator = new MUBoard_Entity_Validator_Forum($this);
        return $this->_validator;
    }

    /**
     * Start validation and raise exception if invalid data is found.
     *
     * @return void.
     */
    public function validate()
    {
        $result = $this->initValidator()->validateAll();
        if (is_array($result)) {
            throw new Zikula_Exception($result['message'], $result['code'], $result['debugArray']);
        }
    }

    /**
     * Return entity data in JSON format.
     *
     * @return string JSON-encoded data.
     */
    public function toJson()
    {
        return json_encode($this->toArray());
    }

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
                        'url' => array('type' => 'user', 'func' => 'display', 'arguments' => array('ot' => 'forum', 'id' => $this['id'])),
                        'icon' => 'preview',
                        'linkTitle' => __('Open preview page', $dom),
                        'linkText' => __('Preview', $dom)
                    );
                    $this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'display', 'arguments' => array('ot' => 'forum', 'id' => $this['id'])),
                        'icon' => 'display',
                        'linkTitle' => str_replace('"', '', $this['title']),
                        'linkText' => __('Details', $dom)
                    );
            }

            if (in_array($currentFunc, array('main', 'view', 'display'))) {
                if (SecurityUtil::checkPermission('MUBoard::', '.*', ACCESS_EDIT)) {

                    $this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'edit', 'arguments' => array('ot' => 'forum', 'id' => $this['id'])),
                        'icon' => 'edit',
                        'linkTitle' => __('Edit', $dom),
                        'linkText' => __('Edit', $dom)
                    );
                    $this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'edit', 'arguments' => array('ot' => 'forum', 'astemplate' => $this['id'])),
                        'icon' => 'saveas',
                        'linkTitle' => __('Reuse for new item', $dom),
                        'linkText' => __('Reuse', $dom)
                    );
                }
                if (SecurityUtil::checkPermission('MUBoard::', '.*', ACCESS_DELETE)) {
                    $this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'delete', 'arguments' => array('ot' => 'forum', 'id' => $this['id'])),
                        'icon' => 'delete',
                        'linkTitle' => __('Delete', $dom),
                        'linkText' => __('Delete', $dom)
                    );
                }
            }
            if ($currentFunc == 'display') {
                    $this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'view', 'arguments' => array('ot' => 'forum')),
                        'icon' => 'back',
                        'linkTitle' => __('Back to overview', $dom),
                        'linkText' => __('Back to overview', $dom)
                    );
            }
        }
        if ($currentType == 'user') {
            if (in_array($currentFunc, array('main', 'view'))) {
                    $this->_actions[] = array(
                        'url' => array('type' => 'user', 'func' => 'display', 'arguments' => array('ot' => 'forum', 'id' => $this['id'])),
                        'icon' => 'display',
                        'linkTitle' => str_replace('"', '', $this['title']),
                        'linkText' => __('Details', $dom)
                    );
            }

            if (in_array($currentFunc, array('main', 'view', 'display'))) {
                if (SecurityUtil::checkPermission('MUBoard::', '.*', ACCESS_EDIT)) {

                    $this->_actions[] = array(
                        'url' => array('type' => 'user', 'func' => 'edit', 'arguments' => array('ot' => 'forum', 'id' => $this['id'])),
                        'icon' => 'edit',
                        'linkTitle' => __('Edit', $dom),
                        'linkText' => __('Edit', $dom)
                    );
                    $this->_actions[] = array(
                        'url' => array('type' => 'user', 'func' => 'edit', 'arguments' => array('ot' => 'forum', 'astemplate' => $this['id'])),
                        'icon' => 'saveas',
                        'linkTitle' => __('Reuse for new item', $dom),
                        'linkText' => __('Reuse', $dom)
                    );
                }
            }
            if ($currentFunc == 'display') {
                    $this->_actions[] = array(
                        'url' => array('type' => 'user', 'func' => 'view', 'arguments' => array('ot' => 'forum')),
                        'icon' => 'back',
                        'linkTitle' => __('Back to overview', $dom),
                        'linkText' => __('Back to overview', $dom)
                    );
            }
        }
    }




    /**
     * Post-Process the data after the entity has been constructed by the entity manager.
     * The event happens after the entity has been loaded from database or after a refresh call.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - no access to associations (not initialised yet)
     *
     * @see MUBoard_Entity_Forum::postLoadCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPostLoadCallback()
    {
        // echo 'loaded a record ...';

        $currentType = FormUtil::getPassedValue('type', 'user', 'GETPOST', FILTER_SANITIZE_STRING);
        $currentFunc = FormUtil::getPassedValue('func', 'main', 'GETPOST', FILTER_SANITIZE_STRING);

        $this['id'] = (int) ((isset($this['id']) && !empty($this['id'])) ? DataUtil::formatForDisplay($this['id']) : 0);
    if ($currentFunc != 'edit') {
        $this['title'] = ((isset($this['title']) && !empty($this['title'])) ? DataUtil::formatForDisplayHTML($this['title']) : '');
    }
    if ($currentFunc != 'edit') {
        $this['description'] = ((isset($this['description']) && !empty($this['description'])) ? DataUtil::formatForDisplayHTML($this['description']) : '');
    }
        $this['pos'] = (int) ((isset($this['pos']) && !empty($this['pos'])) ? DataUtil::formatForDisplay($this['pos']) : 0);
        $this->prepareItemActions();
        return true;
    }

    /**
     * Pre-Process the data prior to an insert operation.
     * The event happens before the entity managers persist operation is executed for this entity.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - no identifiers available if using an identity generator like sequences
     *     - Doctrine won't recognize changes on relations which are done here
     *       if this method is called by cascade persist
     *     - no creation of other entities allowed
     *
     * @see MUBoard_Entity_Forum::prePersistCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPrePersistCallback()
    {
        // echo 'inserting a record ...';
        $this->validate();
        return true;
    }

    /**
     * Post-Process the data after an insert operation.
     * The event happens after the entity has been made persistant.
     * Will be called after the database insert operations.
     * The generated primary key values are available.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *
     * @see MUBoard_Entity_Forum::postPersistCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPostPersistCallback()
    {
        // echo 'inserted a record ...';
        return true;
    }

    /**
     * Pre-Process the data prior a delete operation.
     * The event happens before the entity managers remove operation is executed for this entity.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - will not be called for a DQL DELETE statement
     *
     * @see MUBoard_Entity_Forum::preRemoveCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPreRemoveCallback()
    {
/*        // delete workflow for this entity
        $result = Zikula_Workflow_Util::deleteWorkflow($this);
        if ($result === false) {
            $dom = ZLanguage::getModuleDomain('MUBoard');
            return LogUtil::registerError(__('Error! Could not remove stored workflow.', $dom));
        }*/
        return true;
    }

    /**
     * Post-Process the data after a delete.
     * The event happens after the entity has been deleted.
     * Will be called after the database delete operations.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - will not be called for a DQL DELETE statement
     *
     * @see MUBoard_Entity_Forum::postRemoveCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPostRemoveCallback()
    {
        // echo 'deleted a record ...';
        return true;
    }

    /**
     * Pre-Process the data prior to an update operation.
     * The event happens before the database update operations for the entity data.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - will not be called for a DQL UPDATE statement
     *     - changes on associations are not allowed and won't be recognized by flush
     *     - changes on properties won't be recognized by flush as well
     *     - no creation of other entities allowed
     *
     * @see MUBoard_Entity_Forum::preUpdateCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPreUpdateCallback()
    {
        // echo 'updating a record ...';
        $this->validate();
        return true;
    }

    /**
     * Post-Process the data after an update operation.
     * The event happens after the database update operations for the entity data.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - will not be called for a DQL UPDATE statement
     *
     * @see MUBoard_Entity_Forum::postUpdateCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPostUpdateCallback()
    {
        // echo 'updated a record ...';
        return true;
    }

    /**
     * Pre-Process the data prior to a save operation.
     * This combines the PrePersist and PreUpdate events.
     * For more information see corresponding callback handlers.
     *
     * @see MUBoard_Entity_Forum::preSaveCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPreSaveCallback()
    {
        // echo 'saving a record ...';
        $this->validate();
        return true;
    }

    /**
     * Post-Process the data after a save operation.
     * This combines the PostPersist and PostUpdate events.
     * For more information see corresponding callback handlers.
     *
     * @see MUBoard_Entity_Forum::postSaveCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPostSaveCallback()
    {
        // echo 'saved a record ...';
        return true;
    }

}

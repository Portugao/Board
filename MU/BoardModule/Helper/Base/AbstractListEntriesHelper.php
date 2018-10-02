<?php
/**
 * Board.
 *
 * @copyright Michael Ueberschaer (MU)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @author Michael Ueberschaer <info@homepages-mit-zikula.de>.
 * @link https://homepages-mit-zikula.de
 * @link https://ziku.la
 * @version Generated by ModuleStudio (https://modulestudio.de).
 */

namespace MU\BoardModule\Helper\Base;

use Zikula\Common\Translator\TranslatorInterface;
use Zikula\Common\Translator\TranslatorTrait;

/**
 * Helper base class for list field entries related methods.
 */
abstract class AbstractListEntriesHelper
{
    use TranslatorTrait;
    
    /**
     * ListEntriesHelper constructor.
     *
     * @param TranslatorInterface $translator Translator service instance
     */
    public function __construct(TranslatorInterface $translator)
    {
        $this->setTranslator($translator);
    }
    
    /**
     * Sets the translator.
     *
     * @param TranslatorInterface $translator Translator service instance
     */
    public function setTranslator(TranslatorInterface $translator)
    {
        $this->translator = $translator;
    }
    
    /**
     * Return the name or names for a given list item.
     *
     * @param string $value      The dropdown value to process
     * @param string $objectType The treated object type
     * @param string $fieldName  The list field's name
     * @param string $delimiter  String used as separator for multiple selections
     *
     * @return string List item name
     */
    public function resolve($value, $objectType = '', $fieldName = '', $delimiter = ', ')
    {
        if ((empty($value) && $value != '0') || empty($objectType) || empty($fieldName)) {
            return $value;
        }
    
        $isMulti = $this->hasMultipleSelection($objectType, $fieldName);
        if (true === $isMulti) {
            $value = $this->extractMultiList($value);
        }
    
        $options = $this->getEntries($objectType, $fieldName);
        $result = '';
    
        if (true === $isMulti) {
            foreach ($options as $option) {
                if (!in_array($option['value'], $value)) {
                    continue;
                }
                if (!empty($result)) {
                    $result .= $delimiter;
                }
                $result .= $option['text'];
            }
        } else {
            foreach ($options as $option) {
                if ($option['value'] != $value) {
                    continue;
                }
                $result = $option['text'];
                break;
            }
        }
    
        return $result;
    }
    
    
    /**
     * Extract concatenated multi selection.
     *
     * @param string $value The dropdown value to process
     *
     * @return array List of single values
     */
    public function extractMultiList($value)
    {
        $listValues = explode('###', $value);
        $amountOfValues = count($listValues);
        if ($amountOfValues > 1 && $listValues[$amountOfValues - 1] == '') {
            unset($listValues[$amountOfValues - 1]);
        }
        if ($listValues[0] == '') {
            // use array_shift instead of unset for proper key reindexing
            // keys must start with 0, otherwise the dropdownlist form plugin gets confused
            array_shift($listValues);
        }
    
        return $listValues;
    }
    
    
    /**
     * Determine whether a certain dropdown field has a multi selection or not.
     *
     * @param string $objectType The treated object type
     * @param string $fieldName  The list field's name
     *
     * @return boolean True if this is a multi list false otherwise
     */
    public function hasMultipleSelection($objectType, $fieldName)
    {
        if (empty($objectType) || empty($fieldName)) {
            return false;
        }
    
        $result = false;
        switch ($objectType) {
            case 'category':
                switch ($fieldName) {
                    case 'workflowState':
                        $result = false;
                        break;
                }
                break;
            case 'forum':
                switch ($fieldName) {
                    case 'workflowState':
                        $result = false;
                        break;
                }
                break;
            case 'posting':
                switch ($fieldName) {
                    case 'workflowState':
                        $result = false;
                        break;
                }
                break;
            case 'abo':
                switch ($fieldName) {
                    case 'workflowState':
                        $result = false;
                        break;
                }
                break;
            case 'user':
                switch ($fieldName) {
                    case 'workflowState':
                        $result = false;
                        break;
                }
                break;
            case 'rank':
                switch ($fieldName) {
                    case 'workflowState':
                        $result = false;
                        break;
                }
                break;
            case 'appSettings':
                switch ($fieldName) {
                    case 'numberImages':
                        $result = false;
                        break;
                    case 'numberFiles':
                        $result = false;
                        break;
                    case 'sortingCategories':
                        $result = false;
                        break;
                    case 'sortingForums':
                        $result = false;
                        break;
                    case 'sortingPostings':
                        $result = false;
                        break;
                    case 'iconSet':
                        $result = false;
                        break;
                    case 'template':
                        $result = false;
                        break;
                    case 'thumbnailModePostingFirstImage':
                        $result = false;
                        break;
                    case 'thumbnailModePostingSecondImage':
                        $result = false;
                        break;
                    case 'thumbnailModePostingThirdImage':
                        $result = false;
                        break;
                    case 'thumbnailModeRankUploadImage':
                        $result = false;
                        break;
                    case 'enabledFinderTypes':
                        $result = true;
                        break;
                }
                break;
        }
    
        return $result;
    }
    
    
    /**
     * Get entries for a certain dropdown field.
     *
     * @param string  $objectType The treated object type
     * @param string  $fieldName  The list field's name
     *
     * @return array Array with desired list entries
     */
    public function getEntries($objectType, $fieldName)
    {
        if (empty($objectType) || empty($fieldName)) {
            return [];
        }
    
        $entries = [];
        switch ($objectType) {
            case 'category':
                switch ($fieldName) {
                    case 'workflowState':
                        $entries = $this->getWorkflowStateEntriesForCategory();
                        break;
                }
                break;
            case 'forum':
                switch ($fieldName) {
                    case 'workflowState':
                        $entries = $this->getWorkflowStateEntriesForForum();
                        break;
                }
                break;
            case 'posting':
                switch ($fieldName) {
                    case 'workflowState':
                        $entries = $this->getWorkflowStateEntriesForPosting();
                        break;
                }
                break;
            case 'abo':
                switch ($fieldName) {
                    case 'workflowState':
                        $entries = $this->getWorkflowStateEntriesForAbo();
                        break;
                }
                break;
            case 'user':
                switch ($fieldName) {
                    case 'workflowState':
                        $entries = $this->getWorkflowStateEntriesForUser();
                        break;
                }
                break;
            case 'rank':
                switch ($fieldName) {
                    case 'workflowState':
                        $entries = $this->getWorkflowStateEntriesForRank();
                        break;
                }
                break;
            case 'appSettings':
                switch ($fieldName) {
                    case 'numberImages':
                        $entries = $this->getNumberImagesEntriesForAppSettings();
                        break;
                    case 'numberFiles':
                        $entries = $this->getNumberFilesEntriesForAppSettings();
                        break;
                    case 'sortingCategories':
                        $entries = $this->getSortingCategoriesEntriesForAppSettings();
                        break;
                    case 'sortingForums':
                        $entries = $this->getSortingForumsEntriesForAppSettings();
                        break;
                    case 'sortingPostings':
                        $entries = $this->getSortingPostingsEntriesForAppSettings();
                        break;
                    case 'iconSet':
                        $entries = $this->getIconSetEntriesForAppSettings();
                        break;
                    case 'template':
                        $entries = $this->getTemplateEntriesForAppSettings();
                        break;
                    case 'thumbnailModePostingFirstImage':
                        $entries = $this->getThumbnailModePostingFirstImageEntriesForAppSettings();
                        break;
                    case 'thumbnailModePostingSecondImage':
                        $entries = $this->getThumbnailModePostingSecondImageEntriesForAppSettings();
                        break;
                    case 'thumbnailModePostingThirdImage':
                        $entries = $this->getThumbnailModePostingThirdImageEntriesForAppSettings();
                        break;
                    case 'thumbnailModeRankUploadImage':
                        $entries = $this->getThumbnailModeRankUploadImageEntriesForAppSettings();
                        break;
                    case 'enabledFinderTypes':
                        $entries = $this->getEnabledFinderTypesEntriesForAppSettings();
                        break;
                }
                break;
        }
    
        return $entries;
    }
    
    
    /**
     * Get 'workflow state' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getWorkflowStateEntriesForCategory()
    {
        $states = [];
        $states[] = [
            'value'   => 'approved',
            'text'    => $this->__('Approved'),
            'title'   => $this->__('Content has been approved and is available online.'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => 'trashed',
            'text'    => $this->__('Trashed'),
            'title'   => $this->__('Content has been marked as deleted, but is still persisted in the database.'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => '!approved',
            'text'    => $this->__('All except approved'),
            'title'   => $this->__('Shows all items except these which are approved'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => '!trashed',
            'text'    => $this->__('All except trashed'),
            'title'   => $this->__('Shows all items except these which are trashed'),
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'workflow state' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getWorkflowStateEntriesForForum()
    {
        $states = [];
        $states[] = [
            'value'   => 'approved',
            'text'    => $this->__('Approved'),
            'title'   => $this->__('Content has been approved and is available online.'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => 'trashed',
            'text'    => $this->__('Trashed'),
            'title'   => $this->__('Content has been marked as deleted, but is still persisted in the database.'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => '!approved',
            'text'    => $this->__('All except approved'),
            'title'   => $this->__('Shows all items except these which are approved'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => '!trashed',
            'text'    => $this->__('All except trashed'),
            'title'   => $this->__('Shows all items except these which are trashed'),
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'workflow state' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getWorkflowStateEntriesForPosting()
    {
        $states = [];
        $states[] = [
            'value'   => 'waiting',
            'text'    => $this->__('Waiting'),
            'title'   => $this->__('Content has been submitted and waits for approval.'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => 'approved',
            'text'    => $this->__('Approved'),
            'title'   => $this->__('Content has been approved and is available online.'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => 'trashed',
            'text'    => $this->__('Trashed'),
            'title'   => $this->__('Content has been marked as deleted, but is still persisted in the database.'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => '!waiting',
            'text'    => $this->__('All except waiting'),
            'title'   => $this->__('Shows all items except these which are waiting'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => '!approved',
            'text'    => $this->__('All except approved'),
            'title'   => $this->__('Shows all items except these which are approved'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => '!trashed',
            'text'    => $this->__('All except trashed'),
            'title'   => $this->__('Shows all items except these which are trashed'),
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'workflow state' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getWorkflowStateEntriesForAbo()
    {
        $states = [];
        $states[] = [
            'value'   => 'approved',
            'text'    => $this->__('Approved'),
            'title'   => $this->__('Content has been approved and is available online.'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => 'trashed',
            'text'    => $this->__('Trashed'),
            'title'   => $this->__('Content has been marked as deleted, but is still persisted in the database.'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => '!approved',
            'text'    => $this->__('All except approved'),
            'title'   => $this->__('Shows all items except these which are approved'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => '!trashed',
            'text'    => $this->__('All except trashed'),
            'title'   => $this->__('Shows all items except these which are trashed'),
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'workflow state' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getWorkflowStateEntriesForUser()
    {
        $states = [];
        $states[] = [
            'value'   => 'approved',
            'text'    => $this->__('Approved'),
            'title'   => $this->__('Content has been approved and is available online.'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => 'trashed',
            'text'    => $this->__('Trashed'),
            'title'   => $this->__('Content has been marked as deleted, but is still persisted in the database.'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => '!approved',
            'text'    => $this->__('All except approved'),
            'title'   => $this->__('Shows all items except these which are approved'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => '!trashed',
            'text'    => $this->__('All except trashed'),
            'title'   => $this->__('Shows all items except these which are trashed'),
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'workflow state' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getWorkflowStateEntriesForRank()
    {
        $states = [];
        $states[] = [
            'value'   => 'approved',
            'text'    => $this->__('Approved'),
            'title'   => $this->__('Content has been approved and is available online.'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => 'trashed',
            'text'    => $this->__('Trashed'),
            'title'   => $this->__('Content has been marked as deleted, but is still persisted in the database.'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => '!approved',
            'text'    => $this->__('All except approved'),
            'title'   => $this->__('Shows all items except these which are approved'),
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => '!trashed',
            'text'    => $this->__('All except trashed'),
            'title'   => $this->__('Shows all items except these which are trashed'),
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'number images' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getNumberImagesEntriesForAppSettings()
    {
        $states = [];
        $states[] = [
            'value'   => '1',
            'text'    => $this->__('1'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
        $states[] = [
            'value'   => '2',
            'text'    => $this->__('2'),
            'title'   => '',
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => '3',
            'text'    => $this->__('3'),
            'title'   => '',
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'number files' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getNumberFilesEntriesForAppSettings()
    {
        $states = [];
        $states[] = [
            'value'   => '1',
            'text'    => $this->__('1'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
        $states[] = [
            'value'   => '2',
            'text'    => $this->__('2'),
            'title'   => '',
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => '3',
            'text'    => $this->__('3'),
            'title'   => '',
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'sorting categories' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getSortingCategoriesEntriesForAppSettings()
    {
        $states = [];
        $states[] = [
            'value'   => 'descending',
            'text'    => $this->__('Descending'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
        $states[] = [
            'value'   => 'ascending',
            'text'    => $this->__('Ascending'),
            'title'   => '',
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'sorting forums' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getSortingForumsEntriesForAppSettings()
    {
        $states = [];
        $states[] = [
            'value'   => 'descending',
            'text'    => $this->__('Descending'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
        $states[] = [
            'value'   => 'ascending',
            'text'    => $this->__('Ascending'),
            'title'   => '',
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'sorting postings' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getSortingPostingsEntriesForAppSettings()
    {
        $states = [];
        $states[] = [
            'value'   => 'descending',
            'text'    => $this->__('Descending'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
        $states[] = [
            'value'   => 'ascending',
            'text'    => $this->__('Ascending'),
            'title'   => '',
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'icon set' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getIconSetEntriesForAppSettings()
    {
        $states = [];
        $states[] = [
            'value'   => '1',
            'text'    => $this->__('1'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
        $states[] = [
            'value'   => '2',
            'text'    => $this->__('2'),
            'title'   => '',
            'image'   => '',
            'default' => false
        ];
        $states[] = [
            'value'   => '3',
            'text'    => $this->__('3'),
            'title'   => '',
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'template' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getTemplateEntriesForAppSettings()
    {
        $states = [];
        $states[] = [
            'value'   => 'normal',
            'text'    => $this->__('Normal'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
        $states[] = [
            'value'   => 'jquery',
            'text'    => $this->__('Jquery'),
            'title'   => '',
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'thumbnail mode posting first image' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getThumbnailModePostingFirstImageEntriesForAppSettings()
    {
        $states = [];
        $states[] = [
            'value'   => 'inset',
            'text'    => $this->__('Inset'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
        $states[] = [
            'value'   => 'outbound',
            'text'    => $this->__('Outbound'),
            'title'   => '',
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'thumbnail mode posting second image' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getThumbnailModePostingSecondImageEntriesForAppSettings()
    {
        $states = [];
        $states[] = [
            'value'   => 'inset',
            'text'    => $this->__('Inset'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
        $states[] = [
            'value'   => 'outbound',
            'text'    => $this->__('Outbound'),
            'title'   => '',
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'thumbnail mode posting third image' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getThumbnailModePostingThirdImageEntriesForAppSettings()
    {
        $states = [];
        $states[] = [
            'value'   => 'inset',
            'text'    => $this->__('Inset'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
        $states[] = [
            'value'   => 'outbound',
            'text'    => $this->__('Outbound'),
            'title'   => '',
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'thumbnail mode rank upload image' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getThumbnailModeRankUploadImageEntriesForAppSettings()
    {
        $states = [];
        $states[] = [
            'value'   => 'inset',
            'text'    => $this->__('Inset'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
        $states[] = [
            'value'   => 'outbound',
            'text'    => $this->__('Outbound'),
            'title'   => '',
            'image'   => '',
            'default' => false
        ];
    
        return $states;
    }
    
    /**
     * Get 'enabled finder types' list entries.
     *
     * @return array Array with desired list entries
     */
    public function getEnabledFinderTypesEntriesForAppSettings()
    {
        $states = [];
        $states[] = [
            'value'   => 'category',
            'text'    => $this->__('Category'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
        $states[] = [
            'value'   => 'forum',
            'text'    => $this->__('Forum'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
        $states[] = [
            'value'   => 'posting',
            'text'    => $this->__('Posting'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
        $states[] = [
            'value'   => 'abo',
            'text'    => $this->__('Abo'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
        $states[] = [
            'value'   => 'user',
            'text'    => $this->__('User'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
        $states[] = [
            'value'   => 'rank',
            'text'    => $this->__('Rank'),
            'title'   => '',
            'image'   => '',
            'default' => true
        ];
    
        return $states;
    }
}

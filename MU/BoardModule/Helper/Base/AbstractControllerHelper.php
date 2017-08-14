<?php
/**
 * Board.
 *
 * @copyright Michael Ueberschaer (MU)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @author Michael Ueberschaer <info@homepages-mit-zikula.de>.
 * @link https://homepages-mit-zikula.de
 * @link http://zikula.org
 * @version Generated by ModuleStudio (https://modulestudio.de).
 */

namespace MU\BoardModule\Helper\Base;

use Psr\Log\LoggerInterface;
use Symfony\Component\Filesystem\Exception\IOExceptionInterface;
use Symfony\Component\Filesystem\Filesystem;
use Symfony\Component\Form\FormFactoryInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\RequestStack;
use Zikula\Common\Translator\TranslatorInterface;
use Zikula\Common\Translator\TranslatorTrait;
use Zikula\Component\SortableColumns\SortableColumns;
use Zikula\Core\RouteUrl;
use Zikula\ExtensionsModule\Api\ApiInterface\VariableApiInterface;
use MU\BoardModule\Entity\Factory\EntityFactory;
use MU\BoardModule\Helper\CollectionFilterHelper;
use MU\BoardModule\Helper\ImageHelper;
use MU\BoardModule\Helper\ModelHelper;

/**
 * Helper base class for controller layer methods.
 */
abstract class AbstractControllerHelper
{
    use TranslatorTrait;

    /**
     * @var Request
     */
    protected $request;

    /**
     * @var LoggerInterface
     */
    protected $logger;

    /**
     * @var FormFactoryInterface
     */
    protected $formFactory;

    /**
     * @var VariableApiInterface
     */
    protected $variableApi;

    /**
     * @var EntityFactory
     */
    protected $entityFactory;

    /**
     * @var CollectionFilterHelper
     */
    protected $collectionFilterHelper;

    /**
     * @var ModelHelper
     */
    protected $modelHelper;

    /**
     * @var ImageHelper
     */
    protected $imageHelper;

    /**
     * ControllerHelper constructor.
     *
     * @param TranslatorInterface $translator      Translator service instance
     * @param RequestStack        $requestStack    RequestStack service instance
     * @param LoggerInterface     $logger          Logger service instance
     * @param FormFactoryInterface $formFactory    FormFactory service instance
     * @param VariableApiInterface $variableApi     VariableApi service instance
     * @param EntityFactory       $entityFactory   EntityFactory service instance
     * @param CollectionFilterHelper $collectionFilterHelper CollectionFilterHelper service instance
     * @param ModelHelper         $modelHelper     ModelHelper service instance
     * @param ImageHelper         $imageHelper     ImageHelper service instance
     */
    public function __construct(
        TranslatorInterface $translator,
        RequestStack $requestStack,
        LoggerInterface $logger,
        FormFactoryInterface $formFactory,
        VariableApiInterface $variableApi,
        EntityFactory $entityFactory,
        CollectionFilterHelper $collectionFilterHelper,
        ModelHelper $modelHelper,
        ImageHelper $imageHelper
    ) {
        $this->setTranslator($translator);
        $this->request = $requestStack->getCurrentRequest();
        $this->logger = $logger;
        $this->formFactory = $formFactory;
        $this->variableApi = $variableApi;
        $this->entityFactory = $entityFactory;
        $this->collectionFilterHelper = $collectionFilterHelper;
        $this->modelHelper = $modelHelper;
        $this->imageHelper = $imageHelper;
    }

    /**
     * Sets the translator.
     *
     * @param TranslatorInterface $translator Translator service instance
     */
    public function setTranslator(/*TranslatorInterface */$translator)
    {
        $this->translator = $translator;
    }

    /**
     * Returns an array of all allowed object types in MUBoardModule.
     *
     * @param string $context Usage context (allowed values: controllerAction, api, helper, actionHandler, block, contentType, util)
     * @param array  $args    Additional arguments
     *
     * @return string[] List of allowed object types
     */
    public function getObjectTypes($context = '', array $args = [])
    {
        if (!in_array($context, ['controllerAction', 'api', 'helper', 'actionHandler', 'block', 'contentType', 'util'])) {
            $context = 'controllerAction';
        }
    
        $allowedObjectTypes = [];
        $allowedObjectTypes[] = 'category';
        $allowedObjectTypes[] = 'forum';
        $allowedObjectTypes[] = 'posting';
        $allowedObjectTypes[] = 'abo';
        $allowedObjectTypes[] = 'user';
        $allowedObjectTypes[] = 'rank';
    
        return $allowedObjectTypes;
    }

    /**
     * Returns the default object type in MUBoardModule.
     *
     * @param string $context Usage context (allowed values: controllerAction, api, helper, actionHandler, block, contentType, util)
     * @param array  $args    Additional arguments
     *
     * @return string The name of the default object type
     */
    public function getDefaultObjectType($context = '', array $args = [])
    {
        if (!in_array($context, ['controllerAction', 'api', 'helper', 'actionHandler', 'block', 'contentType', 'util'])) {
            $context = 'controllerAction';
        }
    
        return 'category';
    }

    /**
     * Processes the parameters for a view action.
     * This includes handling pagination, quick navigation forms and other aspects.
     *
     * @param string          $objectType         Name of treated entity type
     * @param SortableColumns $sortableColumns    Used SortableColumns instance
     * @param array           $templateParameters Template data
     * @param boolean         $hasHookSubscriber  Whether hook subscribers are supported or not
     *
     * @return array Enriched template parameters used for creating the response
     */
    public function processViewActionParameters($objectType, SortableColumns $sortableColumns, array $templateParameters = [], $hasHookSubscriber = false)
    {
        $contextArgs = ['controller' => $objectType, 'action' => 'view'];
        if (!in_array($objectType, $this->getObjectTypes('controllerAction', $contextArgs))) {
            throw new \Exception($this->__('Error! Invalid object type received.'));
        }
    
        $request = $this->request;
        $repository = $this->entityFactory->getRepository($objectType);
    
        // parameter for used sorting field
        $sort = $request->query->get('sort', '');
        if (empty($sort) || !in_array($sort, $repository->getAllowedSortingFields())) {
            $sort = $repository->getDefaultSortingField();
            $request->query->set('sort', $sort);
            // set default sorting in route parameters (e.g. for the pager)
            $routeParams = $request->attributes->get('_route_params');
            $routeParams['sort'] = $sort;
            $request->attributes->set('_route_params', $routeParams);
        }
        $sortdir = $request->query->get('sortdir', 'ASC');
        $templateParameters['sort'] = $sort;
        $templateParameters['sortdir'] = strtolower($sortdir);
    
        $templateParameters['all'] = 'csv' == $request->getRequestFormat() ? 1 : $request->query->getInt('all', 0);
        $templateParameters['own'] = $request->query->getInt('own', $this->variableApi->get('MUBoardModule', 'showOnlyOwnEntries', 0));
    
        $resultsPerPage = 0;
        if ($templateParameters['all'] != 1) {
            // the number of items displayed on a page for pagination
            $resultsPerPage = $request->query->getInt('num', 0);
            if (in_array($resultsPerPage, [0, 10])) {
                $resultsPerPage = $this->variableApi->get('MUBoardModule', $objectType . 'EntriesPerPage', 10);
            }
        }
        $templateParameters['num'] = $resultsPerPage;
        $templateParameters['tpl'] = $request->query->getAlnum('tpl', '');
    
        $templateParameters = $this->addTemplateParameters($objectType, $templateParameters, 'controllerAction', $contextArgs);
    
        $quickNavForm = $this->formFactory->create('MU\BoardModule\Form\Type\QuickNavigation\\' . ucfirst($objectType) . 'QuickNavType', $templateParameters);
        if ($quickNavForm->handleRequest($request) && $quickNavForm->isSubmitted()) {
            $quickNavData = $quickNavForm->getData();
            foreach ($quickNavData as $fieldName => $fieldValue) {
                if ($fieldName == 'routeArea') {
                    continue;
                }
                if (in_array($fieldName, ['all', 'own', 'num'])) {
                    $templateParameters[$fieldName] = $fieldValue;
                } elseif ($fieldName == 'sort' && !empty($fieldValue)) {
                    $sort = $fieldValue;
                } elseif ($fieldName == 'sortdir' && !empty($fieldValue)) {
                    $sortdir = $fieldValue;
                } else {
                    // set filter as query argument, fetched inside repository
                    $request->query->set($fieldName, $fieldValue);
                }
            }
        }
        $sortableColumns->setOrderBy($sortableColumns->getColumn($sort), strtoupper($sortdir));
    
        $urlParameters = $templateParameters;
        foreach ($urlParameters as $parameterName => $parameterValue) {
            if (false !== stripos($parameterName, 'thumbRuntimeOptions')) {
                unset($urlParameters[$parameterName]);
            }
        }
    
        $sort = $sortableColumns->getSortColumn()->getName();
        $sortdir = $sortableColumns->getSortDirection();
        $sortableColumns->setAdditionalUrlParameters($urlParameters);
    
        $where = '';
        if ($templateParameters['all'] == 1) {
            // retrieve item list without pagination
            $entities = $repository->selectWhere($where, $sort . ' ' . $sortdir);
        } else {
            // the current offset which is used to calculate the pagination
            $currentPage = $request->query->getInt('pos', 1);
    
            // retrieve item list with pagination
            list($entities, $objectCount) = $repository->selectWherePaginated($where, $sort . ' ' . $sortdir, $currentPage, $resultsPerPage);
    
            $templateParameters['currentPage'] = $currentPage;
            $templateParameters['pager'] = [
                'amountOfItems' => $objectCount,
                'itemsPerPage' => $resultsPerPage
            ];
        }
    
        $templateParameters['sort'] = $sort;
        $templateParameters['sortdir'] = $sortdir;
        $templateParameters['items'] = $entities;
    
    
        if (true === $hasHookSubscriber) {
            // build RouteUrl instance for display hooks
            $urlParameters['_locale'] = $request->getLocale();
            $templateParameters['currentUrlObject'] = new RouteUrl('muboardmodule_' . strtolower($objectType) . '_view', $urlParameters);
        }
    
        $templateParameters['sort'] = $sortableColumns->generateSortableColumns();
        $templateParameters['quickNavForm'] = $quickNavForm->createView();
    
        $templateParameters['canBeCreated'] = $this->modelHelper->canBeCreated($objectType);
    
        return $templateParameters;
    }

    /**
     * Processes the parameters for a display action.
     *
     * @param string  $objectType         Name of treated entity type
     * @param array   $templateParameters Template data
     * @param boolean $hasHookSubscriber  Whether hook subscribers are supported or not
     *
     * @return array Enriched template parameters used for creating the response
     */
    public function processDisplayActionParameters($objectType, array $templateParameters = [], $hasHookSubscriber = false)
    {
        $contextArgs = ['controller' => $objectType, 'action' => 'display'];
        if (!in_array($objectType, $this->getObjectTypes('controllerAction', $contextArgs))) {
            throw new \Exception($this->__('Error! Invalid object type received.'));
        }
    
        if (true === $hasHookSubscriber) {
            // build RouteUrl instance for display hooks
            $entity = $templateParameters[$objectType];
            $urlParameters = $entity->createUrlArgs();
            $urlParameters['_locale'] = $this->request->getLocale();
            $templateParameters['currentUrlObject'] = new RouteUrl('muboardmodule_' . strtolower($objectType) . '_display', $urlParameters);
        }
    
        return $this->addTemplateParameters($objectType, $templateParameters, 'controllerAction', $contextArgs);
    }

    /**
     * Processes the parameters for an edit action.
     *
     * @param string  $objectType         Name of treated entity type
     * @param array   $templateParameters Template data
     *
     * @return array Enriched template parameters used for creating the response
     */
    public function processEditActionParameters($objectType, array $templateParameters = [])
    {
        $contextArgs = ['controller' => $objectType, 'action' => 'edit'];
        if (!in_array($objectType, $this->getObjectTypes('controllerAction', $contextArgs))) {
            throw new \Exception($this->__('Error! Invalid object type received.'));
        }
    
        return $this->addTemplateParameters($objectType, $templateParameters, 'controllerAction', $contextArgs);
    }

    /**
     * Processes the parameters for a delete action.
     *
     * @param string  $objectType         Name of treated entity type
     * @param array   $templateParameters Template data
     * @param boolean $hasHookSubscriber  Whether hook subscribers are supported or not
     *
     * @return array Enriched template parameters used for creating the response
     */
    public function processDeleteActionParameters($objectType, array $templateParameters = [], $hasHookSubscriber = false)
    {
        $contextArgs = ['controller' => $objectType, 'action' => 'delete'];
        if (!in_array($objectType, $this->getObjectTypes('controllerAction', $contextArgs))) {
            throw new \Exception($this->__('Error! Invalid object type received.'));
        }
    
        return $this->addTemplateParameters($objectType, $templateParameters, 'controllerAction', $contextArgs);
    }

    /**
     * Returns an array of additional template variables which are specific to the object type.
     *
     * @param string $objectType Name of treated entity type
     * @param array  $parameters Given parameters to enrich
     * @param string $context    Usage context (allowed values: controllerAction, api, actionHandler, block, contentType)
     * @param array  $args       Additional arguments
     *
     * @return array List of template variables to be assigned
     */
    public function addTemplateParameters($objectType = '', array $parameters = [], $context = '', array $args = [])
    {
        if (!in_array($context, ['controllerAction', 'api', 'actionHandler', 'block', 'contentType', 'mailz'])) {
            $context = 'controllerAction';
        }
    
        if ($context == 'controllerAction') {
            if (!isset($args['action'])) {
                $routeName = $this->request->get('_route');
                $routeNameParts = explode('_', $routeName);
                $args['action'] = end($routeNameParts);
            }
            if (in_array($args['action'], ['index', 'view'])) {
                $parameters = array_merge($parameters, $this->collectionFilterHelper->getViewQuickNavParameters($objectType, $context, $args));
            }
    
            // initialise Imagine runtime options
            if ($objectType == 'posting') {
                $thumbRuntimeOptions = [];
                $thumbRuntimeOptions[$objectType . 'FirstImage'] = $this->imageHelper->getRuntimeOptions($objectType, 'firstImage', $context, $args);
                $thumbRuntimeOptions[$objectType . 'SecondImage'] = $this->imageHelper->getRuntimeOptions($objectType, 'secondImage', $context, $args);
                $thumbRuntimeOptions[$objectType . 'ThirdImage'] = $this->imageHelper->getRuntimeOptions($objectType, 'thirdImage', $context, $args);
                $thumbRuntimeOptions[$objectType . 'FirstFile'] = $this->imageHelper->getRuntimeOptions($objectType, 'firstFile', $context, $args);
                $thumbRuntimeOptions[$objectType . 'SecondFile'] = $this->imageHelper->getRuntimeOptions($objectType, 'secondFile', $context, $args);
                $thumbRuntimeOptions[$objectType . 'ThirdFile'] = $this->imageHelper->getRuntimeOptions($objectType, 'thirdFile', $context, $args);
                $parameters['thumbRuntimeOptions'] = $thumbRuntimeOptions;
            }
            if ($objectType == 'rank') {
                $thumbRuntimeOptions = [];
                $thumbRuntimeOptions[$objectType . 'UploadImage'] = $this->imageHelper->getRuntimeOptions($objectType, 'uploadImage', $context, $args);
                $parameters['thumbRuntimeOptions'] = $thumbRuntimeOptions;
            }
            if (in_array($args['action'], ['display', 'edit', 'view'])) {
                // use separate preset for images in related items
                $parameters['relationThumbRuntimeOptions'] = $this->imageHelper->getCustomRuntimeOptions('', '', 'MUBoardModule_relateditem', $context, $args);
            }
        }
    
        return $parameters;
    }
}
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

namespace MU\BoardModule\Controller\Base;

use RuntimeException;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Symfony\Component\Security\Core\Exception\AccessDeniedException;
use Zikula\Bundle\FormExtensionBundle\Form\Type\DeletionType;
use Zikula\Bundle\HookBundle\Category\FormAwareCategory;
use Zikula\Bundle\HookBundle\Category\UiHooksCategory;
use Zikula\Component\SortableColumns\Column;
use Zikula\Component\SortableColumns\SortableColumns;
use Zikula\Core\Controller\AbstractController;
use Zikula\Core\RouteUrl;
use MU\BoardModule\Entity\PostingEntity;

/**
 * Posting controller base class.
 */
abstract class AbstractPostingController extends AbstractController
{
    /**
     * This is the default action handling the main admin area called without defining arguments.
     *
     * @param Request $request Current request instance
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     */
    public function adminIndexAction(Request $request)
    {
        return $this->indexInternal($request, true);
    }
    
    /**
     * This is the default action handling the main area called without defining arguments.
     *
     * @param Request $request Current request instance
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     */
    public function indexAction(Request $request)
    {
        return $this->indexInternal($request, false);
    }
    
    /**
     * This method includes the common implementation code for adminIndex() and index().
     */
    protected function indexInternal(Request $request, $isAdmin = false)
    {
        $objectType = 'posting';
        // permission check
        $permLevel = $isAdmin ? ACCESS_ADMIN : ACCESS_OVERVIEW;
        $permissionHelper = $this->get('mu_board_module.permission_helper');
        if (!$permissionHelper->hasComponentPermission($objectType, $permLevel)) {
            throw new AccessDeniedException();
        }
        
        $templateParameters = [
            'routeArea' => $isAdmin ? 'admin' : ''
        ];
        
        return $this->redirectToRoute('muboardmodule_posting_' . $templateParameters['routeArea'] . 'view');
    }
    
    /**
     * This action provides an item list overview in the admin area.
     *
     * @param Request $request Current request instance
     * @param string $sort         Sorting field
     * @param string $sortdir      Sorting direction
     * @param int    $pos          Current pager position
     * @param int    $num          Amount of entries to display
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     */
    public function adminViewAction(Request $request, $sort, $sortdir, $pos, $num)
    {
        return $this->viewInternal($request, $sort, $sortdir, $pos, $num, true);
    }
    
    /**
     * This action provides an item list overview.
     *
     * @param Request $request Current request instance
     * @param string $sort         Sorting field
     * @param string $sortdir      Sorting direction
     * @param int    $pos          Current pager position
     * @param int    $num          Amount of entries to display
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     */
    public function viewAction(Request $request, $sort, $sortdir, $pos, $num)
    {
        return $this->viewInternal($request, $sort, $sortdir, $pos, $num, false);
    }
    
    /**
     * This method includes the common implementation code for adminView() and view().
     */
    protected function viewInternal(Request $request, $sort, $sortdir, $pos, $num, $isAdmin = false)
    {
        $objectType = 'posting';
        // permission check
        $permLevel = $isAdmin ? ACCESS_ADMIN : ACCESS_READ;
        $permissionHelper = $this->get('mu_board_module.permission_helper');
        if (!$permissionHelper->hasComponentPermission($objectType, $permLevel)) {
            throw new AccessDeniedException();
        }
        
        $templateParameters = [
            'routeArea' => $isAdmin ? 'admin' : ''
        ];
        $controllerHelper = $this->get('mu_board_module.controller_helper');
        $viewHelper = $this->get('mu_board_module.view_helper');
        
        $request->query->set('sort', $sort);
        $request->query->set('sortdir', $sortdir);
        $request->query->set('pos', $pos);
        
        $sortableColumns = new SortableColumns($this->get('router'), 'muboardmodule_posting_' . ($isAdmin ? 'admin' : '') . 'view', 'sort', 'sortdir');
        
        $sortableColumns->addColumns([
            new Column('workflowState'),
            new Column('parent_id'),
            new Column('title'),
            new Column('text'),
            new Column('invocations'),
            new Column('firstImage'),
            new Column('firstFile'),
            new Column('parent'),
            new Column('forum'),
            new Column('createdBy'),
            new Column('createdDate'),
            new Column('updatedBy'),
            new Column('updatedDate'),
        ]);
        
        $templateParameters = $controllerHelper->processViewActionParameters($objectType, $sortableColumns, $templateParameters, true);
        
        // filter by permissions
        $filteredEntities = [];
        foreach ($templateParameters['items'] as $posting) {
            if (!$permissionHelper->hasEntityPermission($posting, $permLevel)) {
                continue;
            }
            $filteredEntities[] = $posting;
        }
        $templateParameters['items'] = $filteredEntities;
        
        // fetch and return the appropriate template
        return $viewHelper->processTemplate($objectType, 'view', $templateParameters);
    }
    
    /**
     * This action provides a item detail view in the admin area.
     *
     * @param Request $request Current request instance
     * @param PostingEntity $posting Treated posting instance
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     * @throws NotFoundHttpException Thrown by param converter if posting to be displayed isn't found
     */
    public function adminDisplayAction(Request $request, PostingEntity $posting)
    {
        return $this->displayInternal($request, $posting, true);
    }
    
    /**
     * This action provides a item detail view.
     *
     * @param Request $request Current request instance
     * @param PostingEntity $posting Treated posting instance
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     * @throws NotFoundHttpException Thrown by param converter if posting to be displayed isn't found
     */
    public function displayAction(Request $request, PostingEntity $posting)
    {
        return $this->displayInternal($request, $posting, false);
    }
    
    /**
     * This method includes the common implementation code for adminDisplay() and display().
     */
    protected function displayInternal(Request $request, PostingEntity $posting, $isAdmin = false)
    {
        $objectType = 'posting';
        // permission check
        $permLevel = $isAdmin ? ACCESS_ADMIN : ACCESS_READ;
        $permissionHelper = $this->get('mu_board_module.permission_helper');
        if (!$permissionHelper->hasEntityPermission($posting, $permLevel)) {
            throw new AccessDeniedException();
        }
        
        if ($posting->getWorkflowState() != 'approved' && !$permissionHelper->hasEntityPermission($posting, ACCESS_ADMIN)) {
            throw new AccessDeniedException();
        }
        
        $templateParameters = [
            'routeArea' => $isAdmin ? 'admin' : '',
            $objectType => $posting
        ];
        
        $controllerHelper = $this->get('mu_board_module.controller_helper');
        $templateParameters = $controllerHelper->processDisplayActionParameters($objectType, $templateParameters, true);
        
        // fetch and return the appropriate template
        $response = $this->get('mu_board_module.view_helper')->processTemplate($objectType, 'display', $templateParameters);
        
        return $response;
    }
    
    /**
     * This action provides a handling of edit requests in the admin area.
     *
     * @param Request $request Current request instance
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     * @throws NotFoundHttpException Thrown by form handler if posting to be edited isn't found
     * @throws RuntimeException      Thrown if another critical error occurs (e.g. workflow actions not available)
     */
    public function adminEditAction(Request $request)
    {
        return $this->editInternal($request, true);
    }
    
    /**
     * This action provides a handling of edit requests.
     *
     * @param Request $request Current request instance
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     * @throws NotFoundHttpException Thrown by form handler if posting to be edited isn't found
     * @throws RuntimeException      Thrown if another critical error occurs (e.g. workflow actions not available)
     */
    public function editAction(Request $request)
    {
        return $this->editInternal($request, false);
    }
    
    /**
     * This method includes the common implementation code for adminEdit() and edit().
     */
    protected function editInternal(Request $request, $isAdmin = false)
    {
        $objectType = 'posting';
        // permission check
        $permLevel = $isAdmin ? ACCESS_ADMIN : ACCESS_EDIT;
        $permissionHelper = $this->get('mu_board_module.permission_helper');
        if (!$permissionHelper->hasComponentPermission($objectType, $permLevel)) {
            throw new AccessDeniedException();
        }
        
        $templateParameters = [
            'routeArea' => $isAdmin ? 'admin' : ''
        ];
        
        $controllerHelper = $this->get('mu_board_module.controller_helper');
        $templateParameters = $controllerHelper->processEditActionParameters($objectType, $templateParameters);
        
        // delegate form processing to the form handler
        $formHandler = $this->get('mu_board_module.form.handler.posting');
        $result = $formHandler->processForm($templateParameters);
        if ($result instanceof RedirectResponse) {
            return $result;
        }
        
        $templateParameters = $formHandler->getTemplateParameters();
        
        // fetch and return the appropriate template
        return $this->get('mu_board_module.view_helper')->processTemplate($objectType, 'edit', $templateParameters);
    }
    
    /**
     * This action provides a handling of simple delete requests in the admin area.
     *
     * @param Request $request Current request instance
     * @param PostingEntity $posting Treated posting instance
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     * @throws NotFoundHttpException Thrown by param converter if posting to be deleted isn't found
     * @throws RuntimeException      Thrown if another critical error occurs (e.g. workflow actions not available)
     */
    public function adminDeleteAction(Request $request, PostingEntity $posting)
    {
        return $this->deleteInternal($request, $posting, true);
    }
    
    /**
     * This action provides a handling of simple delete requests.
     *
     * @param Request $request Current request instance
     * @param PostingEntity $posting Treated posting instance
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     * @throws NotFoundHttpException Thrown by param converter if posting to be deleted isn't found
     * @throws RuntimeException      Thrown if another critical error occurs (e.g. workflow actions not available)
     */
    public function deleteAction(Request $request, PostingEntity $posting)
    {
        return $this->deleteInternal($request, $posting, false);
    }
    
    /**
     * This method includes the common implementation code for adminDelete() and delete().
     */
    protected function deleteInternal(Request $request, PostingEntity $posting, $isAdmin = false)
    {
        $objectType = 'posting';
        // permission check
        $permLevel = $isAdmin ? ACCESS_ADMIN : ACCESS_DELETE;
        $permissionHelper = $this->get('mu_board_module.permission_helper');
        if (!$permissionHelper->hasEntityPermission($posting, $permLevel)) {
            throw new AccessDeniedException();
        }
        
        $logger = $this->get('logger');
        $logArgs = ['app' => 'MUBoardModule', 'user' => $this->get('zikula_users_module.current_user')->get('uname'), 'entity' => 'posting', 'id' => $posting->getKey()];
        
        // determine available workflow actions
        $workflowHelper = $this->get('mu_board_module.workflow_helper');
        $actions = $workflowHelper->getActionsForObject($posting);
        if (false === $actions || !is_array($actions)) {
            $this->addFlash('error', $this->__('Error! Could not determine workflow actions.'));
            $logger->error('{app}: User {user} tried to delete the {entity} with id {id}, but failed to determine available workflow actions.', $logArgs);
            throw new \RuntimeException($this->__('Error! Could not determine workflow actions.'));
        }
        
        // redirect to the list of postings
        $redirectRoute = 'muboardmodule_posting_' . ($isAdmin ? 'admin' : '') . 'view';
        
        // check whether deletion is allowed
        $deleteActionId = 'delete';
        $deleteAllowed = false;
        foreach ($actions as $actionId => $action) {
            if ($actionId != $deleteActionId) {
                continue;
            }
            $deleteAllowed = true;
            break;
        }
        if (!$deleteAllowed) {
            $this->addFlash('error', $this->__('Error! It is not allowed to delete this posting.'));
            $logger->error('{app}: User {user} tried to delete the {entity} with id {id}, but this action was not allowed.', $logArgs);
        
            return $this->redirectToRoute($redirectRoute);
        }
        
        $form = $this->createForm(DeletionType::class, $posting);
        $hookHelper = $this->get('mu_board_module.hook_helper');
        
        // Call form aware display hooks
        $formHook = $hookHelper->callFormDisplayHooks($form, $posting, FormAwareCategory::TYPE_DELETE);
        
        if ($form->handleRequest($request)->isValid()) {
            if ($form->get('delete')->isClicked()) {
                // Let any ui hooks perform additional validation actions
                $validationErrors = $hookHelper->callValidationHooks($posting, UiHooksCategory::TYPE_VALIDATE_DELETE);
                if (count($validationErrors) > 0) {
                    foreach ($validationErrors as $message) {
                        $this->addFlash('error', $message);
                    }
                } else {
                    // execute the workflow action
                    $success = $workflowHelper->executeAction($posting, $deleteActionId);
                    if ($success) {
                        $this->addFlash('status', $this->__('Done! Item deleted.'));
                        $logger->notice('{app}: User {user} deleted the {entity} with id {id}.', $logArgs);
                    }
                    
                    // Call form aware processing hooks
                    $hookHelper->callFormProcessHooks($form, $posting, FormAwareCategory::TYPE_PROCESS_DELETE);
                    
                    // Let any ui hooks know that we have deleted the posting
                    $hookHelper->callProcessHooks($posting, UiHooksCategory::TYPE_PROCESS_DELETE);
                    
                    return $this->redirectToRoute($redirectRoute);
                }
            } elseif ($form->get('cancel')->isClicked()) {
                $this->addFlash('status', $this->__('Operation cancelled.'));
        
                return $this->redirectToRoute($redirectRoute);
            }
        }
        
        $templateParameters = [
            'routeArea' => $isAdmin ? 'admin' : '',
            'deleteForm' => $form->createView(),
            $objectType => $posting,
            'formHookTemplates' => $formHook->getTemplates()
        ];
        
        $controllerHelper = $this->get('mu_board_module.controller_helper');
        $templateParameters = $controllerHelper->processDeleteActionParameters($objectType, $templateParameters, true);
        
        // fetch and return the appropriate template
        return $this->get('mu_board_module.view_helper')->processTemplate($objectType, 'delete', $templateParameters);
    }
    
    /**
     * Process status changes for multiple items.
     *
     * This function processes the items selected in the admin view page.
     * Multiple items may have their state changed or be deleted.
     *
     * @param Request $request Current request instance
     *
     * @return RedirectResponse
     *
     * @throws RuntimeException Thrown if executing the workflow action fails
     */
    public function adminHandleSelectedEntriesAction(Request $request)
    {
        return $this->handleSelectedEntriesActionInternal($request, true);
    }
    
    /**
     * Process status changes for multiple items.
     *
     * This function processes the items selected in the admin view page.
     * Multiple items may have their state changed or be deleted.
     *
     * @param Request $request Current request instance
     *
     * @return RedirectResponse
     *
     * @throws RuntimeException Thrown if executing the workflow action fails
     */
    public function handleSelectedEntriesAction(Request $request)
    {
        return $this->handleSelectedEntriesActionInternal($request, false);
    }
    
    /**
     * This method includes the common implementation code for adminHandleSelectedEntriesAction() and handleSelectedEntriesAction().
     *
     * @param Request $request Current request instance
     * @param boolean $isAdmin Whether the admin area is used or not
     */
    protected function handleSelectedEntriesActionInternal(Request $request, $isAdmin = false)
    {
        $objectType = 'posting';
        
        // Get parameters
        $action = $request->request->get('action', null);
        $items = $request->request->get('items', null);
        
        $action = strtolower($action);
        
        $repository = $this->get('mu_board_module.entity_factory')->getRepository($objectType);
        $workflowHelper = $this->get('mu_board_module.workflow_helper');
        $hookHelper = $this->get('mu_board_module.hook_helper');
        $logger = $this->get('logger');
        $userName = $this->get('zikula_users_module.current_user')->get('uname');
        
        // process each item
        foreach ($items as $itemId) {
            // check if item exists, and get record instance
            $entity = $repository->selectById($itemId, false);
            if (null === $entity) {
                continue;
            }
        
            // check if $action can be applied to this entity (may depend on it's current workflow state)
            $allowedActions = $workflowHelper->getActionsForObject($entity);
            $actionIds = array_keys($allowedActions);
            if (!in_array($action, $actionIds)) {
                // action not allowed, skip this object
                continue;
            }
        
            // Let any ui hooks perform additional validation actions
            $hookType = $action == 'delete' ? UiHooksCategory::TYPE_VALIDATE_DELETE : UiHooksCategory::TYPE_VALIDATE_EDIT;
            $validationErrors = $hookHelper->callValidationHooks($entity, $hookType);
            if (count($validationErrors) > 0) {
                foreach ($validationErrors as $message) {
                    $this->addFlash('error', $message);
                }
                continue;
            }
        
            $success = false;
            try {
                // execute the workflow action
                $success = $workflowHelper->executeAction($entity, $action);
            } catch (\Exception $exception) {
                $this->addFlash('error', $this->__f('Sorry, but an error occured during the %action% action.', ['%action%' => $action]) . '  ' . $exception->getMessage());
                $logger->error('{app}: User {user} tried to execute the {action} workflow action for the {entity} with id {id}, but failed. Error details: {errorMessage}.', ['app' => 'MUBoardModule', 'user' => $userName, 'action' => $action, 'entity' => 'posting', 'id' => $itemId, 'errorMessage' => $exception->getMessage()]);
            }
        
            if (!$success) {
                continue;
            }
        
            if ($action == 'delete') {
                $this->addFlash('status', $this->__('Done! Item deleted.'));
                $logger->notice('{app}: User {user} deleted the {entity} with id {id}.', ['app' => 'MUBoardModule', 'user' => $userName, 'entity' => 'posting', 'id' => $itemId]);
            } else {
                $this->addFlash('status', $this->__('Done! Item updated.'));
                $logger->notice('{app}: User {user} executed the {action} workflow action for the {entity} with id {id}.', ['app' => 'MUBoardModule', 'user' => $userName, 'action' => $action, 'entity' => 'posting', 'id' => $itemId]);
            }
        
            // Let any ui hooks know that we have updated or deleted an item
            $hookType = $action == 'delete' ? UiHooksCategory::TYPE_PROCESS_DELETE : UiHooksCategory::TYPE_PROCESS_EDIT;
            $url = null;
            if ($action != 'delete') {
                $urlArgs = $entity->createUrlArgs();
                $urlArgs['_locale'] = $request->getLocale();
                $url = new RouteUrl('muboardmodule_posting_display', $urlArgs);
            }
            $hookHelper->callProcessHooks($entity, $hookType, $url);
        }
        
        return $this->redirectToRoute('muboardmodule_posting_' . ($isAdmin ? 'admin' : '') . 'index');
    }
    
}

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

namespace MU\BoardModule\Container\Base;

use Symfony\Component\Routing\RouterInterface;
use Zikula\Common\Translator\TranslatorInterface;
use Zikula\Common\Translator\TranslatorTrait;
use Zikula\Core\Doctrine\EntityAccess;
use Zikula\Core\LinkContainer\LinkContainerInterface;
use Zikula\ExtensionsModule\Api\ApiInterface\VariableApiInterface;
use MU\BoardModule\Helper\ControllerHelper;
use MU\BoardModule\Helper\PermissionHelper;

/**
 * This is the link container service implementation class.
 */
abstract class AbstractLinkContainer implements LinkContainerInterface
{
    use TranslatorTrait;

    /**
     * @var RouterInterface
     */
    protected $router;

    /**
     * @var VariableApiInterface
     */
    protected $variableApi;

    /**
     * @var ControllerHelper
     */
    protected $controllerHelper;

    /**
     * @var PermissionHelper
     */
    protected $permissionHelper;

    /**
     * LinkContainer constructor.
     *
     * @param TranslatorInterface  $translator       Translator service instance
     * @param Routerinterface      $router           Router service instance
     * @param VariableApiInterface $variableApi      VariableApi service instance
     * @param ControllerHelper     $controllerHelper ControllerHelper service instance
     * @param PermissionHelper     $permissionHelper PermissionHelper service instance
     */
    public function __construct(
        TranslatorInterface $translator,
        RouterInterface $router,
        VariableApiInterface $variableApi,
        ControllerHelper $controllerHelper,
        PermissionHelper $permissionHelper
    ) {
        $this->setTranslator($translator);
        $this->router = $router;
        $this->variableApi = $variableApi;
        $this->controllerHelper = $controllerHelper;
        $this->permissionHelper = $permissionHelper;
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
     * Returns available header links.
     *
     * @param string $type The type to collect links for
     *
     * @return array List of header links
     */
    public function getLinks($type = LinkContainerInterface::TYPE_ADMIN)
    {
        $contextArgs = ['api' => 'linkContainer', 'action' => 'getLinks'];
        $allowedObjectTypes = $this->controllerHelper->getObjectTypes('api', $contextArgs);

        $permLevel = LinkContainerInterface::TYPE_ADMIN == $type ? ACCESS_ADMIN : ACCESS_READ;

        // Create an array of links to return
        $links = [];

        if (LinkContainerInterface::TYPE_ACCOUNT == $type) {
            if (!$this->permissionHelper->hasPermission(ACCESS_OVERVIEW)) {
                return $links;
            }

            if (true === $this->variableApi->get('MUBoardModule', 'linkOwnCategoriesOnAccountPage', true)) {
                $objectType = 'category';
                if ($this->permissionHelper->hasComponentPermission($objectType, ACCESS_READ)) {
                    $links[] = [
                        'url' => $this->router->generate('muboardmodule_' . strtolower($objectType) . '_view', ['own' => 1]),
                        'text' => $this->__('My categories', 'muboardmodule'),
                        'icon' => 'list-alt'
                    ];
                }
            }

            if (true === $this->variableApi->get('MUBoardModule', 'linkOwnForumsOnAccountPage', true)) {
                $objectType = 'forum';
                if ($this->permissionHelper->hasComponentPermission($objectType, ACCESS_READ)) {
                    $links[] = [
                        'url' => $this->router->generate('muboardmodule_' . strtolower($objectType) . '_view', ['own' => 1]),
                        'text' => $this->__('My forums', 'muboardmodule'),
                        'icon' => 'list-alt'
                    ];
                }
            }

            if (true === $this->variableApi->get('MUBoardModule', 'linkOwnPostingsOnAccountPage', true)) {
                $objectType = 'posting';
                if ($this->permissionHelper->hasComponentPermission($objectType, ACCESS_READ)) {
                    $links[] = [
                        'url' => $this->router->generate('muboardmodule_' . strtolower($objectType) . '_view', ['own' => 1]),
                        'text' => $this->__('My postings', 'muboardmodule'),
                        'icon' => 'list-alt'
                    ];
                }
            }

            if (true === $this->variableApi->get('MUBoardModule', 'linkOwnAbosOnAccountPage', true)) {
                $objectType = 'abo';
                if ($this->permissionHelper->hasComponentPermission($objectType, ACCESS_READ)) {
                    $links[] = [
                        'url' => $this->router->generate('muboardmodule_' . strtolower($objectType) . '_view', ['own' => 1]),
                        'text' => $this->__('My abos', 'muboardmodule'),
                        'icon' => 'list-alt'
                    ];
                }
            }

            if (true === $this->variableApi->get('MUBoardModule', 'linkOwnRanksOnAccountPage', true)) {
                $objectType = 'rank';
                if ($this->permissionHelper->hasComponentPermission($objectType, ACCESS_READ)) {
                    $links[] = [
                        'url' => $this->router->generate('muboardmodule_' . strtolower($objectType) . '_view', ['own' => 1]),
                        'text' => $this->__('My ranks', 'muboardmodule'),
                        'icon' => 'list-alt'
                    ];
                }
            }

            if ($this->permissionHelper->hasPermission(ACCESS_ADMIN)) {
                $links[] = [
                    'url' => $this->router->generate('muboardmodule_category_adminindex'),
                    'text' => $this->__('Board Backend', 'muboardmodule'),
                    'icon' => 'wrench'
                ];
            }


            return $links;
        }

        $routeArea = LinkContainerInterface::TYPE_ADMIN == $type ? 'admin' : '';
        if (LinkContainerInterface::TYPE_ADMIN == $type) {
            if ($this->permissionHelper->hasPermission(ACCESS_READ)) {
                $links[] = [
                    'url' => $this->router->generate('muboardmodule_category_index'),
                    'text' => $this->__('Frontend', 'muboardmodule'),
                    'title' => $this->__('Switch to user area.', 'muboardmodule'),
                    'icon' => 'home'
                ];
            }
        } else {
            if ($this->permissionHelper->hasPermission(ACCESS_ADMIN)) {
                $links[] = [
                    'url' => $this->router->generate('muboardmodule_category_adminindex'),
                    'text' => $this->__('Backend', 'muboardmodule'),
                    'title' => $this->__('Switch to administration area.', 'muboardmodule'),
                    'icon' => 'wrench'
                ];
            }
        }
        
        if (in_array('category', $allowedObjectTypes)
            && $this->permissionHelper->hasComponentPermission('category', $permLevel)) {
            $links[] = [
                'url' => $this->router->generate('muboardmodule_category_' . $routeArea . 'view'),
                'text' => $this->__('Categories', 'muboardmodule'),
                'title' => $this->__('Categories list', 'muboardmodule')
            ];
        }
        if (in_array('forum', $allowedObjectTypes)
            && $this->permissionHelper->hasComponentPermission('forum', $permLevel)) {
            $links[] = [
                'url' => $this->router->generate('muboardmodule_forum_' . $routeArea . 'view'),
                'text' => $this->__('Forums', 'muboardmodule'),
                'title' => $this->__('Forums list', 'muboardmodule')
            ];
        }
        if (in_array('posting', $allowedObjectTypes)
            && $this->permissionHelper->hasComponentPermission('posting', $permLevel)) {
            $links[] = [
                'url' => $this->router->generate('muboardmodule_posting_' . $routeArea . 'view'),
                'text' => $this->__('Postings', 'muboardmodule'),
                'title' => $this->__('Postings list', 'muboardmodule')
            ];
        }
        if (in_array('abo', $allowedObjectTypes)
            && $this->permissionHelper->hasComponentPermission('abo', $permLevel)) {
            $links[] = [
                'url' => $this->router->generate('muboardmodule_abo_' . $routeArea . 'view'),
                'text' => $this->__('Abos', 'muboardmodule'),
                'title' => $this->__('Abos list', 'muboardmodule')
            ];
        }
        if (in_array('user', $allowedObjectTypes)
            && $this->permissionHelper->hasComponentPermission('user', $permLevel)) {
            $links[] = [
                'url' => $this->router->generate('muboardmodule_user_' . $routeArea . 'view'),
                'text' => $this->__('Users', 'muboardmodule'),
                'title' => $this->__('Users list', 'muboardmodule')
            ];
        }
        if (in_array('rank', $allowedObjectTypes)
            && $this->permissionHelper->hasComponentPermission('rank', $permLevel)) {
            $links[] = [
                'url' => $this->router->generate('muboardmodule_rank_' . $routeArea . 'view'),
                'text' => $this->__('Ranks', 'muboardmodule'),
                'title' => $this->__('Ranks list', 'muboardmodule')
            ];
        }
        if ($routeArea == 'admin' && $this->permissionHelper->hasPermission(ACCESS_ADMIN)) {
            $links[] = [
                'url' => $this->router->generate('muboardmodule_config_config'),
                'text' => $this->__('Settings', 'muboardmodule'),
                'title' => $this->__('Manage settings for this application', 'muboardmodule'),
                'icon' => 'wrench'
            ];
        }

        return $links;
    }

    /**
     * Returns the name of the providing bundle.
     *
     * @return string The bundle name
     */
    public function getBundleName()
    {
        return 'MUBoardModule';
    }
}

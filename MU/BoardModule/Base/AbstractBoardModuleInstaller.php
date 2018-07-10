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

namespace MU\BoardModule\Base;

use Doctrine\DBAL\Connection;
use RuntimeException;
use Zikula\Core\AbstractExtensionInstaller;

/**
 * Installer base class.
 */
abstract class AbstractBoardModuleInstaller extends AbstractExtensionInstaller
{
    /**
     * Install the MUBoardModule application.
     *
     * @return boolean True on success, or false
     *
     * @throws RuntimeException Thrown if database tables can not be created or another error occurs
     */
    public function install()
    {
        $logger = $this->container->get('logger');
        $userName = $this->container->get('zikula_users_module.current_user')->get('uname');
    
        // Check if upload directories exist and if needed create them
        try {
            $container = $this->container;
            $uploadHelper = new \MU\BoardModule\Helper\UploadHelper(
                $container->get('translator.default'),
                $container->get('filesystem'),
                $container->get('session'),
                $container->get('logger'),
                $container->get('zikula_users_module.current_user'),
                $container->get('zikula_extensions_module.api.variable'),
                $container->getParameter('datadir')
            );
            $uploadHelper->checkAndCreateAllUploadFolders();
        } catch (\Exception $exception) {
            $this->addFlash('error', $exception->getMessage());
            $logger->error('{app}: User {user} could not create upload folders during installation. Error details: {errorMessage}.', ['app' => 'MUBoardModule', 'user' => $userName, 'errorMessage' => $exception->getMessage()]);
        
            return false;
        }
        // create all tables from according entity definitions
        try {
            $this->schemaTool->create($this->listEntityClasses());
        } catch (\Exception $exception) {
            $this->addFlash('error', $this->__('Doctrine Exception') . ': ' . $exception->getMessage());
            $logger->error('{app}: Could not create the database tables during installation. Error details: {errorMessage}.', ['app' => 'MUBoardModule', 'errorMessage' => $exception->getMessage()]);
    
            return false;
        }
    
        // set up all our vars with initial values
        $this->setVar('uploadImages', false);
        $this->setVar('allowedSizeOfImages', '200k');
        $this->setVar('numberImages', '1');
        $this->setVar('uploadFiles', false);
        $this->setVar('allowedSizeOfFiles', '200k');
        $this->setVar('numberFiles', '1');
        $this->setVar('editPostings', false);
        $this->setVar('editTime', 6);
        $this->setVar('latestPostings', 24);
        $this->setVar('sortingCategories', 'descending');
        $this->setVar('sortingForums', 'descending');
        $this->setVar('sortingPostings', 'descending');
        $this->setVar('standardIcon', '');
        $this->setVar('specialIcon', '');
        $this->setVar('iconSet', '1');
        $this->setVar('template', 'normal');
        $this->setVar('showStatisticInDetails', false);
        $this->setVar('showStatisticOnBottom', false);
        $this->setVar('moderationGroupForPostings', 2);
        $this->setVar('categoryEntriesPerPage', 10);
        $this->setVar('linkOwnCategoriesOnAccountPage', true);
        $this->setVar('forumEntriesPerPage', 10);
        $this->setVar('linkOwnForumsOnAccountPage', true);
        $this->setVar('postingEntriesPerPage', 10);
        $this->setVar('linkOwnPostingsOnAccountPage', true);
        $this->setVar('aboEntriesPerPage', 10);
        $this->setVar('linkOwnAbosOnAccountPage', true);
        $this->setVar('userEntriesPerPage', 10);
        $this->setVar('rankEntriesPerPage', 10);
        $this->setVar('linkOwnRanksOnAccountPage', true);
        $this->setVar('enableShrinkingForPostingFirstImage', false);
        $this->setVar('shrinkWidthPostingFirstImage', 800);
        $this->setVar('shrinkHeightPostingFirstImage', 600);
        $this->setVar('thumbnailModePostingFirstImage', 'inset');
        $this->setVar('thumbnailWidthPostingFirstImageView', 32);
        $this->setVar('thumbnailHeightPostingFirstImageView', 24);
        $this->setVar('thumbnailWidthPostingFirstImageDisplay', 240);
        $this->setVar('thumbnailHeightPostingFirstImageDisplay', 180);
        $this->setVar('thumbnailWidthPostingFirstImageEdit', 240);
        $this->setVar('thumbnailHeightPostingFirstImageEdit', 180);
        $this->setVar('enableShrinkingForPostingSecondImage', false);
        $this->setVar('shrinkWidthPostingSecondImage', 800);
        $this->setVar('shrinkHeightPostingSecondImage', 600);
        $this->setVar('thumbnailModePostingSecondImage', 'inset');
        $this->setVar('thumbnailWidthPostingSecondImageView', 32);
        $this->setVar('thumbnailHeightPostingSecondImageView', 24);
        $this->setVar('thumbnailWidthPostingSecondImageDisplay', 240);
        $this->setVar('thumbnailHeightPostingSecondImageDisplay', 180);
        $this->setVar('thumbnailWidthPostingSecondImageEdit', 240);
        $this->setVar('thumbnailHeightPostingSecondImageEdit', 180);
        $this->setVar('enableShrinkingForPostingThirdImage', false);
        $this->setVar('shrinkWidthPostingThirdImage', 800);
        $this->setVar('shrinkHeightPostingThirdImage', 600);
        $this->setVar('thumbnailModePostingThirdImage', 'inset');
        $this->setVar('thumbnailWidthPostingThirdImageView', 32);
        $this->setVar('thumbnailHeightPostingThirdImageView', 24);
        $this->setVar('thumbnailWidthPostingThirdImageDisplay', 240);
        $this->setVar('thumbnailHeightPostingThirdImageDisplay', 180);
        $this->setVar('thumbnailWidthPostingThirdImageEdit', 240);
        $this->setVar('thumbnailHeightPostingThirdImageEdit', 180);
        $this->setVar('enableShrinkingForRankUploadImage', false);
        $this->setVar('shrinkWidthRankUploadImage', 800);
        $this->setVar('shrinkHeightRankUploadImage', 600);
        $this->setVar('thumbnailModeRankUploadImage', 'inset');
        $this->setVar('thumbnailWidthRankUploadImageView', 32);
        $this->setVar('thumbnailHeightRankUploadImageView', 24);
        $this->setVar('thumbnailWidthRankUploadImageDisplay', 240);
        $this->setVar('thumbnailHeightRankUploadImageDisplay', 180);
        $this->setVar('thumbnailWidthRankUploadImageEdit', 240);
        $this->setVar('thumbnailHeightRankUploadImageEdit', 180);
        $this->setVar('enabledFinderTypes', 'category###forum###posting###abo###user###rank');
    
        // initialisation successful
        return true;
    }
    
    /**
     * Upgrade the MUBoardModule application from an older version.
     *
     * If the upgrade fails at some point, it returns the last upgraded version.
     *
     * @param integer $oldVersion Version to upgrade from
     *
     * @return boolean True on success, false otherwise
     *
     * @throws RuntimeException Thrown if database tables can not be updated
     */
    public function upgrade($oldVersion)
    {
    /*
        $logger = $this->container->get('logger');
    
        // Upgrade dependent on old version number
        switch ($oldVersion) {
            case '1.0.0':
                // do something
                // ...
                // update the database schema
                try {
                    $this->schemaTool->update($this->listEntityClasses());
                } catch (\Exception $exception) {
                    $this->addFlash('error', $this->__('Doctrine Exception') . ': ' . $exception->getMessage());
                    $logger->error('{app}: Could not update the database tables during the upgrade. Error details: {errorMessage}.', ['app' => 'MUBoardModule', 'errorMessage' => $exception->getMessage()]);
    
                    return false;
                }
        }
    */
    
        // update successful
        return true;
    }
    
    /**
     * Uninstall MUBoardModule.
     *
     * @return boolean True on success, false otherwise
     *
     * @throws RuntimeException Thrown if database tables or stored workflows can not be removed
     */
    public function uninstall()
    {
        $logger = $this->container->get('logger');
    
        try {
            $this->schemaTool->drop($this->listEntityClasses());
        } catch (\Exception $exception) {
            $this->addFlash('error', $this->__('Doctrine Exception') . ': ' . $exception->getMessage());
            $logger->error('{app}: Could not remove the database tables during uninstallation. Error details: {errorMessage}.', ['app' => 'MUBoardModule', 'errorMessage' => $exception->getMessage()]);
    
            return false;
        }
    
        // remove all module vars
        $this->delVars();
    
        // remind user about upload folders not being deleted
        $uploadPath = $this->container->getParameter('datadir') . '/MUBoardModule/';
        $this->addFlash('status', $this->__f('The upload directories at "%path%" can be removed manually.', ['%path%' => $uploadPath]));
    
        // uninstallation successful
        return true;
    }
    
    /**
     * Build array with all entity classes for MUBoardModule.
     *
     * @return string[] List of class names
     */
    protected function listEntityClasses()
    {
        $classNames = [];
        $classNames[] = 'MU\BoardModule\Entity\CategoryEntity';
        $classNames[] = 'MU\BoardModule\Entity\ForumEntity';
        $classNames[] = 'MU\BoardModule\Entity\PostingEntity';
        $classNames[] = 'MU\BoardModule\Entity\AboEntity';
        $classNames[] = 'MU\BoardModule\Entity\UserEntity';
        $classNames[] = 'MU\BoardModule\Entity\RankEntity';
    
        return $classNames;
    }
}

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

/**
 * Events definition base class.
 */
abstract class AbstractBoardEvents
{
    /**
     * The muboardmodule.category_post_load event is thrown when categories
     * are loaded from the database.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterCategoryEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postLoad()
     * @var string
     */
    const CATEGORY_POST_LOAD = 'muboardmodule.category_post_load';
    
    /**
     * The muboardmodule.category_pre_persist event is thrown before a new category
     * is created in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterCategoryEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::prePersist()
     * @var string
     */
    const CATEGORY_PRE_PERSIST = 'muboardmodule.category_pre_persist';
    
    /**
     * The muboardmodule.category_post_persist event is thrown after a new category
     * has been created in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterCategoryEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postPersist()
     * @var string
     */
    const CATEGORY_POST_PERSIST = 'muboardmodule.category_post_persist';
    
    /**
     * The muboardmodule.category_pre_remove event is thrown before an existing category
     * is removed from the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterCategoryEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::preRemove()
     * @var string
     */
    const CATEGORY_PRE_REMOVE = 'muboardmodule.category_pre_remove';
    
    /**
     * The muboardmodule.category_post_remove event is thrown after an existing category
     * has been removed from the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterCategoryEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postRemove()
     * @var string
     */
    const CATEGORY_POST_REMOVE = 'muboardmodule.category_post_remove';
    
    /**
     * The muboardmodule.category_pre_update event is thrown before an existing category
     * is updated in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterCategoryEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::preUpdate()
     * @var string
     */
    const CATEGORY_PRE_UPDATE = 'muboardmodule.category_pre_update';
    
    /**
     * The muboardmodule.category_post_update event is thrown after an existing new category
     * has been updated in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterCategoryEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postUpdate()
     * @var string
     */
    const CATEGORY_POST_UPDATE = 'muboardmodule.category_post_update';
    
    /**
     * The muboardmodule.forum_post_load event is thrown when forums
     * are loaded from the database.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterForumEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postLoad()
     * @var string
     */
    const FORUM_POST_LOAD = 'muboardmodule.forum_post_load';
    
    /**
     * The muboardmodule.forum_pre_persist event is thrown before a new forum
     * is created in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterForumEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::prePersist()
     * @var string
     */
    const FORUM_PRE_PERSIST = 'muboardmodule.forum_pre_persist';
    
    /**
     * The muboardmodule.forum_post_persist event is thrown after a new forum
     * has been created in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterForumEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postPersist()
     * @var string
     */
    const FORUM_POST_PERSIST = 'muboardmodule.forum_post_persist';
    
    /**
     * The muboardmodule.forum_pre_remove event is thrown before an existing forum
     * is removed from the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterForumEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::preRemove()
     * @var string
     */
    const FORUM_PRE_REMOVE = 'muboardmodule.forum_pre_remove';
    
    /**
     * The muboardmodule.forum_post_remove event is thrown after an existing forum
     * has been removed from the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterForumEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postRemove()
     * @var string
     */
    const FORUM_POST_REMOVE = 'muboardmodule.forum_post_remove';
    
    /**
     * The muboardmodule.forum_pre_update event is thrown before an existing forum
     * is updated in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterForumEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::preUpdate()
     * @var string
     */
    const FORUM_PRE_UPDATE = 'muboardmodule.forum_pre_update';
    
    /**
     * The muboardmodule.forum_post_update event is thrown after an existing new forum
     * has been updated in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterForumEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postUpdate()
     * @var string
     */
    const FORUM_POST_UPDATE = 'muboardmodule.forum_post_update';
    
    /**
     * The muboardmodule.posting_post_load event is thrown when postings
     * are loaded from the database.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterPostingEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postLoad()
     * @var string
     */
    const POSTING_POST_LOAD = 'muboardmodule.posting_post_load';
    
    /**
     * The muboardmodule.posting_pre_persist event is thrown before a new posting
     * is created in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterPostingEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::prePersist()
     * @var string
     */
    const POSTING_PRE_PERSIST = 'muboardmodule.posting_pre_persist';
    
    /**
     * The muboardmodule.posting_post_persist event is thrown after a new posting
     * has been created in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterPostingEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postPersist()
     * @var string
     */
    const POSTING_POST_PERSIST = 'muboardmodule.posting_post_persist';
    
    /**
     * The muboardmodule.posting_pre_remove event is thrown before an existing posting
     * is removed from the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterPostingEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::preRemove()
     * @var string
     */
    const POSTING_PRE_REMOVE = 'muboardmodule.posting_pre_remove';
    
    /**
     * The muboardmodule.posting_post_remove event is thrown after an existing posting
     * has been removed from the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterPostingEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postRemove()
     * @var string
     */
    const POSTING_POST_REMOVE = 'muboardmodule.posting_post_remove';
    
    /**
     * The muboardmodule.posting_pre_update event is thrown before an existing posting
     * is updated in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterPostingEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::preUpdate()
     * @var string
     */
    const POSTING_PRE_UPDATE = 'muboardmodule.posting_pre_update';
    
    /**
     * The muboardmodule.posting_post_update event is thrown after an existing new posting
     * has been updated in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterPostingEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postUpdate()
     * @var string
     */
    const POSTING_POST_UPDATE = 'muboardmodule.posting_post_update';
    
    /**
     * The muboardmodule.abo_post_load event is thrown when abos
     * are loaded from the database.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterAboEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postLoad()
     * @var string
     */
    const ABO_POST_LOAD = 'muboardmodule.abo_post_load';
    
    /**
     * The muboardmodule.abo_pre_persist event is thrown before a new abo
     * is created in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterAboEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::prePersist()
     * @var string
     */
    const ABO_PRE_PERSIST = 'muboardmodule.abo_pre_persist';
    
    /**
     * The muboardmodule.abo_post_persist event is thrown after a new abo
     * has been created in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterAboEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postPersist()
     * @var string
     */
    const ABO_POST_PERSIST = 'muboardmodule.abo_post_persist';
    
    /**
     * The muboardmodule.abo_pre_remove event is thrown before an existing abo
     * is removed from the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterAboEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::preRemove()
     * @var string
     */
    const ABO_PRE_REMOVE = 'muboardmodule.abo_pre_remove';
    
    /**
     * The muboardmodule.abo_post_remove event is thrown after an existing abo
     * has been removed from the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterAboEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postRemove()
     * @var string
     */
    const ABO_POST_REMOVE = 'muboardmodule.abo_post_remove';
    
    /**
     * The muboardmodule.abo_pre_update event is thrown before an existing abo
     * is updated in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterAboEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::preUpdate()
     * @var string
     */
    const ABO_PRE_UPDATE = 'muboardmodule.abo_pre_update';
    
    /**
     * The muboardmodule.abo_post_update event is thrown after an existing new abo
     * has been updated in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterAboEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postUpdate()
     * @var string
     */
    const ABO_POST_UPDATE = 'muboardmodule.abo_post_update';
    
    /**
     * The muboardmodule.user_post_load event is thrown when users
     * are loaded from the database.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterUserEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postLoad()
     * @var string
     */
    const USER_POST_LOAD = 'muboardmodule.user_post_load';
    
    /**
     * The muboardmodule.user_pre_persist event is thrown before a new user
     * is created in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterUserEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::prePersist()
     * @var string
     */
    const USER_PRE_PERSIST = 'muboardmodule.user_pre_persist';
    
    /**
     * The muboardmodule.user_post_persist event is thrown after a new user
     * has been created in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterUserEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postPersist()
     * @var string
     */
    const USER_POST_PERSIST = 'muboardmodule.user_post_persist';
    
    /**
     * The muboardmodule.user_pre_remove event is thrown before an existing user
     * is removed from the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterUserEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::preRemove()
     * @var string
     */
    const USER_PRE_REMOVE = 'muboardmodule.user_pre_remove';
    
    /**
     * The muboardmodule.user_post_remove event is thrown after an existing user
     * has been removed from the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterUserEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postRemove()
     * @var string
     */
    const USER_POST_REMOVE = 'muboardmodule.user_post_remove';
    
    /**
     * The muboardmodule.user_pre_update event is thrown before an existing user
     * is updated in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterUserEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::preUpdate()
     * @var string
     */
    const USER_PRE_UPDATE = 'muboardmodule.user_pre_update';
    
    /**
     * The muboardmodule.user_post_update event is thrown after an existing new user
     * has been updated in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterUserEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postUpdate()
     * @var string
     */
    const USER_POST_UPDATE = 'muboardmodule.user_post_update';
    
    /**
     * The muboardmodule.rank_post_load event is thrown when ranks
     * are loaded from the database.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterRankEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postLoad()
     * @var string
     */
    const RANK_POST_LOAD = 'muboardmodule.rank_post_load';
    
    /**
     * The muboardmodule.rank_pre_persist event is thrown before a new rank
     * is created in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterRankEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::prePersist()
     * @var string
     */
    const RANK_PRE_PERSIST = 'muboardmodule.rank_pre_persist';
    
    /**
     * The muboardmodule.rank_post_persist event is thrown after a new rank
     * has been created in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterRankEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postPersist()
     * @var string
     */
    const RANK_POST_PERSIST = 'muboardmodule.rank_post_persist';
    
    /**
     * The muboardmodule.rank_pre_remove event is thrown before an existing rank
     * is removed from the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterRankEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::preRemove()
     * @var string
     */
    const RANK_PRE_REMOVE = 'muboardmodule.rank_pre_remove';
    
    /**
     * The muboardmodule.rank_post_remove event is thrown after an existing rank
     * has been removed from the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterRankEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postRemove()
     * @var string
     */
    const RANK_POST_REMOVE = 'muboardmodule.rank_post_remove';
    
    /**
     * The muboardmodule.rank_pre_update event is thrown before an existing rank
     * is updated in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterRankEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::preUpdate()
     * @var string
     */
    const RANK_PRE_UPDATE = 'muboardmodule.rank_pre_update';
    
    /**
     * The muboardmodule.rank_post_update event is thrown after an existing new rank
     * has been updated in the system.
     *
     * The event listener receives an
     * MU\BoardModule\Event\FilterRankEvent instance.
     *
     * @see MU\BoardModule\Listener\EntityLifecycleListener::postUpdate()
     * @var string
     */
    const RANK_POST_UPDATE = 'muboardmodule.rank_post_update';
    
}

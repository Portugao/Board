<?php
/**
 * MUBoard.
 *
 * @copyright Michael Ueberschaer
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package Eternizer
 * @author Michael Ueberschaer <kontakt@webdesign-in-bremen.com>.
 * @link http://www.webdesign-in-bremen.com
 * @link http://zikula.org
 */

/**
 * Utility base class for abonnements helper methods.
 */
class MUBoard_Util_Base_Abonnements extends Zikula_AbstractBase
{


    /**
     * Helper method to handle the mailing for abos of postings and forums
     */

    public static function aboMailing($args)
    {
        $id = $args['id'];
        $parent = $args['parent'];
        if ($parent == '') {
            $parent = 0;
        }
        $title = $args['title'];

        $text = $args['text'];
        if (ModUtil::available('BBCode')) {
            $text = ModUtil::apiFunc('BBCode', 'user', 'transform', array('message' => $text));
        }
        if (ModUtil::available('BBSmile')) {
            $text = ModUtil::apiFunc('BBSmile', 'user', 'transform', array('text' => $text));
        }

        // we get a repository for abos
        $repository = MUBoard_Util_Model::getAboRepository();

        // we get a repository for forums
        $repository2 = MUBoard_Util_Model::getForumRepository();
        // we get a repository for postings
        $repository3 = MUBoard_Util_Model::getPostingRepository();
        // we get the just saved posting
        $savedPosting = $repository3->selectById($id);

        $createdUserId = $savedPosting->getCreatedUserId();
        	
        $forum = $savedPosting->getForum();
        $forumid = $forum->getId();

        // we get serviceManager and handler
        $serviceManager = ServiceUtil::getManager();
        $handler = new Zikula_Form_View($serviceManager, 'MUBoard');

        // We build the url for the email message
        $host = System::serverGetVar('HTTP_HOST') . '/';
        // workaround because of bug in MOST or doctrine2 TODO
        if ($parent == 0) {
            $url = 'http://' . $host . ModUtil::url('MUBoard', 'user', 'display', array('ot' => 'posting', 'id' => $id));
        }
        else {
            $url = 'http://' . $host . ModUtil::url('MUBoard', 'user', 'display', array('ot' => 'posting', 'id' => $parent));
        }

        // We get the name of the site
        $from = ModUtil::getVar('ZConfig', 'sitename') . ' ';
        // We get the adminmail
        $fromaddress = ModUtil::getVar('ZConfig', 'adminmail');


        $toaddress = self::getForumAbos($forumid, $createdUserId);
        foreach ($toaddress as $address) {
            if (filter_var($address, FILTER_VALIDATE_EMAIL)) {
                $messagecontent = self::getMailContent($from, $fromaddress, $address, $forum, $title, $text, $url , $kind, $parent);
                ModUtil::apiFunc('Mailer', 'user', 'sendmessage', $messagecontent);
            }
        }
    }

    /**
     * This method get the abos of the relevant forum and return the mailadresses
     * @param int $forumid         id of relevant forum if available
     * @param int $userId         userid of the user created the posting
     */

    protected static function getForumAbos($forumid, $userId)
    {
        // we get a repository for abos
        $repository = MUBoard_Util_Model::getAboRepository();
        $where = 'tbl.forumid = \'' . DataUtil::formatForStore($forumid) . '\'';
        $where .= ' AND ';
        $where .= 'tbl.createdUserId != \'' . DataUtil::formatForStore($userId) . '\'';
        $forumabos = $repository->selectWhere($where);
        foreach ($forumabos as $forumabo) {
            //if ($forumabo['createdUserId'] != $userid) {
            $userids[] = $forumabo['createdUserId'];
            //}
        }
        foreach ($userids as $userid) {
            $mailadresses[] = UserUtil::getVar('email', $userid);
        }

        return $mailadresses;
    }

    /**
     * This method get the abos of the relevant posting and return the mailadresses
     * @param int $postingid      id of the relevant issue
     */

    protected static function getPostingAbos()
    {
        // we get a posting repository
        $repository = MUBoard_Util_Model::getPostingRepository();
    }

    /**
     *
     * get the mail content for the message to send
     * returns array $messagecontent
     */
    public function getMailContent($from, $fromaddress, $toaddress, $forum, $title, $text, $url, $kind, $parent)
    {
        $serviceManager = ServiceUtil::getManager();
        $handler = new Zikula_Form_View($serviceManager, 'MUBoard');

        $messagecontent = array();
        $messagecontent['from'] = $from;
        $messagecontent['fromaddress'] = $fromaddress;

        $messagecontent['toaddress'] = $toaddress;
        $messagecontent['subject'] = $entry . $from . $ticketcategory;

        if ($parent == 0) {
            $messagecontent['body'] = $handler->__('Another issue was created by an user on '). '<h2>' . $from . '</h2>';
        } else {
            $messagecontent['body'] = $handler->__('Another posting was created by an user on '). '<h2>' . $from . '</h2>';
        }

        $messagecontent['body'] .= $handler->__('Title of posting') . '<br />' . $title . '<br /><br />';
        $messagecontent['body'] .= $handler->__('Text') . '<br />' . $text . '<br /><br />';
        $messagecontent['body'] .= $handler->__('Visit this issue:') . '<br />';
        $messagecontent['body'] .= '<a href="' . $url . '">' . $url . '</a><br /><br />';
        $messagecontent['body'] .= $handler->__('You get this messsage because you did a subscription for a forum!') . "<br />";
        // We build the url for the email message
        $host = System::serverGetVar('HTTP_HOST') . '/';
        $url = "<a href='";
        $url .= "http://" . $host . ModUtil::url('MUBoard', 'user', 'display', array('ot' => 'forum', 'id' => $forum['id']));
        $url .= "'>" . $handler->__('Forum') . " " . $forum['title'] . "</a>";
        $messagecontent['body'] .= " " . $handler->__f('You can quit the subscription if you visit the %s!', array($url));
        $messagecontent['altbody'] = '';
        $messagecontent['html'] = true;

        return $messagecontent;
    }
}
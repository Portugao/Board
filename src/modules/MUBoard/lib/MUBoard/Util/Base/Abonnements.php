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
	 *
	 * This method handles the modvars after persist of an entity
	 * @param int    $args['id']	    	id of the just created answer or ticket
	 * @param string $args['title]      	title of an parent ticket or an answer
	 * @param string $args['text']      	text of an parent ticket or an answer
	 * @param int    $args['parentid']  	id of the parent ticket
	 * @param array  $args['categories']	array of categories of the ticket or answer
	 */
	public function handleModvarsPostPersist($args)
	{
		$serviceManager = ServiceUtil::getManager();
		$handler = new Zikula_Form_View($serviceManager, 'MUBoard');

		$lang = ZLanguage::getLanguageCode();

		$id = $args['id'];
		$title = $args['title'];
		$text = $args['text'];
		$parentid = $args['parentid'];
		if ($title == '') {

			$repository = MUBoard_Util_Model::getPostingRepository();

			$entity = $repository->selectById($id);
			$title = $entity['title'];
		}

		// Get actual userid
		$userid = $this->getCreatedUserId();

		// Get supporter ids
		$supporteruids = MUTicket_Util_Model::getExistingSupporterUids();

		// Check if is array
		if (is_array($supporteruids)) {
			// Check if user is a supporter
			if (in_array($userid, $supporteruids)) {
				$kind = 'Supporter';
			}
			else {
				$kind = 'Customer';
			}
		}
		else {
			if ($userid == $supporteruids) {
				$kind ='Supporter';
			}
			else {
				$kind ='Customer';
			}
		}

		if (!$parentid ) {
			$entry = $handler->__('A new ticket on ');
		}
		else {
			if ($kind == 'Supporter') {
				$entry = $handler->__('An answer to your ticket on ');
			}
			else {
				$entry = $handler->__('An answer to a ticket on ');
			}
		}

		// We build the url for the email message
		$host = System::serverGetVar('HTTP_HOST') . '/';
		// workaround because of bug in MOST or doctrine2 TODO
		if (!$parentid) {
			$url = 'http://' . $host . ModUtil::url('MUTicket', 'user', 'view', array('ot' => 'ticket'));
		}
		else {
			$url = 'http://' . $host . ModUtil::url('MUTicket', 'user', 'display', array('ot' => 'ticket', 'id' => $parentid));
		}

		// We get the name of the site
		$from = ModUtil::getVar('ZConfig', 'sitename') . ' ';
		// We get the adminmail
		$fromaddress = ModUtil::getVar('ZConfig', 'adminmail');

		if ($kind == 'Customer') {
			$toaddress = MUTicket_Util_Model::getSupporterMails($ticketcategory2);
			$messagecontent = MUTicket_Util_Base_Settings::getMailContent($from, $fromaddress, $toaddress, $entry, $ticketcategory, $title, $text, $url , $kind);
		}
		// get mail of parent ticket creater
		if ($kind == 'Supporter') {
			$toaddress = MUTicket_Util_Base_Settings::getMailAddressOfUser($parentid);
			$messagecontent = MUTicket_Util_Base_Settings::getMailContent($from, $fromaddress, $toaddress, $entry, $ticketcategory, $title, $text, $url, $kind);
		}

		// We send a mail if an email address is saved
		if ($toaddress != '') {

			if (!ModUtil::apiFunc('Mailer', 'user', 'sendmessage', $messagecontent)) {
				LogUtil::registerError($handler->__('Unable to send message'));
			}
		}

		// Formating of status text
		if ($kind == 'Customer') {
			$message = $handler->__('Your ticket was saved and an email sent to our support!');
		}
		else {
			$message = $handler->__('Your support answer was saved and an email sent to the customer!');
		}

		LogUtil::registerStatus($message);

		return true;

	}

	/**
	 *
	 * get the mail content for the message to send
	 * returns array $messagecontent
	 */
	public function getMailContent($from, $fromaddress, $toaddress, $entry, $ticketcategory, $title, $text, $url, $kind) {

		$serviceManager = ServiceUtil::getManager();
		$handler = new Zikula_Form_View($serviceManager, 'MUTicket');

		$messagecontent = array();
		$messagecontent['from'] = $from;
		$messagecontent['fromaddress'] = $fromaddress;
		/*$messagecontent['toname'] = 'Webmaster';*/
		$messagecontent['toaddress'] = $toaddress;
		$messagecontent['subject'] = $entry . $from . $ticketcategory;
		if ($kind == 'Customer') {
			$messagecontent['body'] = $handler->__('Another entry was created by an user on '). '<h2>' . $from . '</h2>';
		}
		else {
			$messagecontent['body'] = $handler->__('There is an answer to your ticket of the support on '). '<h2>' . $from . '</h2>';
		}
		$messagecontent['body'] .= $handler->__('Title of ticket') . '<br />' . $title . '<br /><br />';
		$messagecontent['body'] .= $handler->__('Text') . '<br />' . $text . '<br /><br />';
		$messagecontent['body'] .= $handler->__('Visit this ticket:') . '<br />';
		$messagecontent['body'] .= '<a href="' . $url . '">' . $url . '</a><br />';
		if ($editurl != '') {
			$messagecontent .= $handler->__('Moderate this entry:') .
                '<br />' . '<a href="' . $editurl . '">' . $editurl . '</a>';
		}
		$messagecontent['altbody'] = '';
		$messagecontent['html'] = true;

		return $messagecontent;
	}

	/**
	 * get the email address of the user that
	 * created parent ticket
	 * @parentid id of the parent ticket
	 * @returns $email string
	 */

	public function getMailAddressOfUser($parentid) {

		// get entity with id is parentid
		$entity = ModUtil::apiFunc('MUTicket', 'selection', 'getEntity', array('ot' => 'ticket', 'id' => $parentid));
		// get userid created the parent ticket
		$userid = $entity['createdUserId'];
		$email = UserUtil::getVar('email', $userid);

		return $email;

	}
}
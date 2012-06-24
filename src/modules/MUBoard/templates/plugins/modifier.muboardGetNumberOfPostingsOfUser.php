<?php
/**
 * MUTicket.
 *
 * @copyright Michael Ueberschaer
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package MUTicket
 * @author Michael Ueberschaer <kontakt@webdesign-in-bremen.com>.
 * @link http://www.webdesign-in-bremen.com
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.5.4 (http://modulestudio.de) at Thu Feb 02 13:43:18 CET 2012.
 */

/**
 * The muticketgetNumberOfPostingsOfUser modifier returns the number
 * of postings of an user
 *
 * @param  int       $id      user id
 *
 * @return int the output of number of posting
 */
function smarty_modifier_muboardGetNumberOfPostingsOfUser($id)
{
	$out = MUBoard_Util_View::getNumberOfPostingsOfUser($id);

	return $out;
}
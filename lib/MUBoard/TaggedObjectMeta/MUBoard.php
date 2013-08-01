<?php
/**
 * Tagged object meta class.
 */
class MUBoard_TaggedObjectMeta_MUBoard extends Tag_AbstractTaggedObjectMeta
{
	/**
	 * Construct.
	 *
	 * @param int $objectId Object ID.
	 * @param int $areaId A blockinfo structure.
	 * @param string $module Module.
	 * @param string $urlString Url.
	 * @param Zikula_ModUrl $urlObject Url object.
	 */
	function __construct($objectId, $areaId, $module, $urlString = null, Zikula_ModUrl $urlObject = null)
	{
		parent::__construct($objectId, $areaId, $module, $urlString, $urlObject);
		
		$args = $urlObject->getArgs();
		$ot = $args['ot'];
		
		if ($ot == 'posting') {
			$posting = ModUtil::apiFunc('MUBoard', 'selection', 'getEntity', array('ot' => 'posting', 'id' => $this->getObjectId()));
			// the Api checks for perms and there is nothing else to check
			if ($posting) {
				$userid = $posting->getCreatedUserId();
				$date = $posting->getCreatedDate();
				$title = $posting->getTitle();
				$this->setObjectAuthor(UserUtil::getVar('uname', $userid));
				$this->setObjectDate($date);
				$this->setObjectTitle($title);
			}
		}

		if ($ot == 'picture') {
			$picture = ModUtil::apiFunc('MUImage', 'selection', 'getEntity', array('ot' => 'picture', 'id' => $this->getObjectId()));
			// the Api checks for perms and there is nothing else to check
			if ($picture) {
				$userid = $picture->getCreatedUserId();
				$date = $picture->getCreatedDate();
				$title = $picture->getTitle();
				$this->setObjectAuthor(UserUtil::getVar('uname', $userid));
				$this->setObjectDate($date);
				$this->setObjectTitle($title);
			}
		}
	}

	/**
	 * Set object title.
	 *
	 * @param string $title Object title.
	 */
	public function setObjectTitle($title)
	{
		$this->title = $title;
	}

	/**
	 * Set object date.
	 *
	 * @param string $date Date.
	 */
	public function setObjectDate($date)
	{
		$this->date = DateUtil::formatDatetime($date, 'datetimebrief');
	}

	/**
	 * Set object author.
	 *
	 * @param string $author Object author.
	 */
	public function setObjectAuthor($author)
	{
		$this->author = $author;
	}
}
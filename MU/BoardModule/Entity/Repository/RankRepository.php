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

namespace MU\BoardModule\Entity\Repository;

use MU\BoardModule\Entity\Repository\Base\AbstractRankRepository;

/**
 * Repository class used to implement own convenience methods for performing certain DQL queries.
 *
 * This is the concrete repository class for rank entities.
 */
class RankRepository extends AbstractRankRepository
{
    /**
     * @param integer $numberPostings 
     *
     */
    public function getRank($numberPostings) {
        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->select('tbl');
        $qb->from($this->mainEntityClass, 'tbl');
        $qb->where('tbl.minPostings = :number');
        $qb->orWhere('tbl.maxPostings = :number');
        $qb->orWhere('tbl.minPostings < :number');
        $qb->andWhere('tbl.maxPostings > :number');
        $qb->setParameter('number', $numberPostings);
        
        $query = $qb->getQuery();
        $result = $query->getResult();
        if (count($result) == 1) {
            $rank = $this->find($result[0]['id']);
            return $rank;
        }
        
        return $result;
    }
}

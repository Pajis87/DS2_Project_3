using Microsoft.Data.SqlClient;

namespace DS2_Project_3.orm.dao
{
    public static class TransactionDAO
    {
        private static string SqlSelectTrainingInfo =
        """
        
            SELECT
                od,
                do,
                pocetVolnychMist,
                cenaZaHodinu
            FROM
                vycvik v INNER JOIN
                trener t ON ( v . trener = t . tId )
            WHERE vId = @training_id
        
        """;
        


        public static bool MojeTransakce(Database pDb, int user_id, int traning_id, int[] dog_ids, string coupon)
        {
            Database db = Database.Connect(pDb);
            bool ret = true;
            try
            {
                db.BeginTransaction();


                TrenerDAO.ZiskejPodleId(pDb, traning_id);


                db.EndTransaction();
            }
            catch (SqlException)
            {
                db.Rollback();
                ret = false;
            }
            Database.Close(pDb, db);
            return ret;
        }


        
    }
}

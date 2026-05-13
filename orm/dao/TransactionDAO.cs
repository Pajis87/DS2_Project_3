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

                VycvikDTO? vycvik = VycvikDAO.ZiskejPodleId(pDb, traning_id);

                if (vycvik == null)
                {
                    Console.WriteLine("");
                    return false;
                }

                TrenerDAO.ZiskejPodleId(pDb, vycvik.trenerId);


                db.EndTransaction();
            }
            catch (SqlException)
            {
                db.Rollback();
                ret = false;
            } // TODO: check if finally is also called on throw exception
            // TODO: check if finally is also called on throw exception
            // TODO: check if finally is also called on throw exception
            // TODO: check if finally is also called on throw exception
            // TODO: check if finally is also called on throw exception
            // TODO: check if finally is also called on throw exception
            // TODO: check if finally is also called on throw exception
            // TODO: check if finally is also called on throw exception
            // TODO: check if finally is also called on throw exception
            // TODO: check if finally is also called on throw exception
            // TODO: check if finally is also called on throw exception
            // TODO: check if finally is also called on throw exception
            // TODO: check if finally is also called on throw exception
            // TODO: check if finally is also called on throw exception
            // TODO: check if finally is also called on throw exception
            Database.Close(pDb, db);
            return ret;
        }


        
    }
}

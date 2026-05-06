using Oracle.ManagedDataAccess.Client;
using Oracle.ManagedDataAccess.Types;

namespace DS2_Project_3
{
    public class OracleDao
    {
        static string SqlInsert =
           "insert into \"Order\"(id_user, id_staff, date_order, price) " +
           "values(:id_user, :id_staff, :date_order, :price) " +
           "returning id_order into :id_order";
        public static void Insert(Database pDb, Order order)
        {
            Database db = Database.Connect(pDb);

            OracleCommand command = db.CreateCommand(SqlInsert);
            PrepareCommand(command, order);
            db.ExecuteNonQuery(command);

            order.id_order = ((OracleDecimal)(command.Parameters[":id_order"].Value)).ToInt32();

            Database.Close(pDb, db);
        }

        private static void PrepareCommand(OracleCommand command, Order order)
        {
            command.BindByName = true;
            command.Parameters.Add(":id_user", order.id_user);
            command.Parameters.Add(":id_staff", order.id_staff);
            command.Parameters.Add(":date_order", order.date_order);
            command.Parameters.Add(":price", order.price == null ? DBNull.Value : (object)order.price);

            OracleParameter p4 = command.CreateParameter();
            p4.ParameterName = ":id_order";
            p4.OracleDbType = OracleDbType.Int32;
            p4.Direction = System.Data.ParameterDirection.Output;
            command.Parameters.Add(p4);
        }

        private static string SqlDotaz =
        "select count(*) from MojeEntita where id = @id;";

        public static int GetHodnota(Database pDb, int id)
        {
            Database db = Database.Connect(pDb);
            SqlCommand command = db.CreateCommand(SqlDotaz);
            command.Parameters.AddWithValue("@id", id);
            int result = db.ExecuteScalar(command);
            Database.Close(pDb, db);
            return result;
        }
    }
}

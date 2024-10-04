using System.Data;
using Microsoft.Data.SqlClient;

public class ConsoleApp1
{
    private const string ConnectionString = "Server=localhost;Database=GestorSaldo;User ID=sa;Password=Azure?1930;TrustServerCertificate=True;";
    public static void Main()
    {
        Console.WriteLine("Asignar saldos a un grupo de gestores de cobros:");
        ProbarConexion();
        VerificacionGestorSaldo();
    }

    private static void ProbarConexion()
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();
                Console.WriteLine("Conectado a BD....");
                conn.Close();
            }
        }
        catch (SqlException ex)
        {
            Console.WriteLine("Error al conectar con BD"+ ex.Message);
        }
    }

    private static void VerificacionGestorSaldo()
    {
        List<GestorSaldo> AsignacionTemporal = new List<GestorSaldo>();
        
        using (SqlConnection connection = new SqlConnection(ConnectionString))
        {
            connection.Open();
            using (SqlCommand command=new SqlCommand("dbo.AsignarSaldosGestores",connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    Console.WriteLine("Procedimiento almacenado ejecutado:");
                    Console.WriteLine("Asignacion de Saldos a Gestores: ");
                    Console.WriteLine("Index |  Gestores   |   Saldos");
                    Console.WriteLine("------------------------------");
                    int index = 1;
                    while (reader.Read())
                    {
                        Console.WriteLine($"{index} |  {reader["Gestores"]}    |   {reader["Saldos"]}");
                        index++;
                        
                        AsignacionTemporal.Add(new GestorSaldo
                        {
                            Gestor = reader["Gestores"].ToString(),
                            Saldo = Convert.ToDecimal(reader["Saldos"])
                        });
                    }
                }
            }
        }

        var GestorAgrupado = AsignacionTemporal
            .GroupBy(gb => gb.Gestor)
            .OrderBy(o => o.Key)
            .Select(s => new { Gestor = s.Key, TotalSaldos = s.Sum(x => x.Saldo) });

        Console.WriteLine("Resultados agrupados por gestor mostrando su distribucion adecuada:");
        foreach (var item in GestorAgrupado)
        {
            Console.WriteLine($"Gestor: {item.Gestor}, Total Saldos Asignados: {item.TotalSaldos}");
        }
        
    }
    
    public class GestorSaldo
    {
        public string Gestor { get; set; }
        public decimal Saldo { get; set; }
    }
}
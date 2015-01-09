using System;
using System.Web;
using System.Web.Services;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.Storage.Queue;
using Microsoft.WindowsAzure.Storage;
using Newtonsoft.Json;

namespace WebRole1
{
    public partial class API : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        //Este Web Method recibe un request desde el JS, y guarda los puntos en la cola de mensajería.
        [WebMethod]
        public static string acumularPuntos(int Puntos) 
        {
            //Set up inicial: cuenta de storage, cola y cliente para consumir los mensajes.
            CloudStorageAccount storageAccount = CloudStorageAccount.Parse(CloudConfigurationManager.GetSetting("StorageConnectionString"));
            CloudQueueClient cliente = storageAccount.CreateCloudQueueClient();
            CloudQueue cola = cliente.GetQueueReference("puntos");
            cola.CreateIfNotExists();

            //Crea el mensaje a guardar en la cola
            if (HttpContext.Current.Request.UrlReferrer == null) return string.Empty;
            
            var contenido = new MensajePuntos
            {
                UserID = HttpContext.Current.Request.UrlReferrer.DnsSafeHost,
                Puntos = Puntos,
                Fecha = DateTime.Now,
                DireccionIP = HttpContext.Current.Request.UserHostAddress, //Esto toma la direccion IP del cliente
            };
          
            //Encola el mensaje
            CloudQueueMessage msj = new CloudQueueMessage(JsonConvert.SerializeObject(contenido));
            cola.AddMessage(msj);

            return string.Format("{0} agregados", Puntos);
        }
    }

    [Serializable]
    public class MensajePuntos
    {
        public string UserID { get; set; }
        public int Puntos { get; set; }
        public DateTime Fecha { get; set; }
        public string DireccionIP { get; set; }
    }
}
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Net.Http;
using System.Threading;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.ServiceRuntime;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Queue;
using Newtonsoft.Json;

namespace WorkerRole1
{
    public class WorkerRole : RoleEntryPoint
    {
        //Mantiene una referencia a la Cola (Queue) en Azure.
        private CloudQueue _cola;

        public override bool OnStart()
        {
            //Set-up inicial: cuenta de storage, cola y cliente para consumir los mensajes.
            var storageAccount = CloudStorageAccount.Parse(CloudConfigurationManager.GetSetting("StorageConnectionString"));
            var cliente = storageAccount.CreateCloudQueueClient();
            _cola = cliente.GetQueueReference("puntos");
            _cola.CreateIfNotExists();

            return base.OnStart();
        }

        public override void Run()
        {
            Trace.WriteLine("Empezando el procesamiento de mensajes");
            
            while(true)
            {
                Trace.WriteLine("Espero 30 minutos.");
                Thread.Sleep(30 * 60 * 1000);

                var puntosAcumulados = 0;
                var userID = string.Empty;

                //Leemos el primer mensaje.
                CloudQueueMessage mensaje = _cola.GetMessage();

                //Opcion 2: leer bloques de mensajes y hacer la sumatoria vía LINQ 
                while (mensaje != null)
                {
                    Trace.WriteLine("Leyendo mensaje");

                    //Deserializamos (JSON) el cuerpo del mensaje (string).
                    var msjPuntos = JsonConvert.DeserializeObject<MensajePuntos>(mensaje.AsString);
                    puntosAcumulados += msjPuntos.Puntos;

                    userID = msjPuntos.UserID;

                    mensaje = _cola.GetMessage();
                }

                //No hay más mensajes por leer.
                Trace.WriteLine("No hay mas mensajes!");

                if (puntosAcumulados == 0) continue;
                //Le enviamos al servidor los puntos procesados y acumulados
                (new HttpClient()).PostAsync("http://api.alebanzas.com.ar/AzureDevDay/", 
                                        new FormUrlEncodedContent(new List<KeyValuePair<string, string>>
                                                        {
                                                            new KeyValuePair<string, string>("UserID", userID),
                                                            new KeyValuePair<string, string>("Puntaje", puntosAcumulados.ToString(CultureInfo.InvariantCulture)),
                                                        }));
            }
        }

        public override void OnStop()
        {
            base.OnStop();
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

    [Serializable]
    public class PuntosProcesados
    {
        public int Puntaje { get; set; }
        public string UserID { get; set; }
    }
}

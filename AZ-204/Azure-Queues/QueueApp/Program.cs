using System;
using System.Threading.Tasks;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Queue; 

namespace QueueApp
{
    class Program
    {
        //For simplicity you can put the connection string in this local constant. For production system it needs to be secure.
        private const string ConnectionString = "";

        static async Task Main(string[] args)
        {
            if (args.Length > 0)
            {
                string value = String.Join(" ", args);
                await SendArticleAsync(value);
                Console.WriteLine($"Sent: {value}");
            }
            else
            {
                string value = await ReceiveArticleAsync();
                Console.WriteLine($"Received {value}");
            }
        }


        static async Task SendArticleAsync(string newsMessage)
        {
            var acct = CloudStorageAccount.Parse(ConnectionString);
            var queueClient = acct.CreateCloudQueueClient();
            var queue = queueClient.GetQueueReference("newsqueue");
            var createdQueue = await queue.CreateIfNotExistsAsync();
            if(createdQueue)
            {
                Console.WriteLine("The queue of news articles was created.");
            }

            var articleMessage = new CloudQueueMessage(newsMessage);
            await queue.AddMessageAsync(articleMessage);
        }

        static async Task<string> ReceiveArticleAsync()
        {
            CloudQueue queue = GetQueue();
            var exists = await queue.ExistsAsync();
            if (exists)
            {
                CloudQueueMessage retrievedArticle = await queue.GetMessageAsync();
                if (retrievedArticle != null)
                {
                    string newsMessage = retrievedArticle.AsString;
                    await queue.DeleteMessageAsync(retrievedArticle);
                    return newsMessage;
                }
            }

            return "<queue empty or not created>";
        }

        static CloudQueue GetQueue()
        {
            CloudStorageAccount storageAccount = CloudStorageAccount.Parse(ConnectionString);

            CloudQueueClient queueClient = storageAccount.CreateCloudQueueClient();
            return queueClient.GetQueueReference("newsqueue");
        }

    }
}

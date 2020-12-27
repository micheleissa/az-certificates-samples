using System;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Azure.ServiceBus;

namespace Sender
{
    class Program
    {
        const string ServiceBusConnectionString = "";
        const string QueueName = "";
        static IQueueClient queueClient;

        static void Main(string[] args)
        {
            Console.WriteLine("Sending a message to the Sales Messages queue...");

            SendSalesMessageAsync().GetAwaiter().GetResult();

            Console.WriteLine("Message was sent successfully.");
        }

        static async Task SendSalesMessageAsync()
        {
            // Create a Queue Client here
            queueClient = new QueueClient(ServiceBusConnectionString, QueueName);
            // Send messages.
            try
            {
                // Create and send a message here
                var messageBody = $"message here";
                var message = new Message(Encoding.UTF8.GetBytes(messageBody));
                Console.WriteLine($"Sending message: {messageBody}");
                await queueClient.SendAsync(message);
            }
            catch (Exception exception)
            {
                Console.WriteLine($"{DateTime.Now} :: Exception: {exception.Message}");
            }

            // Close the connection to the queue here
            await queueClient.CloseAsync();
        }
    }
}

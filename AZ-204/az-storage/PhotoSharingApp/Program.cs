using System;
using Microsoft.Extensions.Configuration;
using System.IO;
using Azure.Storage.Blobs;


namespace PhotoSharingApp
{
    class Program
    {
        static void Main(string[] args)
        {
            var builder = new ConfigurationBuilder()
                            .SetBasePath(Directory.GetCurrentDirectory())
                            .AddJsonFile("appsettings.json");

            var configuration = builder.Build();
            
            // Get a connection string to our Azure Storage account.
            var connectionString = configuration.GetConnectionString("StorageAccount");

             
             // Get a reference to the container client object so you can create the "photos" container
            string containerName = "photos";
            BlobContainerClient container = new BlobContainerClient(connectionString, containerName);
            container.CreateIfNotExists();


            //Upload an image to blob storage
            string blobName = "docs-and-friends-selfie-stick";
            string fileName = @"images\docs-and-friends-selfie-stick.png";
            BlobClient blobClient = container.GetBlobClient(blobName);
            blobClient.Upload(fileName, true);
            

            //List objects in an Azure Blob Storage container
            var blobs = container.GetBlobs();
            foreach (var blob in blobs)
            {
                Console.WriteLine($"{blob.Name} --> Created On: {blob.Properties.CreatedOn:yyyy-MM-dd HH:mm:ss}  Size: {blob.Properties.ContentLength}");
            }
        }
    }
}

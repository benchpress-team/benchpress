using System.Collections.Generic;

namespace BenchPress.TestEngine
{
  namespace Azure
  {
    public class Config
    {
      /*
      public void SetConfig(AzureConfig config)
      {
      }
      */
    }

    public class ResourceGroup
    {
      public KeyValuePair<string, string> GetResourceGroup(string nameOrResourceId)
      {
        if (nameOrResourceId.Contains("/"))
        {
          return GetResourceGroupById(nameOrResourceId);
        }
        return GetResourceGroupByName(nameOrResourceId);
      }

      private KeyValuePair<string, string> GetResourceGroupByName(string name)
      {
        return null;
      }

      private KeyValuePair<string, string> GetResourceGroupById(string id)
      {
        return null;
      }

      public bool CheckResourceGroupExists(string nameOrResourceId)
      {
        return GetResourceGroup(nameOrResourceId) != null;
      }
    }

    public class StorageAccount
    {
      public KeyValuePair<string, string> GetStorageAccount(string nameOrResourceId)
      {
        if (nameOrResourceId.Contains("/"))
        {
          return GetStorageAccountById(nameOrResourceId);
        }
        return GetStorageAccountByName(nameOrResourceId);
      }

      private KeyValuePair<string, string> GetStorageAccountByName(string name)
      {
        return null;
      }

      private KeyValuePair<string, string> GetStorageAccountById(string id)
      {
        return null;
      }

      public bool CheckStorageAccountExists(string nameOrResourceId)
      {
        return GetStorageAccount(nameOrResourceId) != null;
      }
    }
  }
  namespace Kubernetes
  {
  }
}

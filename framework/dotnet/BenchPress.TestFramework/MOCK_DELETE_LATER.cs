using System.Collections.Generic;

namespace BenchPress.TestEngine
{
  namespace Azure
  {
    public class Config
    {
      public void Set(Config config)
      {
      }
    }

    public class ResourceGroup
    {
      public object GetResourceGroup(string nameOrResourceId)
      {
        if (nameOrResourceId.Contains("/"))
        {
          return GetResourceGroupById(nameOrResourceId);
        }
        return GetResourceGroupByName(nameOrResourceId);
      }

      private object GetResourceGroupByName(string name)
      {
        return null;
      }

      private object GetResourceGroupById(string id)
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
      public object GetStorageAccount(string nameOrResourceId)
      {
        if (nameOrResourceId.Contains("/"))
        {
          return GetStorageAccountById(nameOrResourceId);
        }
        return GetStorageAccountByName(nameOrResourceId);
      }

      private object GetStorageAccountByName(string name)
      {
        return null;
      }

      private object GetStorageAccountById(string id)
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

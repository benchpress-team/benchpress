using System.Collections.Generic;

namespace BenchPress.TestEngine
{
  namespace Azure
  {
    public class ResourceGroup
    {
      public KeyValuePair<string, string> GetResourceGroup(string name)
      {
        return null;
      }

      public KeyValuePair<string, string> GetResourceGroup(string name, string location)
      {
        return null;
      }

      public bool IsResourceGroupExists(string name)
      {
        return GetResourceGroup(name);
      }

      public bool IsResourceGroupExists(string name, string location)
      {
        return GetResourceGroup(name, location);
      }
    }
  }
  namespace Kubernetes
  {
    
  }
}

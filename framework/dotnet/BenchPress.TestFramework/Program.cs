using System.Collections.Generic;

using BenchPress.TestEngine.Azure;

namespace BenchPress.TestFramework.Azure
{
  public static class ResourceGroup
  {
      public static KeyValuePair<string, string> GetResourceGroup(string name)
      {
        var engine = new ResourceGroup();

        return engine.GetResourceGroup(name);
      }

      public static KeyValuePair<string, string> GetResourceGroup(string name, string location)
      {
        var engine = new ResourceGroup();

        return engine.GetResourceGroup(name, location);
      }
  }
}

/*
sample usage;

var fullResourceGroup1 = ResourceGroup.GetResourceGroup("rg-test");

var fullResourceGroup2 = ResourceGroup.GetResourceGroup("rg-test", "eastus");

var isResourceGroup1Exists = ResourceGroup.IsResourceGroupExists("rg-test");

var isResourceGroup2Exists = ResourceGroup.IsResourceGroupExists("rg-test", "eastus");
*/

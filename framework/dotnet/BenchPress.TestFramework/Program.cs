using System.Collections.Generic;

using BenchPress.TestEngine.Azure;

namespace BenchPress.TestFramework.Azure
{
    public static class ResourceGroup
    {
        public static KeyValuePair<string, string> GetResourceGroup(string name, AzureConfig config = null)
        {
            var engine = new ResourceGroup();

            return engine.GetResourceGroup(name);
        }

        public static KeyValuePair<string, string> CheckResourceGroupExists(string name, AzureConfig config = null)
        {
            var engine = new ResourceGroup();

            return engine.CheckResourceGroupExists(name, location);
        }
    }
}

/*
sample usage;

Config.SetConfig("");

var fullResourceGroup1 = ResourceGroup.GetResourceGroup("rg-test");

var fullResourceGroup2 = ResourceGroup.GetResourceGroup("rg-test", config);

Config.SetConfig("");

var isResourceGroup1Exists = ResourceGroup.CheckResourceGroupExists("rg-test");

var isResourceGroup2Exists = ResourceGroup.CheckResourceGroupExists("rg-test", config);
*/

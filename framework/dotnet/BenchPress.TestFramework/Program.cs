using System.Collections.Generic;

namespace BenchPress.TestFramework.Azure
{
    public static class ResourceGroup
    {
        public static object GetResourceGroup(string name, BenchPress.TestEngine.Azure.Config config = null)
        {
            var engine = new BenchPress.TestEngine.Azure.ResourceGroup();

            return engine.GetResourceGroup(name);
        }

        public static object CheckResourceGroupExists(string name, BenchPress.TestEngine.Azure.Config config = null)
        {
            var engine = new BenchPress.TestEngine.Azure.ResourceGroup();

            return engine.CheckResourceGroupExists(name);
        }
    }
}

/*
sample usage;

Config.Set("");

var fullResourceGroup1 = ResourceGroup.GetResourceGroup("rg-test");

var fullResourceGroup2 = ResourceGroup.GetResourceGroup("rg-test", config);

Config.Set("");

var isResourceGroup1Exists = ResourceGroup.CheckResourceGroupExists("rg-test");

var isResourceGroup2Exists = ResourceGroup.CheckResourceGroupExists("rg-test", config);
*/

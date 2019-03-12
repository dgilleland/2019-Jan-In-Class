using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Capstone.Startup))]
namespace Capstone
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}

using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(FairviewMall.Startup))]
namespace FairviewMall
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}

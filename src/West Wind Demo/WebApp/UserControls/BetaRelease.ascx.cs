using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp.UserControls
{
    public partial class BetaRelease : System.Web.UI.UserControl
    {
        public string CssClass { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // Page_PreRender method is called just before the page is
        // translated into HTML/CSS/JavaScript that will be sent
        // to the browser.
        protected void Page_PreRender(object sender, EventArgs e)
        {
            // If they've supplied a value for CssClass, then I'll replace
            // the classname that I'm currently using for my <div >
            if(!string.IsNullOrWhiteSpace(CssClass))
            {
                ReleaseInfo.Attributes["class"] = CssClass;
            }
        }
    }
}
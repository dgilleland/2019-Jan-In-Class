using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp.CustomServerControls
{
    /// <summary>
    /// The CleanCheckBox control extends the <see cref="CheckBox"/> control by providing properties to apply classes and styles to the Input tag.
    /// </summary>
    /// <remarks>
    /// By default, the CheckBox control will apply a CssClass by first wrapping the
    /// HTML input tag in a span and then assigning the CssClass to the span rather
    /// than the input element. This server control provides additional properties to
    /// apply classes and styles directly to the input element.
    /// </remarks>
    public class CleanCheckBox : CheckBox
    {
        protected override void OnPreRender(EventArgs e)
        {
            InputAttributes["class"] = InputCssClass;
            InputAttributes["style"] = InputStyle;
        }

        public string InputCssClass { get; set; }
        public string InputStyle { get; set; }
    }
}
using System;
using System.Data.Entity.Validation;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using BackEnd.BLL;

namespace WebApp.UserControls
{
    public delegate void ProcessRequest();

    public partial class MessageUserControl : System.Web.UI.UserControl
    {
        #region String Constants
        private const string STR_TITLE_GeneralErrors = "Processing Error";
        private const string STR_TEXT_GeneralErrors = "Unable to process your submission due to the following reason(s).";
        private const string STR_TITLE_ValidationErrors = "Validation Errors";
        private const string STR_TEXT_ValidationErrors = "Validation errors encountered with your submission.";
        private const string STR_TITLE_UsageInstructions = "Usage Instructions";
        private const string STR_TITLE_ICON_warning = "glyphicon glyphicon-warning-sign";
        private const string STR_PANEL_danger = "panel panel-danger";
        private const string STR_TITLE_ICON_info = "glyphicon glyphicon-info-sign";
        private const string STR_PANEL_info = "panel panel-info";
        private const string STR_TITLE_ICON_success = "glyphicon glyphicon-ok-sign";
        private const string STR_PANEL_success = "panel panel-success";
        #endregion
        #region Event Handlers
        protected void Page_Load(object sender, EventArgs e)
        {
            MessagePanel.Visible = false;
        }
        #endregion
        #region Public methods - show messages and process requests within try/catch
        /// <summary>
        /// Displays a message in the message panel with a general title of "Usage Instructions"
        /// </summary>
        /// <param name="message">Text to display as the message</param>
        public void ShowInfo(string message)
        {
            ShowInfo(STR_TITLE_UsageInstructions, message);
        }
        /// <summary>
        /// Displays a message and title in the message panel with a general "info" display
        /// </summary>
        /// <param name="title">Title for the panel</param>
        /// <param name="message">Text to display as the message</param>
        public void ShowInfo(string title, string message)
        {
            ShowInfo(message, title, STR_TITLE_ICON_info, STR_PANEL_info);
        }
        /// <summary>
        /// Processes a request through a callback delegate within a try/catch block. Distinguished Entity Framework exceptions from general exceptions.
        /// </summary>
        /// <param name="callback">A delegate method to call within the try block</param>
        public void TryRun(ProcessRequest callback)
        {
            TryCatch(callback);
        }
        /// <summary>
        /// Processes a request through a callback delegate within a try/catch block. Distinguished Entity Framework exceptions from general exceptions.
        /// </summary>
        /// <param name="callback">A delegate method to call within the try block</param>
        /// <param name="title">Title for the panel</param>
        /// <param name="successMessage">Text to display as the message if the callback processes without an exception</param>
        public void TryRun(ProcessRequest callback, string title, string successMessage)
        {
            if (TryCatch(callback))
                ShowInfo(successMessage, title, STR_TITLE_ICON_success, STR_PANEL_success);
        }
        /// <summary>
        /// Checks for an exception from an ObjectDataSource event and handles it by showing the details of the exception.
        /// </summary>
        /// <param name="e">An event argument with details on the exception, if any</param>
        public void HandleDataBoundException(ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception is DbEntityValidationException)
            {
                HandleException(e.Exception as DbEntityValidationException);
                e.ExceptionHandled = true;
            }
            else if (e.Exception is TargetInvocationException && e.Exception.InnerException is DbEntityValidationException)
            {
                HandleException(e.Exception.InnerException as DbEntityValidationException);
                e.ExceptionHandled = true;
            }
            else if (e.Exception is Exception)
            {
                HandleException(e.Exception as Exception);
                e.ExceptionHandled = true;
            }
        }
        #endregion
        #region Private methods - process details of messaging
        /// <summary>
        /// Processes a request through a callback delegate within a try/catch block. Distinguished Entity Framework exceptions from general exceptions.
        /// </summary>
        /// <param name="callback">A delegate method to call within the try block</param>
        /// <returns>True if the callback was successful (did not generate an exception); false otherwise</returns>
        private bool TryCatch(ProcessRequest callback)
        {
            try
            {
                callback();
                return true;
            }
            catch (BusinessRuleException ex)
            {
                HandleException(ex);
            }
            catch (DbEntityValidationException ex) // gets thrown by EF when validating on SaveChanges()
            {
                HandleException(ex);
            }
            catch (Exception ex)
            {
                HandleException(ex);
            }
            return false;
        }
        private void HandleException(BusinessRuleException ex)
        {
            var details = from error in ex.Errors
                          select new
                          {
                              Error = error.Message
                          };
            ShowExceptions(details, $"There are business rule errors in processing {ex.ExecutionContext}", STR_TITLE_ValidationErrors, STR_TITLE_ICON_warning, STR_PANEL_danger);
        }
        /// <summary>
        /// Handles a DbEntityValidationException by getting the details of each validation error and showing it as a Validation Exception.
        /// </summary>
        /// <param name="ex">An exception object generated from Entity Framework</param>
        private void HandleException(DbEntityValidationException ex)
        {
            var details = from DbValidationError error in ex.EntityValidationErrors.First().ValidationErrors
                          select new
                          {
                              Error = error.ErrorMessage
                          };
            ShowExceptions(details, STR_TEXT_ValidationErrors, STR_TITLE_ValidationErrors, STR_TITLE_ICON_warning, STR_PANEL_danger);
        }
        /// <summary>
        /// Handles an Exception by getting the root of the error and showing it as a General Exception.
        /// </summary>
        /// <param name="ex">A general Exception object</param>
        private void HandleException(Exception ex)
        {
            Exception root = ex;
            while (root.InnerException != null)
                root = root.InnerException;
            if (root is DbEntityValidationException)
                HandleException(root as DbEntityValidationException);
            else
            {
                dynamic[] details = new dynamic[] { new { Error = root.Message } };
                ShowExceptions(details, STR_TEXT_GeneralErrors, STR_TITLE_GeneralErrors, STR_TITLE_ICON_warning, STR_PANEL_danger);
            }
        }
        /// <summary>
        /// Binds error details to the repeater and displays the message panel.
        /// </summary>
        /// <param name="details">Details of the exception or message</param>
        /// <param name="messageText">Text to display as the message</param>
        /// <param name="messageTitle">Title for the panel</param>
        /// <param name="titleIcon">Icon to show in the panel title</param>
        /// <param name="panelClass">CSS Class to apply to the panel</param>
        private void ShowExceptions(object details, string messageText, string messageTitle, string titleIcon, string panelClass)
        {
            MessageDetailsRepeater.DataSource = details;
            MessageDetailsRepeater.DataBind();
            ShowInfo(messageText, messageTitle, titleIcon, panelClass);
        }
        /// <summary>
        /// Displays the message panel.
        /// </summary>
        /// <param name="messageText">Text to display as the message</param>
        /// <param name="messageTitle">Title for the panel</param>
        /// <param name="titleIcon">Icon to show in the panel title</param>
        /// <param name="panelClass">CSS Class to apply to the panel</param>
        private void ShowInfo(string messageText, string messageTitle, string titleIcon, string panelClass)
        {
            MessageLabel.Text = messageText;
            MessageTitle.Text = messageTitle;
            MessageTitleIcon.CssClass = titleIcon;
            MessagePanel.CssClass = panelClass;
            MessagePanel.Visible = true;
        }
        #endregion
    }
    }
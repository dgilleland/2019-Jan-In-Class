# Notes on Setting Up Client-Server in VS

1. Create Web Application Project (use separate names for the project and the solution)
1. Update NuGet packages
1. Add a Class Library project for the BLL/DAL
1. Add a Class Library project for the Entities
1. Add a NuGet package for all projects - Entity Framework 6
1. Add references between the projects
    - WebApp needs to access both class libraries
    - BLL/DAL project needs to access the Entities


----

# Good Morning

In case you are wondering, I'm using VS Code as a plain-text editor, and VuePress for rendering markdown content as HTML. Every time I save this `ReadMe.md` file, it updates the browser automatically. We will start in about **5 minutes**.

> I've got a really sore throat, so I will be typing instead of talking. Lucky you!

Today's agenda:

- Recap on GridView Usage
- Info on GridView customization & paging
  - Paging code-behind
- Lab Marking - CRUD form
  - I will be marking this outside of class, so that I don't have to stand over your shoulder and breathe on you. [cough, cough]

## Gridview Usage

When using a GridView, you have two ways to fill it with data:

- **Programmatically** - Here, you set the `.DataSource` property, and then you call `.DataBind()`
  - *Caveats* - When you take programmatic control, then you are responsible to keep it populated if the underlying data changes. If you use paging, then you will need to do the following to keep it up to date.
    - In the `.aspx`, you will need to create an event handler for the `OnPageIndexChanging` event.
    - In that handler, you will use the second parameter, the `GridViewPageEventArgs` object, to get the `.NewPageIndex`. Set the GridView's `.PageIndex` to that value, then re-populate the control. For example:

```csharp
protected void CourseResultList_PageIndexChanging(object sender, GridViewPageEventArgs e)
{
    // set the new page index on the Gridview
    CourseResultList.PageIndex = e.NewPageIndex;

    //refresh the GridView from its data source
    ToolsController systemmgr = new ToolsController();
    List<Course> courseInfo = systemmgr.GetCourses();
    CourseResultList.DataSource = courseInfo;
    CourseResultList.DataBind();
}
```


- **`<asp:ObjectDataSource >` Control** - Here, you can have the GridView's `DataSourceID` property set to the ID of an `<asp:ObjectDataSource>` control.
  - Make sure your BLL class has the `[DataObject]` attribute.
  - Use the `[DataObjectMethod]` attribute on your method that returns data. The "type" should be for Selecting data.
  - If you are using paging, then you do **not** want to use code-behind to refresh the GridView's contents. The ObjectDataSource will do that for you.

## Questions?

> Welcome to the Monestary. I am not permitted to speak, but you can.

## Customizing the GridView

Details can be found here: [https://dmit-2018.github.io/topics/aspNet/databound/gridviewCustomization.html](https://dmit-2018.github.io/topics/aspNet/databound/gridviewCustomization.html)

In general, you want to:

- Use a `<TemplateField>` with an `<ItemTemplate>`.
- Inside the `<ItemTemplate>`, put whatever controls you want to use, such as a DropDownList. E.g.:

```csharp
<asp:TemplateField HeaderText="Supplier">
    <ItemTemplate>
        <asp:DropDownList ID="SupplierDropDown" runat="server"
            SelectedValue="<%# Item.SupplierID %>"
            DataSourceID="SupplierDataSource">
        </asp:DropDownList>
    </ItemTemplate>
</asp:TemplateField>
```

- The DropDown's `SelectedValue` is set to the GridView data object's property that acts as the foreign key.
- The DropDown's content can come from an ObjectDataSource.
----

## References

- [GridView Control](https://dmit-2018.github.io/topics/aspNet/databound/gridviewOverview.html#data-source)
  - https://dmit-2018.github.io/topics/aspNet/databound/gridviewOverview.html#data-source
- [Customizing a GridView](https://dmit-2018.github.io/topics/aspNet/databound/gridviewCustomization.html)
  - https://dmit-2018.github.io/topics/aspNet/databound/gridviewCustomization.html

<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
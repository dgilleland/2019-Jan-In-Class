# Notes on Setting Up Client-Server in VS

1. Create Web Application Project (use separate names for the project and the solution)
1. Update NuGet packages
1. Add a Class Library project for the BLL/DAL
1. Add a Class Library project for the Entities
1. Add a NuGet package for all projects - Entity Framework 6
1. Add references between the projects
    - WebApp needs to access both class libraries
    - BLL/DAL project needs to access the Entities

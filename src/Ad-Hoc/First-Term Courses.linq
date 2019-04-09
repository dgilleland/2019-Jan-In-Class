<Query Kind="Expression">
  <Connection>
    <ID>1b4ef6cb-b367-468c-b213-b925de23ad5a</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>A01-School</Database>
    <ShowServer>true</ShowServer>
  </Connection>
</Query>

//Students.Where(x => x.Registrations.Count == 0)
Courses.Where(x => x.CourseId[4] == '1' && x.CourseId[5] < '5')
using CapstoneSystem.DAL;
using CapstoneSystem.Entities;
using CapstoneSystem.Entities.POCOs;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapstoneSystem.BLL
{
    [DataObject]
    public class CapstoneTeamController
    {
        #region Query Methods
        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<StudentInfo> ListAllStudents()
        {
            using (var context = new CapstoneContext())
            {
                var results = from person in context.Students
                              select new StudentInfo
                              {
                                  StudentId = person.StudentId,
                                  FullName = person.FirstName + " " + person.LastName
                              };
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<ClientInfo> ListCapstoneClients()
        {
            using (var context = new CapstoneContext())
            {
                var results = from company in context.CapstoneClients
                              where company.Confirmed
                              select new ClientInfo
                              {
                                  ClientId = company.Id,
                                  Company = company.CompanyName
                              };
                return results.ToList();
            }
        }
        #endregion

        #region Command Methods
        public void AssignTeams(List<StudentAssignment> data)
        {
            // Step 0 - Business Rules:
            // - The smallest team size is four students
            // - The largest team size is seven students
            // - Clients with more than seven students must be broken into separate teams, each with a team letter(starting with 'A').
            // - Only assign students to clients that have been confirmed as participating.

            // Step 1 - OLTP
            using (var context = new CapstoneContext())
            {
                foreach(var item in data)
                {
                    var assignment = new TeamAssignment();
                    assignment.ClientId = item.ClientId;
                    assignment.StudentId = item.StudentId;
                    assignment.TeamNumber = item.TeamLetter;

                    context.TeamAssignments.Add(assignment);
                }

                // And... Commit all the changes
                context.SaveChanges(); // OLTP all done
            }
        }
        #endregion
    }
}

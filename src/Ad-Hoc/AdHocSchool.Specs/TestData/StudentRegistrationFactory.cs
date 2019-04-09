﻿using AdHocSchool.DAL;
using AdHocSchool.DataModels;
using AdHocSchool.Entities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AdHocSchool.Specs.TestData
{
    public class StudentRegistrationFactory
    {
        #region Factory Setup
        private StudentRegistration _data;
        public static StudentRegistrationFactory Instance => new StudentRegistrationFactory();
        private StudentRegistrationFactory()
        {
            _data = new StudentRegistration
            {
                Month = StudentRegistration.Term.SEP,
                Year = DateTime.Today.Year,
                StudentIds = UnregisteredStudents
            };
        }
        private static List<int> _students;
        private static List<int> UnregisteredStudents
        {
            get
            {
                if (_students == null)
                    using (var context = new AdHocContext())
                    {
                        _students = context.Students.Where(x => x.Registrations.Count == 0).Select(x => x.StudentID).ToList();
                    }
                return new List<int>(_students); // shallow clone
            }
        }
        #endregion

        #region Factory Methods
        public StudentRegistration Build()
        {
            return _data;
        }

        #region Fluent methods for modifying the test data
        public StudentRegistrationFactory WithoutStudents()
        {
            _data.StudentIds.Clear(); // empty out the list of student ids
            return this;
        }

        public StudentRegistrationFactory WithSchoolYear(int year)
        {
            _data.Year = year;
            return this;
        }
        #endregion

        #region Methods for getting back test data
        public List<Registration> ListFirstTermRegistrations(string semester)
        {
            using (var context = new AdHocContext())
            {
                var result = from data in context.Registrations
                             where data.Semester == semester
                                && data.CourseId[4] == '1'
                                && data.CourseId[5] < '5'
                             select data;
                return result.Include(x => x.Student).ToList();
            }
        }
        #endregion
        #endregion
    }
}

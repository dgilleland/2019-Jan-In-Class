using System;

namespace LanguageReview.CSharp.Inheritance
{
    public abstract class AbstractLock
    {
        public bool IsLocked { get; protected set; }
        public virtual void Lock()
        {
            IsLocked = true;
        }
        public abstract void Unlock(params int[] keyNumbers);
    }
}
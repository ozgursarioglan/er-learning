CREATE TABLE "tblClasses" (
  "classId" SERIAL PRIMARY KEY,
  "className" varchar,
  "teacherId" int,
  "createdTime" datetime,
  "updateTime" datetime
);

CREATE TABLE "tblStudents" (
  "studentId" SERIAL PRIMARY KEY,
  "studentFirstName" varchar,
  "studentLastName" varchar,
  "number" int,
  "notes" text,
  "classId" int,
  "familyId" int,
  "createdTime" datetime,
  "updateTime" datetime
);

CREATE TABLE "tblFamilies" (
  "familyId" SERIAL PRIMARY KEY,
  "familyName" varchar,
  "telephone" varchar,
  "address" text,
  "email" text,
  "createdTime" datetime,
  "updateTime" datetime
);

CREATE TABLE "tblTeachers" (
  "teacherId" SERIAL PRIMARY KEY,
  "teacherName" varchar,
  "createdTime" datetime,
  "updateTime" datetime
);

CREATE TABLE "tblHomeworks" (
  "homeworkId" SERIAL PRIMARY KEY,
  "homeworkName" varchar,
  "lessonId" int,
  "teacherId" int,
  "createdTime" datetime,
  "updateTime" datetime
);

CREATE TABLE "tblLessons" (
  "lessonId" SERIAL PRIMARY KEY,
  "lessonName" varchar,
  "teacherId" int
);

CREATE TABLE "tblLessonContents" (
  "lessonContentId" SERIAL PRIMARY KEY,
  "lessonContentName" varchar,
  "contentType" int,
  "lessonId" int,
  "createdTime" datetime,
  "updateTime" datetime
);

CREATE TABLE "tblHomeworkGrades" (
  "homeworkGradeId" SERIAL PRIMARY KEY,
  "homeworkId" int,
  "studentId" int,
  "studentNotes" text,
  "familyNotes" text,
  "createdTime" datetime,
  "updateTime" datetime
);

ALTER TABLE "tblClasses" ADD FOREIGN KEY ("classId") REFERENCES "tblStudents" ("classId");

ALTER TABLE "tblFamilies" ADD FOREIGN KEY ("familyId") REFERENCES "tblStudents" ("familyId");

ALTER TABLE "tblTeachers" ADD FOREIGN KEY ("teacherId") REFERENCES "tblClasses" ("teacherId");

ALTER TABLE "tblTeachers" ADD FOREIGN KEY ("teacherId") REFERENCES "tblHomeworks" ("teacherId");

ALTER TABLE "tblLessons" ADD FOREIGN KEY ("lessonId") REFERENCES "tblHomeworks" ("lessonId");

ALTER TABLE "tblTeachers" ADD FOREIGN KEY ("teacherId") REFERENCES "tblLessons" ("teacherId");

ALTER TABLE "tblHomeworks" ADD FOREIGN KEY ("homeworkId") REFERENCES "tblHomeworkGrades" ("homeworkId");

ALTER TABLE "tblStudents" ADD FOREIGN KEY ("studentId") REFERENCES "tblHomeworkGrades" ("studentId");

ALTER TABLE "tblLessons" ADD FOREIGN KEY ("lessonId") REFERENCES "tblLessonContents" ("lessonId");

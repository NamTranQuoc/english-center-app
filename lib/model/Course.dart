class Course {
  final String name;
  final int numOfCourses;
  final String image;
  final int numberStudent;
  final String dateStart;

  Course(this.name, this.numOfCourses, this.image, this.numberStudent,
      this.dateStart);
}

List<Course> courses = [
  Course("Toeic 500+", 1, "assets/images/marketing.png", 20, "15/05/2022"),
  Course("Toeic 600+", 2, "assets/images/ux_design.png", 15, "01/06/2022"),
  Course("Toeic 700+", 3, "assets/images/photography.png", 17, "20/05/2022"),
  Course("Toeic 800+", 4, "assets/images/business.png", 25, "10/06/2022"),
  Course("Toeic 850+", 5, "assets/images/business.png", 10, "05/05/2022")
];

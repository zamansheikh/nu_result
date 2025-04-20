// ignore: constant_identifier_names
const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';
// ignore: constant_identifier_names
const TRIVIABASE_API_URL = 'http://numbersapi.com/';
// ignore: constant_identifier_names
const NU_DEMO_URL =
    'http://results.nu.ac.bd/honours/second_year_result_show.php?roll_number=&reg_no=13227207816&exam_year=2015';

enum ExamType { first, second, third, fourth }

 String getUrlViaRegistrationNumber(String registrationNumber, String examYear, ExamType examType, String rollNumber) {
  final examTypeString = examType.toString().split('.').last;
  return 'http://results.nu.ac.bd/honours/${examTypeString}_year_result_show.php?roll_number=$rollNumber&reg_no=$registrationNumber&exam_year=$examYear';
}

///LOGIN & SIGN UP
const LOGIN = 'login/employee';
const LOGOUT = 'logout';
const SIGHNUPUSER = 'create/user';
const SIGHNUPEMPLOYY = 'employee/create/employee';
const SIGHNUPADDRESS= 'address/create';
const SIGHNUPSKILL= 'employee/create/skill';
const SIGHNUPADDFAV= 'employee/favorite/add';
const SIGHNUPGETCAT= 'category/index';
const SIGHNUPGETSUBCAT= 'section/getSectionByCaateogry/';

///PROFILE
const PROFILE = "employee/show";
const EDIT_PROFILE = "employee/update";
const ADD_LOCATION = "address/create";
const ADD_SKILL = "employee/create/skill";
const ADD_FAVOURITE = "employee/favorite/add";
const EMPLOYEE_PROFILE = "employee/profile";
const COMPANY_PROFILE = "company";
const ADD_RATING = "employee/ratings/create";
const GET_MY_JOBS = "employee/vacancy/getMyJobs";
const GET_MY_JOB_APPLICATIONS = "employee/vacancy/getApplications";
const ADD_JOB = "vacancy/create";
const DELETE_JOB = "vacancy/delete";
const SEND_VERIFICATION = "auth_request/create";
const CANCEL_VERIFICATION = "auth_request/delete";
///JOBS
const GET_COMPANIES_JOBS="vacancy/index/companies";
const GET_FAV_JOBS="employee/vacancy/getFavorite";
const GET_COMPANIES="company/index";
const GET_JOB_DETAILS="vacancy/show";
const GET_JOBS_OF_COMPANY="vacancy/company";

///SEARCH & FILTER
const SEARCH="vacancy/search";
const GET_CATEGORIES="category/index";
const GET_SECTIONS="section/index";
const GET_SECTIONS_FOR_CATEGORY="section/getSectionByCategory";
const FILTER="vacancy/filter";
const GET_CITIES="getCites";
const GET_FREELANCE = "vacancy/index/freelance";

///APPLICATIONS
const APPLY_TO_JOB="vacancy/applyVacancy";
const GET_APPLICATIONS="employee/vacancy/getMyApplications";
const CANCEL_APPLICATION="ReqquestJobs/delete";
const ACCEPT_APPLICATION ="ReqquestJobs/accept";
const REJECT_APPLICATION ="ReqquestJobs/reject";
///QUESTIONS
const ADD_QUESTION = "question/create";
const DELETE_QUESTION = "question/delete";
const EDIT_QUESTION = "question/update";
const REPORT_QUESTION = "question/report";
const GET_QUESTIONS_LATEST = "question/indexByDate";
const GET_QUESTIONS_CATEGORY = "question/indexBySection";
const LIKE_QUESTION = "question/like";

///ANSWERS
const ADD_ANSWER = "answer";
const GET_ANSWERS = "answer";
const DELETE_ANSWER = "answer";
const EDIT_ANSWER = "answer/update";
const REPORT_ANSWER = "report/answer";
const LIKE_ANSWER = "answer/like";

///ADVICES
const ADD_ADVICE = "advice/create";
const GET_ADVICES_LIKED = "advice/indexByLike";
const GET_ADVICES_LATEST = "advice/indexByDate";
const DELETE_ADVICE = "advice/delete";
const EDIT_ADVICE = "advice/update";
const REPORT_ADVICE = "advice/report";
const LIKE_ADVICE = "advice/like";

///ANNOUNCEMENTS
const GET_ANNOUNCEMENTS = "announcement/index";

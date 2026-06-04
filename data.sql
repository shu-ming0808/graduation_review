USE mydb;

INSERT INTO college (college_id, college_name)
VALUES ('100', 'LA'), ('102', 'EDU'), ('200', 'SS'), ('203', 'IA'), ('300', 'BUS'), ('400', 'COMM'),
('500', 'FL'), ('600', 'LAW'), ('700', 'SCI'), ('ZU1', 'ICI'), ('000', 'PE');

INSERT INTO department (department_id, department_name, college_id)
VALUES ('101', 'CHIN', '100'), ('102', 'EDUC', '102'), ('103', 'HIST', '100'), ('104', 'PHIL', '100'),
('202', 'POLS', '200'), ('203', 'DIPL', '203'), ('204', 'SOCI', '200'), ('205', 'PF', '200'),
('206', 'PA', '200'), ('207', 'LAND', '200'), ('208', 'ECON', '200'), ('209', 'ETHN', '200'),
('301', 'IB', '300'), ('302', 'FIN', '300'), ('303', 'ACCT', '300'), ('304', 'STAT', '300'),
('305', 'BA', '300'), ('306', 'MIS', '300'), ('307', 'FM', '300'), ('308', 'RMI', '300'),
('401', 'JOUR', '400'), ('402', 'ADV', '400'), ('403', 'RTF', '400'), ('405', 'COMM', '400'),
('501', 'ENG', '500'), ('502', 'ARAB', '500'), ('504', 'SLAV', '500'), ('506', 'JPN', '500'),
('507', 'KOR', '500'), ('508', 'TUR', '500'), ('509', 'EURO', '500'), ('510', 'SEAL', '500'),
('601', 'LAW', '600'), ('701', 'MATH', '700'), ('702', 'PSYC', '700'), ('703', 'CS', '700'),
('ZU1', 'ICI', 'ZU1'), ('000', 'PE', '000');

INSERT INTO graduation_rule (rule_id, entry_year, total_credits_min)
VALUES (1, '111', 128), (2, '113', 128);

INSERT INTO waiver_limit_rule (transfer_entry_level, transfer_grade, max_waiver_credits)
VALUES (1, 'G1S2', 20), (2, 'G2', 40), (3, 'G3', 80);

INSERT INTO course (course_id, course_name, credits, department_id, category, is_core_ge)
VALUES ('000713032', 'Calculus', 6, '701', 'college_required', 0),
('000219572', 'Economics', 6, '301', 'college_required', 0),
('000359011', 'Statistics I', 3, '304', 'college_required', 0),
('000360011', 'Statistics II', 3, '304', 'college_required', 0),
('000314141', 'Principles of Accounting I', 3, '303', 'college_required', 0),
('000361021', 'Social Responsibility and Ethics', 1, '305', 'college_required', 0),

('304004002', 'Linear Algebra', 6, '304', 'dept_required', 0),
('304030001', 'Programming and Statistical Software', 3, '304', 'dept_required', 0),
('304025001', 'Probability Theory', 3, '304', 'dept_required', 0),
('304008001', 'Regression Analysis I', 3, '304', 'dept_required', 0),
('304026001', 'Mathematical Statistics I', 3, '304', 'dept_required', 0),
('304029001', 'Mathematical Statistics II', 3, '304', 'dept_required', 0),

('000348041', 'Management', 3, '305', 'college_core_elective', 0),
('305009001', 'Human Resource Management', 3, '305', 'college_core_elective', 0),
('000350011', 'Marketing Management', 3, '305', 'college_core_elective', 0),
('300922001', 'Risk Management', 3, '305', 'college_core_elective', 0),
('000347001', 'Financial Management', 3, '302', 'college_core_elective', 0),
('301050001', 'Business Analytics', 3, '301', 'college_core_elective', 0),
('305023001', 'Information Management', 3, '305', 'college_core_elective', 0),
('070244001', 'Operations and Supply Chain Management', 3, '305', 'college_core_elective', 0),

('304021011', 'Survey Sampling', 3, '304', 'dept_core_elective', 0),
('304022011', 'Analysis of Variance and Experimental Design', 3, '304', 'dept_core_elective', 0),
('304023011', 'Multivariate Analysis', 3, '304', 'dept_core_elective', 0),
('304028011', 'Time Series Analysis', 3, '304', 'dept_core_elective', 0),

('041195001', 'Art and Contemporary Society', 3, '405', 'ge_hum', 1),
('041135001', 'Western Literary Classics and Humanistic Thinking', 3, '501', 'ge_hum', 1),
('041123001', 'Exploration of Life and Religious Culture', 3, '204', 'ge_hum', 1),
('041099041', 'Civilization Development and Historical Thinking', 3, '103', 'ge_hum', 1),
('041177001', 'Humanities and Science of Language', 3, '101', 'ge_hum', 1),
('041133011', 'Modern Taiwanese History and Historical Figures', 3, '103', 'ge_hum', 1),
('041501001', 'History of Western Art', 2, '103', 'ge_hum', 0),
('041502001', 'Introduction to Philosophy', 2, '104', 'ge_hum', 0),
('041503001', 'Classical Chinese Literature Appreciation', 2, '101', 'ge_hum', 0),
('041504001', 'World Civilizations and Cultures', 2, '103', 'ge_hum', 0),
('041505001', 'Ethics and Modern Life', 2, '104', 'ge_hum', 0),

('042112091', 'Taiwanese Politics', 3, '202', 'ge_soc', 1),
('042137001', 'Legal Literacy', 3, '601', 'ge_soc', 1),
('042139021', 'Introduction to Intellectual Property Rights', 3, '703', 'ge_soc', 1),
('042116011', 'Economics in Everyday Life', 3, '205', 'ge_soc', 1),
('042133001', 'Thinking Sociologically', 3, '204', 'ge_soc', 1),
('042181001', 'Educational Exploration and Self-Directed Learning', 3, '102', 'ge_soc', 1),
('042142001', 'Global Perspectives and International Challenges', 3, '203', 'ge_soc', 1),
('042156001', 'Introduction to Mainland China', 3, '510', 'ge_soc', 1),
('042501001', 'Modern Political Systems', 2, '202', 'ge_soc', 0),
('042502001', 'Introduction to Sociology', 2, '204', 'ge_soc', 0),
('042503001', 'Basic Economic Principles', 2, '208', 'ge_soc', 0),
('042504001', 'Social Welfare and Justice', 2, '205', 'ge_soc', 0),
('042505001', 'Democracy and Citizenship', 2, '202', 'ge_soc', 0),
('042506001', 'Urban Society and Culture', 2, '204', 'ge_soc', 0),

('043030001', 'Mathematics, Logic, and Life', 3, '701', 'ge_nat', 1),
('043010001', 'Rhythm in Everyday Life', 3, '701', 'ge_nat', 1),
('043024001', 'History of Physics and Human Civilization', 3, '701', 'ge_nat', 1),
('043016001', 'Life Sciences in Everyday Life', 3, '701', 'ge_nat', 1),
('043031001', 'Psychology and Daily Life', 3, '702', 'ge_nat', 1),
('043025001', 'The Brain and Me', 3, '701', 'ge_nat', 1),
('043027001', 'Technology, Humanities, and Society', 3, '703', 'ge_nat', 1),
('043501001', 'Mathematics and Human Civilization', 2, '701', 'ge_nat', 0),
('043502001', 'Introduction to Brain Science', 2, '702', 'ge_nat', 0),
('043503001', 'Basic Computer Science and Logic', 2, '703', 'ge_nat', 0),
('043504001', 'Exploring Statistics in Daily Life', 2, '701', 'ge_nat', 0),
('043505001', 'Artificial Intelligence and Society', 2, '703', 'ge_nat', 0),

('046008001', 'Design Thinking and Software Project Management', 3, '703', 'ge_it', 0),

('045025001', 'Animal Rights: Theory and Practice', 1, '509', 'ge_rc', 0),

('031004011', 'Selected Readings in Classical Chinese Poetry', 3, '101', 'ge_ch', 0),
('031001001', 'University Chinese: Literary Classics', 3, '101', 'ge_ch', 0),
('031005001', 'Modern Prose and Creative Writing', 3, '101', 'ge_ch', 0),

('032001021', 'College English I', 3, '501', 'ge_fl', 0),
('032002021', 'College English II', 3, '501', 'ge_fl', 0),
('032003001', 'College English I', 3, '501', 'ge_fl', 0),
('032004001', 'College English II', 3, '501', 'ge_fl', 0),

('000357011', 'Multimedia and Programming Applications', 3, '308', 'elective', 0),
('000302001', 'Intermediate Microeconomics', 3, '208', 'elective', 0),
('000305001', 'Game Theory', 3, '208', 'elective', 0),
('305011001', 'Consumer Behavior', 3, '305', 'elective', 0),
('301044001', 'Financial Statements Analysis', 3, '302', 'elective', 0),
('301001001', 'International Business Management', 3, '301', 'elective', 0),
('302001001', 'Investment Analysis', 3, '302', 'elective', 0),
('302002001', 'Futures and Options', 3, '302', 'elective', 0),
('305001001', 'Organizational Behavior', 3, '305', 'elective', 0),
('305002001', 'Leadership and Teamwork', 3, '305', 'elective', 0),
('306001001', 'E-Commerce', 3, '306', 'elective', 0),
('308001001', 'Introduction to Insurance', 3, '308', 'elective', 0),
('703001001', 'Data Structures', 3, '703', 'elective', 0),
('703002001', 'Web Application Development', 3, '703', 'elective', 0),
('702001001', 'Social Psychology', 3, '702', 'elective', 0),
('208001001', 'Microeconomics II', 3, '208', 'elective', 0),
('208002001', 'Macroeconomics II', 3, '208', 'elective', 0),
('202001001', 'Political Theory', 3, '202', 'elective', 0),
('204001001', 'Sociological Theory', 3, '204', 'elective', 0),
('101001001', 'Contemporary Chinese Literature', 3, '101', 'elective', 0),
('103001001', 'Modern Chinese History', 3, '103', 'elective', 0),
('104001001', 'Introduction to Logic', 3, '104', 'elective', 0),
('501001001', 'English Professional Writing', 3, '501', 'elective', 0),
('506001001', 'Beginner Japanese Conversation', 3, '506', 'elective', 0),
('509001001', 'European Cultural Studies', 3, '509', 'elective', 0),
('401001001', 'News Reporting and Writing', 3, '401', 'elective', 0),
('405001001', 'Digital Communication', 3, '405', 'elective', 0),
('601001001', 'Introduction to Civil Law', 3, '601', 'elective', 0),
('ZU1001001', 'Global Issues and Sustainable Development', 3, 'ZU1', 'elective', 0),
('102001001', 'Educational Psychology', 3, '102', 'elective', 0),

('002062041', 'Beginner Badminton', 2, '000', 'pe', 0),
('002115001', 'Intermediate Badminton', 2, '000', 'pe', 0),
('002303041', 'Beginner Table Tennis', 2, '000', 'pe', 0),
('002368011', 'Orienteering', 2, '000', 'pe', 0),
('002122001', 'Beginner Swimming', 2, '000', 'pe', 0),
('002133001', 'Beginner Tennis', 2, '000', 'pe', 0),
('002144001', 'Fitness and Weight Training', 2, '000', 'pe', 0),
('002155001', 'Yoga and Mindfulness', 2, '000', 'pe', 0);

INSERT INTO student (student_id, student_name, entry_year, student_type, transfer_entry_level)
VALUES ('111304032', 'Urania', '111', 'regular', NULL),
('111304001', 'Alice', '111', 'regular', NULL),
('111304002', 'Bob', '111', 'regular', NULL),
('111304003', 'Charlie', '111', 'regular', NULL),
('111304004', 'David', '111', 'regular', NULL),
('111304010', 'Eva', '111', 'regular', NULL),

('111304801', 'Grace', '111', 'transfer', 1),
('111304802', 'Henry', '111', 'transfer', 2),
('111304803', 'Ivy', '111', 'transfer', 2),
('111304804', 'Jack', '111', 'transfer', 3),

('113304001', 'Kathy', '113', 'regular', NULL),
('113304002', 'Leo', '113', 'regular', NULL),
('113304003', 'Mia', '113', 'regular', NULL),
('113304004', 'Noah', '113', 'regular', NULL),
('113304015', 'Olivia', '113', 'regular', NULL),

('113304801', 'Peter', '113', 'transfer', 1),
('113304802', 'Quinn', '113', 'transfer', 2),
('113304803', 'Rose', '113', 'transfer', 2),
('113304804', 'Steve', '113', 'transfer', 3),
('113304805', 'Toby', '113', 'transfer', 3);

INSERT INTO rule_condition (condition_id, rule_id, category, min_credits, max_credits, min_courses, restrict_dept_id, restrict_college_id)
VALUES (1, 1, 'college_required', 22, NULL, NULL, NULL, '300'),
(2, 1, 'dept_required', 20, NULL, NULL, '304', NULL),
(3, 1, 'college_core_elective', 3, NULL, 1, NULL, '300'),
(4, 1, 'dept_core_elective', 6, NULL, 2, '304', NULL),
(5, 1, 'ge_hum', 3, 7, NULL, NULL, NULL),
(6, 1, 'ge_soc', 3, 7, NULL, NULL, NULL),
(7, 1, 'ge_nat', 3, 7, NULL, NULL, NULL),
(8, 1, 'ge_it', 0, 3, NULL, NULL, NULL),
(9, 1, 'ge_rc', 0, 3, NULL, NULL, NULL),
(10, 1, 'ge_ch', 3, 6, NULL, NULL, NULL),
(11, 1, 'ge_fl', 6, 6, NULL, NULL, NULL),
(12, 1, 'ge', 28, 28, NULL, NULL, NULL),
(13, 1, 'pe', NULL, NULL, 4, NULL, NULL),

(14, 2, 'college_required', 22, NULL, NULL, NULL, '300'),
(15, 2, 'dept_required', 21, NULL, NULL, '304', NULL),
(16, 2, 'college_core_elective', 3, NULL, 1, NULL, '300'),
(17, 2, 'dept_core_elective', 9, NULL, 3, '304', NULL),
(18, 2, 'ge_hum', 3, 7, NULL, NULL, NULL),
(19, 2, 'ge_soc', 3, 7, NULL, NULL, NULL),
(20, 2, 'ge_nat', 3, 7, NULL, NULL, NULL),
(21, 2, 'ge_it', 0, 3, NULL, NULL, NULL),
(22, 2, 'ge_rc', 0, 3, NULL, NULL, NULL),
(23, 2, 'ge_ch', 3, 6, NULL, NULL, NULL),
(24, 2, 'ge_fl', 6, 6, NULL, NULL, NULL),
(25, 2, 'ge', 28, 28, NULL, NULL, NULL),
(26, 2, 'pe', NULL, NULL, 4, NULL, NULL);


-- 1. 學生 Urania (111304032) - 資深學生，修課豐富
INSERT INTO take_record (student_id, course_id, semester, score, passed)
VALUES ('111304032', '000713032', '111', 85, 1), -- Calculus (學院必修)
('111304032', '000219572', '111', 78, 1), -- Economics (學院必修)
('111304032', '000359011', '111', 92, 1), -- Statistics I (學院必修)
('111304032', '304004002', '111', 88, 1), -- Linear Algebra (系必修)
('111304032', '041195001', '112', 90, 1), -- Art (人文通識)
('111304032', '042112091', '112', 75, 1), -- Taiwanese Politics (社會通識)
('111304032', '043030001', '112', 82, 1), -- Math in Life (自然通識)
('111304032', '002062041', '112', 95, 1), -- Badminton (體育1)
('111304032', '002115001', '113', 88, 1), -- Intermediate Badminton (體育2)
('111304032', '031004011', '111', 70, 1), -- Classical Poetry (國文)
('111304032', '032001021', '111', 82, 1); -- College English I (英文)

-- 2. 學生 Alice (111304001) - 測試【重修邏輯】
-- 第一次修微積分被當 (score 45, passed 0)
INSERT INTO take_record (student_id, course_id, semester, score, passed) VALUES 
('111304001', '000713032', '111', 45, 0), 
-- 第二次重修通過 (score 70, passed 1) -> 這裡展示了為何 semester 必須是 PK 之一
('111304001', '000713032', '112', 70, 1), 
('111304001', '000359011', '111', 65, 1), -- Statistics I
('111304001', '041501001', '112', 80, 1), -- History of Art
('111304001', '002062041', '111', 90, 1); -- Badminton (體育1)

-- 3. 學生 Kathy (113304001) - 大一新生
INSERT INTO take_record (student_id, course_id, semester, score, passed) VALUES 
('113304001', '000713032', '113', 92, 1), -- Calculus
('113304001', '000219572', '113', 85, 1), -- Economics
('113304001', '031001001', '113', 78, 1), -- University Chinese
('113304001', '002303041', '113', 88, 1); -- Table Tennis (體育1)

-- 4. 學生 Jack (111304804) - 轉學生 (測試已修課程與抵免的連動)
INSERT INTO take_record (student_id, course_id, semester, score, passed) VALUES 
('111304804', '304004002', '113', 82, 1), -- Linear Algebra
('111304804', '042501001', '113', 77, 1); -- Modern Political Systems


-- 1. 學生 Grace (111304801) - 轉入1下 (上限 20 學分)
-- 抵免了微積分(6)、經濟學(6)、統計學I(3)、大學中文(3) = 共 18 學分 (接近 20)
INSERT INTO credit_waiver (waiver_id, student_id, course_id, original_course_name, credits) VALUES 
('W111-001', '111304801', '000713032', 'Calculus (I) from Previous School', 6),
('W111-002', '111304801', '000219572', 'Introduction to Economics', 6),
('W111-003', '111304801', '000359011', 'Elementary Statistics', 3),
('W111-004', '111304801', '031001001', 'Chinese Composition', 3);

-- 2. 學生 Henry (111304802) - 轉入2年級 (上限 40 學分)
-- 抵免了會計學(3)、微積分(6)、通識課程 = 共 12 學分
INSERT INTO credit_waiver (waiver_id, student_id, course_id, original_course_name, credits) VALUES 
('W111-005', '111304802', '000314141', 'Financial Accounting', 3),
('W111-006', '111304802', '000713032', 'Calculus for Business', 6),
('W111-007', '111304802', '042137001', 'Legal Systems', 3);

-- 3. 學生 Jack (111304804) - 轉入3年級 (上限 80 學分)
-- 抵免了大量課程
INSERT INTO credit_waiver (waiver_id, student_id, course_id, original_course_name, credits) VALUES 
('W111-008', '111304804', '000713032', 'General Calculus', 6),
('W111-009', '111304804', '000219572', 'Principle of Economics', 6),
('W111-010', '111304804', '000359011', 'Statistics', 3),
('W111-011', '111304804', '031001001', 'Freshman Chinese', 3),
('W111-012', '111304804', '041195001', 'History of Art', 3),
('W111-013', '111304804', '043030001', 'Logic and Reasoning', 3);
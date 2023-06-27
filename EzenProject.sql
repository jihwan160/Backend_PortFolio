/*
	프로젝트명 : Ezen Project
	작업명 : 게시판, 로그인, 회원가입 기능 구현
	회원 테이블명 : ezen_member
	게시판 테이블명 : ezen_board
*/

-- 기존 게시판 지우고 시작
drop table ezen_board;
drop table ezen_member;

-- #1. 로그인 ezen_member 테이블

-- ezen_member 테이블 만들기
-- 컬럼명 = id(20), pass1(20), name(20), gender(10), birthdate(20), email(40), tel(20), certification(20), classification(10), campus(30), reception(20)
-- 타입 = 모두 문자타입
-- pk = id

CREATE TABLE ezen_member(  
    id              VARCHAR2(20)             PRIMARY KEY,
    password        VARCHAR2(20)             NOT NULL,
    name            VARCHAR2(20)             NOT NULL,
    gender          VARCHAR2(10)             NOT NULL,            
    birthdate       VARCHAR2(20)             NOT NULL, 
    email           VARCHAR2(40)             NOT NULL,
    tel             VARCHAR2(20)             NOT NULL,
    certification   VARCHAR2(20)             NOT NULL,
    classification  VARCHAR2(10)             NOT NULL,
    campus          VARCHAR2(30)             NOT NULL,
    reception       VARCHAR2(20) 
);
-- 회원가입 테이블 조회
SELECT * from ezen_member;
-- 회원가입 쿼리문
insert into ezen_member VALUES('pjs','1111','jiseok','남자','19990511','pjs99@gmail.com','01091032066','tel','common','노원','sms');
-- 로그인 쿼리문
select * from ezen_member where id = 'pjs' and password = '1111';
-- 비밀번호 구하는 쿼리문
select password from ezen_member where id = 'pjs';
-- 회원정보 가져오는 쿼리문
select * from ezen_member where id = 'pjs' and password='1111';
-- 회원 삭제하는 쿼리문
delete from ezen_member where id = 'pjs';
-- 회원정보 수정하는 쿼리문
update ezen_member set password = '1111', email='pjs99@gmail.com', tel = '01091032066', campus = '노원', reception = 'sms' where id = 'pjs';


-----------------------------------------------------------------------------

-- #2. 게시판 ezen_board 테이블

-- ezen_board 테이블 만들기
-- 컬럼명 = seq(5), campus(30), boardtype(30), title(50), email(40), content(2000), regdate, id(20), cnt(5) 
-- 타입 = 별도 지정 이외에는 문자타입
-- seq, cnt = 숫자 
-- regdate = 날짜
-- pk = seq

create table ezen_board(
    seq             NUMBER(5)               PRIMARY KEY,
    campus          VARCHAR2(30)            NOT NULL,
    boardtype       VARCHAR2(30)            NOT NULL, 
    title           VARCHAR2(50)            NOT NULL,
    email           VARCHAR2(40)            NOT NULL,
    content         VARCHAR2(2000)          NOT NULL,
    regdate         DATE DEFAULT            sysdate, 
    id              VARCHAR2(20)            NOT NULL,
    cnt             NUMBER(5)               DEFAULT 0
);
-- 게시판 테이블 조회
select * from ezen_board;

/* 시퀀스 */
create SEQUENCE ezen_board_seq
MINVALUE 1
MAXVALUE 9999
INCREMENT BY 1;

-- 글 목록 불러오는 쿼리문
select * from ezen_board order by seq desc;
-- 선택한 게시판 목록 불러오는 쿼리문
select * from ezen_board where boardtype='자유게시판' order by seq desc;
-- 글 상세보기 쿼리문
select * from ezen_board where seq = 1;
-- 글 수정 쿼리문
update ezen_board set campus = '노원,상봉', boardtype = '자유게시판', title = '9월 자바 개발자 과정', content = '사실 그런건 없다' where seq = 1
-- 글 작성 쿼리문
INSERT INTO ezen_board VALUES (ezen_board_seq.nextval,'노원,상봉','자유게시판','9월 자바 개발자 과정','pjs99@gmail.com','이제 만들어진다',sysdate ,'pjs', default);
-- 최신글 seq값 가져오는 쿼리문
select * from ezen_board where seq = (select max(seq) from ezen_board);
-- 글 삭제하기 쿼리문
delete from ezen_board where seq = 1;
-- 글 검색하기 쿼리문
select * from ezen_board where title LIKE '%9월%' order by seq desc;
-- 글 검색하기 + 게시판 타입 적용 (1)
select * from ezen_board where title LIKE '%9월%' and boardtype = '자유게시판' order by seq desc;
-- 글 검색하기 + 게시판 타입 적용 (2)
select * from ezen_board where campus = '노원,상봉' order by seq desc;
-- 글 검색하기 + 게시판 타입 적용 (3)
select * from ezen_board where campus = '노원,상봉' and title like '%9월%' order by seq desc
-- 글 검색하기 + 게시판 타입 적용 (4)
select * from ezen_board where title LIKE '%9월%' and boardtype = '자유게시판' and campus='노원,상봉' order by seq desc;

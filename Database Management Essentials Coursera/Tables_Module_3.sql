Tables for Module 3 Assignment (SQL ORACLE)
###########################################

CREATE TABLE Employee (
    EmpNo      VARCHAR2(8)  CONSTRAINT EmpEmpNoNotNull      NOT NULL, 
	  EmpName    VARCHAR2(20) CONSTRAINT EmpEmpNameNotNull    NOT NULL, 
	  Department VARCHAR2(30) CONSTRAINT EmpDepartmentNotNull NOT NULL, 
	  Email      VARCHAR2(30) CONSTRAINT EmpEmailNotNull      NOT NULL, 
	  Phone      VARCHAR2(11) CONSTRAINT EmpPhoneNotNull      NOT NULL, 
	  CONSTRAINT PkEmployee PRIMARY KEY (EmpNo));
    
 CREATE TABLE Customer (
   CustNo   VARCHAR2(8)  CONSTRAINT CustCustNoNoNull   NOT NULL, 
   CustName VARCHAR2(30) CONSTRAINT CustCustNameNotNull NOT NULL, 
   Address  VARCHAR2(50) CONSTRAINT CustAddressNotNull  NOT NULL, 
   Internal CHAR(1)      CONSTRAINT CustInternalNotNull NOT NULL, 
   Contact  VARCHAR2(35) CONSTRAINT CustContractNotNull NOT NULL, 
   Phone    VARCHAR2(11) CONSTRAINT CustCPhoneNotNull   NOT NULL, 
   City     VARCHAR2(30) CONSTRAINT CustCityNotNull     NOT NULL,
   State    VARCHAR2(2)  CONSTRAINT CustStateNotNull    NOT NULL, 
   Zip      VARCHAR2(10) CONSTRAINT CustzipNotNull      NOT NULL,
    CONSTRAINT PkCustomer PRIMARY KEY (CustNo)) ;

CREATE TABLE EventRequest (	
    EventNo     VARCHAR2(8)  CONSTRAINT ReqEventNoNotNull     NOT NULL, 
	  DateHeld    DATE         CONSTRAINT ReqDateHeldNotNull    NOT NULL, 
	  DateReq     DATE         CONSTRAINT ReqDateReqNotNull     NOT NULL, 
	  FacNo       VARCHAR2(8)  CONSTRAINT ReqFacNoNotNull       NOT NULL, 
	  CustNo      VARCHAR2(8)  CONSTRAINT ReqCustNoNotNull      NOT NULL, 
	  DateAuth    DATE                                                  , 
	  Status      VARCHAR2(10) CONSTRAINT ReqStatusNotNull      NOT NULL, 
	  EstCost     NUMBER(7,2)  CONSTRAINT ReqEstCostNotNull     NOT NULL, 
	  EstAudience NUMBER(*,0)  CONSTRAINT ReqEstAudienceNotNull NOT NULL, 
	  BudNo       VARCHAR2(8)                                           , 
	   CONSTRAINT StatusCheck           CHECK (Status IN ('Pending', 'Denied', 'Approved')), 
	   CONSTRAINT AudienceCheck         CHECK (Estaudience > 0), 
	   CONSTRAINT PkEventRequest        PRIMARY KEY (EventNo),
	   CONSTRAINT FkEventRequestCustno  FOREIGN KEY (FacNo)   REFERENCES Facility (FacNo),
	   CONSTRAINT FkEventRequestCustNo  FOREIGN KEY (CustNo)  REFERENCES Customer (CustNo));

CREATE TABLE Facility (
  FacNo   VARCHAR2(8)  CONSTRAINT FacFacNoNotNull   NOT NULL, 
  FacName VARCHAR2(30) CONSTRAINT FacFacNameNotNull NOT NULL,
   CONSTRAINT PkFacility PRIMARY KEY (FacNo));

CREATE TABLE RESOURCETBL (	
  ResNo   VARCHAR2(8)  CONSTRAINT ResResNoNotNull   NOT NULL, 
	ResName VARCHAR2(30) CONSTRAINT ResResNameNotNull NOT NULL, 
	Rate    NUMBER(4,2)  CONSTRAINT ResRate           NOT NULL, 
	 CONSTRAINT RateCheck CHECK (Rate > 0), 
	 CONSTRAINT PkResourcetbl PRIMARY KEY (ResNo));

CREATE TABLE Location (
  LocNo   VARCHAR2(8)  CONSTRAINT LocLocNoNotNull   NOT NULL, 
  FacNo   VARCHAR2(8)  CONSTRAINT LocFacNoNotNull   NOT NULL, 
  LocName VARCHAR2(30) CONSTRAINT LocLocNameNotNull NOT NULL,
   CONSTRAINT PkLocation PRIMARY KEY (LocNo),
   CONSTRAINT FkFacno    FOREIGN KEY (FacNo) REFERENCES Facility (FacNo));

 CREATE TABLE EventPlan (	
  |PlanNo   VARCHAR2(8)  CONSTRAINT PlanPlanNoNotNull   NOT NULL, 
	 EventNo  VARCHAR2(8)  CONSTRAINT PlanEventNoNotNull  NOT NULL, 
	 WorkDate DATE         CONSTRAINT PlanWorkDateNotNull NOT NULL, 
	 Notes    VARCHAR2(30)                                        ,
	 Activity VARCHAR2(10) CONSTRAINT PlanActivityNOTNULL NOT NULL, 
	 EmpNo    VARCHAR2(8)                                         , 
	  CONSTRAINT PKEventPlan        PRIMARY KEY                                   (PlanNo),
	  CONSTRAINT FkEventPlanEventNo FOREIGN KEY (EventNo) REFERENCES EventRequest (EventNo),
	  CONSTRAINT FKEventPlanEmpNo   FOREIGN KEY (EmpNo)   REFERENCES Employee     (EmpNo));

 CREATE TABLE EventPlanLine (	
  	PlanNo    VARCHAR2(8)  CONSTRAINT LinePlanNoNotNull    NOT NULL, 
	  LineNo    VARCHAR2(1)  CONSTRAINT LineLineNoNotNull    NOT NULL, 
	  TimeStart DATE         CONSTRAINT LineTimeStartNotNull NOT NULL, 
	  TimeEnd   DATE         CONSTRAINT LineTimeEndNotNull   NOT NULL,
    NumberFld VARCHAR2(10) CONSTRAINT LineNumberFldNotNull NOT NULL, 
	  LocNo     VARCHAR2(8)                                           ,
	  ResNo     VARCHAR2(8)                                           ,
	   CONSTRAINT PKEventPlanLine   PRIMARY KEY                                 (PlanNo, LineNo),
	   CONSTRAINT TimeEventPlanLine CHECK                                       (TimeStart < TimeEnd),
	   CONSTRAINT FkLinePlanNo      FOREIGN KEY (PlanNo) REFERENCES EventPlan   (PlanNo),
	   CONSTRAINT FkLineLocNo       FOREIGN KEY (LocNo)  REFERENCES Location    (LocNo),
	   CONSTRAINT FkLineResNo       FOREIGN KEY (ResNo)  REFERENCES Resourcetbl (ResNo));

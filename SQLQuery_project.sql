--Creating role table
create table role
(role_ID int primary key not null,
role_name varchar(10) not null,
role_description varchar(20)
constraint rn_ck unique(role_name))

--Creating table login
create table login
(login_ID int primary key not null,
username varchar(10) not null,
password varchar(10) not null,
role_id int foreign key references role(role_id),
constraint un_ck unique(username),
constraint pw_ck unique(password))

--Creating table user_t
create table user_t
(user_id int primary key not null,
login_id int foreign key references login(login_ID) not null,
user_firstname varchar(20) not null,
user_lastname varchar(20) not null,
user_email varchar(20) not null,
contact_no int not null,
age int
constraint lg_ck unique(login_ID))

alter table user_t drop constraint lg_ck
--Creating table doctor
create table doctor 
(user_id int foreign key references user_t(user_id) primary key,
user_firstname varchar(20) not null,
user_lastname varchar(20) not null,
specialization varchar(30))


--Creating table prescription
create table prescription
(prescription_ID int primary key not null,
doctor_ID int foreign key references user_t(login_id),
patient_ID int foreign key references user_t(login_id),
prescription_Date date not null default '04/03/2018')


--Creating table medicine
create table medicine
(medicine_ID int primary key not null,
medicine_name varchar(10) not null)



--Creating table prescribed medicine
create table prescribed_medicine
(pm_id int primary key not null,
prescription_ID int foreign key references prescription(prescription_ID),
medicine_ID int foreign key references medicine(medicine_ID),
instruction varchar(20))


--Creating table no medicine
create table no_medicine
(NM_ID int primary key not null,
patient_ID int foreign key references user_t(login_id),
medicine_ID int foreign key references medicine(medicine_ID))


--Creating table allergy
create table allergy
(allergy_ID int primary key not null,
allergy_name varchar(20) not null)


--Creating table patient_allergy
create table patient_allergy
(reaction_ID int primary key not null,
patient_ID int foreign key references user_t(login_id),
allergy_ID int foreign key references allergy(allergy_ID),
severity varchar(20) not null default 'low')


--inserting into role
insert into role(role_ID, role_name, role_description)
values(101, 'doctor', 'prescribes'),
(102, 'patient', 'gets prescribed')
select * from role

--inserting into login
	insert into login(login_ID, username, password, role_ID)
	values(201, 'adchawla', 'aaa', 101),
	(202, 'nasaluja', 'bbb', 101),
	(203,'anhanda', 'ccc', 102),
	(204,'adchauhan', 'ddd', 102),
	(205, 'prmatnani', 'eee', 102),
	(206, 'arsuri', 'fff', 102),
	(207, 'manav', 'mehta', 102)
select * from login
--inserting into user_t
insert into user_t(user_ID,login_ID, user_firstname, user_lastname, user_email,contact_no, age)
values(1, 201, 'aditi','chawla', 'adchawla@doc.com', 7402, 24),
(2,202, 'niti', 'saluja', 'nasaluja@doc.com', 4752, 28),
(3, 203, 'anmol', 'handa', 'anhanda@pat.com', 4949, 31),
(4, 204, 'aditya', 'chauhan', 'achauhan@pat.com', 4953, 5),
(5, 205, 'priya', 'matnani', 'prmatnani@pat.com', 2222, 29),
(6, 206, 'arjun', 'suri', 'arsuri@pat.com', 3333, 12)

select * from doctor

--inserting into doctor
insert into doctor(user_id, user_firstname, user_lastname, specialization)
values(1, 'aditi','chawla', 'psychiatrist'),
(2, 'niti', 'saluja', 'immunologist')


--inserting into prescription
insert into prescription(prescription_ID, patient_ID, prescription_Date, doctor_ID)
values(301, 203, '04/05/2018',2),
(302,206, '05/06/2018',1)
select * from prescription

--inserting into medicine
insert into medicine(medicine_ID, medicine_name)
values
(403, 'Tylenol'),
(404, 'Benadryl'),
(405, 'Advil'),
(406, 'Codeine')
select * from medicine

--inserting into prescribed medicine
insert into prescribed_medicine(pm_id, prescription_ID, medicine_ID, instruction)
values(501, 301, 402, 'after dinner'),
(502, 302, 401, 'before breakfast')
select * from prescribed_medicine

--inserting into no_medicine
insert into no_medicine(NM_ID, patient_ID, medicine_ID)
values(601, 204, 402),
(602, 206, 401)
select * from no_medicine

--isnerting into allergies
insert into allergy(allergy_ID, allergy_name)
values(701, 'tuna'),
(702, 'eggs'),
(703, 'peanuts')
select * from allergy
--inserting into patient_allergy
insert into patient_allergy(reaction_ID, patient_ID,allergy_ID, severity)
values
(816, 209, 705, 'high'),
(801, 203, 701, 'medium'),
(802, 204, 702, 'high'),
(803, 207, 703, 'low'),
(804, 206, 705, 'low')
select * from patient_allergy
	
--creating procedure
create procedure add_num_of_patients
as
begin
update allergy
set num_of_patients=nop.numpat
from
(select pa.allergy_ID, count(pa.allergy_ID) 'numpat'
from patient_allergy pa
inner join allergy a
on pa.allergy_ID= a.allergy_ID
group by pa.allergy_id) as nop
where nop.allergy_ID=allergy.allergy_ID
end;

exec add_num_of_patients


--creating trigger
create trigger updatenumofpatients
on patient_allergy
for insert, update
as
if @@rowcount>= 1
begin
update allergy
set num_of_patients=nop.numpat
from
(select pa.allergy_ID, count(pa.allergy_ID) 'numpat'
from patient_allergy pa
inner join inserted e
on pa.allergy_ID= e.allergy_ID
group by pa.allergy_ID) as nop
where nop.allergy_ID=allergy.allergy_ID
end;



drop table user_t
select * from allergy



insert into doctor(user_id, user_firstname, user_lastname, specialization)
values(1, 'aditi','chawla', 'psychiatrist'),
(2, 'niti', 'saluja', 'immunologist')



select * from user_t

create table prescription
(prescription_ID int primary key not null,
doctor_ID int foreign key references user_t(login_id),
patient_ID int foreign key references user_t(login_id),
prescription_Date date not null default '04/03/2018')




alter table prescription add doctor_ID int foreign key references doctor(user_ID)
update prescription set doctor_ID=2 where prescription_ID=304 
select * from prescription
select * from User_t
delete prescription where prescription_ID=306



insert into prescribed_medicine(pm_id, prescription_ID, medicine_ID, instruction)
values(501, 301, 402, 'after dinner'),
(502, 302, 401, 'before breakfast')
select * from prescribed_medicine




select * from no_medicine


select * from allergy
update allergy set allergy_name='tuna' where allergy_name='egg'
alter table allergy drop column noofpatients

alter table allergy add num_of_patients int
drop procedure add_num_of_patients 


drop trigger updatenumofpatients






	select user_t.user_firstname, medicine.medicine_name
	from no_medicine inner join user_t
	on no_medicine.patient_ID=user_t.login_ID
	inner join medicine on no_medicine.medicine_ID=medicine.medicine_ID
	where medicine.medicine_name='advil'
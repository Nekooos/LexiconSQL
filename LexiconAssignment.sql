drop database if exists LexiconAssignment;
create database LexiconAssignment;
use LexiconAssignment;



create table if not exists player(
	social_security_number char(13) not null,
	player_name varchar(20),
	age int,
	primary key(social_security_number)
)engine=innodb;

create table if not exists jacket(
	id int auto_increment,
    initials varchar(2),
    size varchar(2),
    material varchar(20),
    social_security_number varchar(13) not null,
    primary key(id, social_security_number),
    foreign key(social_security_number) references player(social_security_number)
)engine=innodb;



/* Competition rain */
create table if not exists competition(
	primary key (competition_name),
    competition_name varchar(30) not null,
    competition_date date
)engine=innodb;

create table if not exists rain(
	rain_type varchar(20),
    wind varchar(20),
    primary key(rain_type)
)engine=innodb;




/* Construction, Golf Club */
create table if not exists construction (
	hardness int,
    serial_number int not null,
    primary key(serial_number)
)engine=innodb;

create table if not exists golfclub (
	material varchar(20),
    serial_number int not null,
    social_security_number varchar(20) not null,
    foreign key(serial_number) references construction(serial_number),
	primary key(serial_number, social_security_number),
    foreign key(social_security_number) references player(social_security_number)
)engine=innodb;




create table if not exists participation (
	social_security_number varchar(13) not null,
    competition_name char(20) not null,
	primary key(social_security_number, competition_name),
    foreign key(social_security_number) references player(social_security_number),
    foreign key(competition_name) references competition(competition_name)
)engine=innodb;

create table if not exists have (
    rain_time datetime,
	rain_type varchar(20) not null,
    competition_name varchar(20) not null,
	primary key(rain_type, competition_name),
    foreign key(rain_type) references rain(rain_type),
    foreign key(competition_name) references competition(competition_name)
)engine=innodb;




insert into player(social_security_number, player_name, age)
values('19960101-7777', 'Johan Andersson', 25),
		('19860101-7778', 'Nicklas Jansson', 35),
        ('19760101-7779', 'Annika Persson', 45);

insert into competition(competition_name, competition_date)
values('Big Golf Cup Skövde', '2021-01-01');

insert into rain(rain_type, wind)
values('hagel', '10m/s');

insert into participation(social_security_number, competition_name)
values('19960101-7777', 'Big Golf Cup Skövde'),
		('19860101-7778', 'Big Golf Cup Skövde'),
		('19760101-7779', 'Big Golf Cup Skövde');

insert into have(rain_time, rain_type, competition_name)
values('2021-06-10 12:00:00', 'hagel', 'Big Golf Cup Skövde');

insert into construction(hardness, serial_number)
values(5, 1),
		(10, 2);
        
insert into golfclub(material, social_security_number, serial_number)
values('trä', '19860101-7778', 2),
		('järn', '19960101-7777', 2),
		('trä', '19760101-7779', 1);

insert into jacket(initials, size, material, social_security_number)
values('JA', 'M', 'Fleece', '19960101-7777'),
		('JA', 'M', 'Goretex', '19960101-7777');



/* 1 */
select age from player where player_name = 'Johan Andersson';

/* 2 */
select competition_date from competition where competition_name = 'Big Golf Cup Skövde';

/* 3 */
select material from golfclub where social_security_number='19960101-7777';

/* 4 */
select * from jacket where social_security_number = '19960101-7777';

/* 5 */
select player.player_name, player.age, player.social_security_number from player
inner join competition
on competition.competition_name = 'Big Golf Cup Skövde';

/* 6 */
select wind from rain
inner join competition
on competition.competition_name = 'Big Golf Cup Skövde';

/* 7 */
select * from player where age < 30;

/* 8 */
delete from jacket where social_security_number='19960101-7777';

/* 9 */
delete from golfclub where social_security_number = '19860101-7778';
delete from participation where social_security_number='19860101-7778';
delete from player where player_name='Nicklas Jansson';

/* 10 */
insert into player(social_security_number, player_name, age)
values('19960101-7774', 'Johan Andersson', 66),
		('19860101-7773', 'Nicklas Jansson', 44),
        ('19760101-7772', 'Annika Persson', 55),
        ('19760101-7771', 'Annika Persson', 32);
select AVG(age) as average_age from player;


	
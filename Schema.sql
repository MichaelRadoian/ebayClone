
DROP SCHEMA IF EXISTS BuyMe_DB;
create database BuyMe_DB;
use BuyMe_DB;
create table users (
    username varchar(50), 
    password varchar(50),
    role varchar(10) DEFAULT "CUSTOMER",
    PRIMARY KEY (username, password));
    
create table customers (
	username varchar(50),
    password varchar(50),
	amountSpent double DEFAULT 0,
    PRIMARY KEY (username, password),
	FOREIGN KEY (username, password) references users (username, password) 
    ON DELETE CASCADE ON UPDATE CASCADE);
    
create table customerRep (
	username varchar(50),
    password varchar(50),
    PRIMARY KEY (username, password),
	FOREIGN KEY (username, password) references users (username, password) 
    ON DELETE CASCADE ON UPDATE CASCADE);
    
create table admin (
	username varchar(50),
    password varchar(50),
    PRIMARY KEY (username, password),
	FOREIGN KEY (username, password) references users (username, password) 
    ON DELETE CASCADE ON UPDATE CASCADE);
    
create table customerRepAccountCreation (
	repUsername varchar(50),
    adminUsername varchar(50),
    primary key (repUsername, adminUsername),
    foreign key (repUsername) references customerRep(username) on delete cascade,
    foreign key (adminUsername) references admin(username) on delete cascade);
    
create table customerService (
	serviceTicketNumber int auto_increment,
    customerUsername varchar(50) NOT NULL,
    repUsername varchar(50),
    -- repUsername is empty by default, we fill it in when someone responds to the customerQuery
    querySolved boolean DEFAULT FALSE,
    customerQuery varchar(200),
    repResponse varchar(200) DEFAULT '',
    primary key(serviceTicketNumber),
    foreign key (customerUsername) references users (username) on delete CASCADE,
    foreign key (repUsername) references customerRep(username) on delete CASCADE);
    
create table clothing (
    itemNumber int auto_increment,
    category ENUM('top','bottom', 'footwear'),
    description varchar(100) NOT NULL,
    material varchar(20),
    brand varchar(30),
    color varchar(30),
    totalEarnings double,
    numberSold int,
    primary key(itemNumber));
    
create table auction (
    auctionId int auto_increment,
    initialPrice double,
    closingDate DATE,
    closingTime TIME,
    minimumPrice double,
    winner varchar(50) DEFAULT '',
    primary key (auctionId));

    
create table alert (
	type ENUM('winner','higher bid','none'),
    auctionId int not null,
    customerUsername varchar(50) not null,
    primary key(customerUsername, auctionId),
    foreign key (customerUsername) references users(username)
        on delete cascade
        on update cascade,
    foreign key (auctionId) references auction(auctionId)
        on delete cascade
        on update cascade);
    
create table history (
	auctionId int not null,
    username varchar(50) not null,
    primary key(username),
    foreign key(auctionId) references auction(auctionId) 
		on delete cascade
        on update cascade);
    
create table similarItemsSold (
	auctionId int not null,
    itemNumber int not null,
    primary key(itemNumber),
    foreign key(auctionId) references auction(auctionId),
    foreign key (itemNumber) references clothing(itemNumber) 
		on delete cascade
		on update cascade);
    
create table footwear (
    size double not null,
    width double not null,
    itemNumber int not null,
    primary key(itemNumber,size,width),
    foreign key(itemNumber) references clothing(itemNumber)
        on delete cascade
        on update cascade);
    
create table bottom (
    inseamLength double,
    waistSize double not null,
    itemNumber int not null,
    primary key(inseamLength, waistSize, itemNumber),
    foreign key(itemNumber) references clothing(itemNumber)
        on delete cascade
        on update cascade);
    
create table top (
    itemNumber int not null,
    neckWidth double,
    sleeveLength double,
    shoulderWidth double,
    primary key(itemNumber),
    foreign key(itemNumber) references clothing(itemNumber)
        on delete cascade
        on update cascade);
    
create table auctionItem (
    auctionId int not null,
    itemNumber int not null,
    primary key ( auctionId, itemNumber),
    foreign key( auctionId) references auction(auctionId)
        on delete cascade
        on update cascade,
    foreign key(itemNumber) references clothing(itemnumber)
        on delete cascade
        on update cascade);
    
create table sells (
    username varchar(50) not null,
    auctionId int not null,
    
    primary key (username),
    foreign key(auctionId) references auction(auctionId)
        on delete cascade
        on update cascade,
    foreign key(username) references users(username)
        on delete cascade
        on update cascade);
    
create table bids(
    username varchar(50) not null,
    bidNumber int ,
    increment double,
    auctionId int not null,
    bidAmount double not null,
    bidLimit double,
    typeOfBid enum ('manual', 'automatic'),
    primary key(username, bidNumber),
    foreign key(auctionId) references auction(auctionId)
        on delete cascade
        on update cascade,
    foreign key(username) references users(username)
        on delete cascade
        on update cascade);
        
insert into users (username, password, role) values
	('ADMIN', 'ADMINPASS', 'ADMIN'),
    ("CSREP1", "CSPASS", "CS_REP")
    ;

insert into admin (username, password) values
	('ADMIN', 'ADMINPASS')
	;
insert into customerRep (username, password) values
	("CSREP1", "CSPASS")
    ;
    
insert into customerRepAccountCreation (repUsername, adminUsername) values
	("CSREP1", "ADMIN")
    ;

select * from users;
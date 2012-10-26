-- basic mysql database for booktracker application

create database if not exists booktracker;

use booktracker;

create table if not exists authors (
    authorID int not null auto_increment primary key,
    authorFirstName char(30) not null,
    authorLastName char(30) not null
); 

create table if not exists series (
    seriesID int not null auto_increment primary key,
    seriesName char(60) not null,
    seriesAuthor int not null,
    foreign key (seriesAuthor) references authors(authorID) on delete restrict on update cascade
);

create table if not exists books (
    bookID int not null auto_increment primary key,
    bookName char(60) not null,
    bookSeries int not null,
    bookSequence int not null default 0,
    havePaperBook enum('Yes','No') not null default 'No',
    haveEBook enum('Yes','No') not null default 'No',
    foreign key (bookSeries) references series(seriesID) on delete restrict on update cascade
);
/* ******************************************************************************************* */
DROP TABLE IF EXISTS x_directives;
DROP TABLE IF EXISTS x_sessions;
DROP TABLE IF EXISTS x_user_privileges;
DROP TABLE IF EXISTS x_privileges;
DROP TABLE IF EXISTS x_users;


/* ******************************************************************************************* */
CREATE TABLE x_directives
(
	subject_id int unsigned not null default 0,
	type varchar(128) not null, /* verification_code */

	modified datetime,

	s_value varchar(256) default '',
	i_value int default 0,
	t_value text default null
)
ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=1;

ALTER TABLE x_directives ADD PRIMARY KEY pk (subject_id, type);
ALTER TABLE x_directives ADD INDEX n_type (type);
ALTER TABLE x_directives ADD INDEX n_s_value (s_value);


/* ******************************************************************************************* */
CREATE TABLE x_users
(
    user_id int unsigned primary key auto_increment,
    created datetime default null,

    is_authorized tinyint not null default 1,
    is_active tinyint not null default 1,

    username varchar(256) not null,
    password char(96) not null collate utf8mb4_bin,

	photo varchar(128) default null,

	name varchar(128) default '',
	email varchar(128) default ''
)
ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=1;


CREATE TABLE x_privileges
(
    privilege_id int unsigned primary key auto_increment,
    name varchar(128) not null unique key
)
ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_bin AUTO_INCREMENT=1;


CREATE TABLE x_user_privileges
(
    user_id int unsigned not null,
    privilege_id int unsigned not null,
	tag tinyint default 0,

    primary key (user_id, privilege_id),

    constraint foreign key (user_id) references x_users (user_id) on delete cascade,
    constraint foreign key (privilege_id) references x_privileges (privilege_id) on delete cascade
)
ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


/* ******************************************************************************************* */
CREATE TABLE x_sessions
(
	session_id varchar(48) primary key unique not null,

	created datetime default null,
	last_activity datetime default null,

	device_id varchar(48) default null,

	user_id int unsigned default null,
	constraint foreign key (user_id) references users (user_id) on delete cascade,

	data varchar(8192) default null
)
ENGINE=InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


/* ******************************************************************************************* */
INSERT INTO x_privileges (privilege_id, name) VALUES (777, 'admin');
INSERT INTO x_users (user_id, created, username, password, name) VALUES (1, NOW(), 'admin', SHA2('p3rF1!admin2020s51X%', 384), 'Administrator');
INSERT INTO x_user_privileges(user_id, privilege_id) VALUES (1, 777);

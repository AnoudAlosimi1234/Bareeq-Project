CREATE DATABASE bareeq_app
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE bareeq_app;


CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    parent_id INT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    birth_date DATE NULL,
    points INT DEFAULT 0,
    role VARCHAR(50) NOT NULL,
    
    FOREIGN KEY (parent_id) REFERENCES users(user_id)
);

CREATE TABLE activity (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(255) NULL,
    type VARCHAR(100) NOT NULL,
    points_reward INT DEFAULT 0,
    is_completed BOOLEAN NOT NULL
);

CREATE TABLE user_activity (
    activity_user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    activity_id INT,
    status VARCHAR(50) NOT NULL,
    points_earned INT DEFAULT 0,
    started_at DATE NOT NULL,
    completed_at DATE NULL,
    
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (activity_id) REFERENCES activity(activity_id)
);

CREATE TABLE notification (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    activity_user_id INT,
    type VARCHAR(255) NULL,
    title VARCHAR(255) NULL,
    message TEXT NULL,
    date DATETIME NULL,
    is_read TINYINT DEFAULT 0,
    created_at DATETIME NOT NULL,
    
    FOREIGN KEY (activity_user_id) REFERENCES user_activity(activity_user_id)
);

CREATE TABLE characters (
    character_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    user_id INT,
    is_unlocked BOOLEAN DEFAULT 0,
    required_points INT NOT NULL,
    image_url VARCHAR(255),
    
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE child_character (
    child_character_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    character_id INT,
    is_locked BOOLEAN DEFAULT 0,
    lock_date DATE,
    points_used INT DEFAULT 0,
    
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (character_id) REFERENCES characters(character_id)
);

CREATE TABLE custom_word (
    word_id INT AUTO_INCREMENT PRIMARY KEY,
    parent_id INT,
    child_id INT,
    word_text VARCHAR(100) NOT NULL,
    date_added DATE,
    
    FOREIGN KEY (parent_id) REFERENCES users(user_id),
    FOREIGN KEY (child_id) REFERENCES users(user_id)
);

CREATE TABLE progress_report (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    parent_id INT,
    report_date DATE,
    note TEXT,
    total_activity INT,
    completed_activity INT,
    total_point INT,
    
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (parent_id) REFERENCES users(user_id)
);
CREATE TABLE Screen (
    screen_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    class_type VARCHAR(10) NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE Seat (
    seat_id INT PRIMARY KEY,
    seat_number VARCHAR(10) NOT NULL,
    screen_id INT NOT NULL,
    FOREIGN KEY (screen_id) REFERENCES Screen(screen_id)
);

CREATE TABLE Movie (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    rating DECIMAL(3,1) NOT NULL,
    status VARCHAR(20) NOT NULL,
    poster_image_url VARCHAR(255)
);

CREATE TABLE MovieCast (
    cast_id INT PRIMARY KEY,
    movie_id INT NOT NULL,
    person_name VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
);

CREATE TABLE Review (
    review_id INT PRIMARY KEY,
    movie_id INT NOT NULL,
    content TEXT NOT NULL,
    review_date DATETIME NOT NULL,
    reviewer_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
);

CREATE TABLE Show (
    show_id INT PRIMARY KEY,
    screen_id INT NOT NULL,
    movie_id INT NOT NULL,
    show_datetime DATETIME NOT NULL,
    FOREIGN KEY (screen_id) REFERENCES Screen(screen_id),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
);

CREATE TABLE ShowSeat (
    show_seat_id INT PRIMARY KEY,
    show_id INT NOT NULL,
    seat_id INT NOT NULL,
    is_available BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (show_id) REFERENCES Show(show_id),
    FOREIGN KEY (seat_id) REFERENCES Seat(seat_id)
);

CREATE TABLE [User] (
    user_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(15)
);

CREATE TABLE Membership (
    membership_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    current_points INT NOT NULL DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES [User](user_id)
);

CREATE TABLE Booking (
    booking_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    show_id INT NOT NULL,
    booking_datetime DATETIME NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES [User](user_id),
    FOREIGN KEY (show_id) REFERENCES Show(show_id)
);

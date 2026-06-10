-- Создание основной таблицы для анализа хакатонов и IT-мероприятий

DROP TABLE IF EXISTS real_events;

CREATE TABLE real_events (
    event_id SERIAL PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    event_type VARCHAR(100),
    event_format VARCHAR(50),
    start_date DATE,
    end_date DATE,
    registrations_count INT,
    participants_count INT,
    teams_count INT,
    submitted_projects_count INT,
    finished_participants_count INT
);

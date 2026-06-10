-- Создание основной таблицы для анализа хакатонов и IT-мероприятий

DROP TABLE IF EXISTS it_events;

CREATE TABLE it_events (
    event_id SERIAL PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    event_type VARCHAR(100) NOT NULL,
    event_format VARCHAR(50) NOT NULL,
    city VARCHAR(100),
    start_date DATE NOT NULL,
    registrations_count INT NOT NULL CHECK (registrations_count >= 0),
    participants_count INT NOT NULL CHECK (participants_count >= 0),
    submitted_projects_count INT NOT NULL CHECK (submitted_projects_count >= 0),
    finished_participants_count INT NOT NULL CHECK (finished_participants_count >= 0),
    teams_count INT CHECK (teams_count >= 0)
);

COMMENT ON TABLE it_events IS 'Агрегированные данные по хакатонам и IT-мероприятиям';
COMMENT ON COLUMN it_events.registrations_count IS 'Количество зарегистрированных участников';
COMMENT ON COLUMN it_events.participants_count IS 'Количество фактических участников';
COMMENT ON COLUMN it_events.submitted_projects_count IS 'Количество сданных проектов';
COMMENT ON COLUMN it_events.finished_participants_count IS 'Количество участников, дошедших до завершения мероприятия';


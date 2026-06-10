-- Создание таблицы для анализа реальных обезличенных данных по IT-мероприятиям.
-- В CSV-файле не должно быть колонки event_id: она создаётся автоматически.

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

COMMENT ON TABLE real_events IS 'Обезличенные агрегированные данные по хакатонам и IT-мероприятиям';
COMMENT ON COLUMN real_events.event_name IS 'Название мероприятия';
COMMENT ON COLUMN real_events.event_type IS 'Тип мероприятия: хакатон, IT-соревнование, курс';
COMMENT ON COLUMN real_events.event_format IS 'Формат проведения: онлайн, офлайн, гибрид';
COMMENT ON COLUMN real_events.registrations_count IS 'Количество регистраций';
COMMENT ON COLUMN real_events.participants_count IS 'Количество фактических участников';
COMMENT ON COLUMN real_events.teams_count IS 'Количество команд';
COMMENT ON COLUMN real_events.submitted_projects_count IS 'Количество сданных проектов';
COMMENT ON COLUMN real_events.finished_participants_count IS 'Количество участников, дошедших до завершения';


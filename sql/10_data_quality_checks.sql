-- Проверки качества данных перед аналитикой.

-- 1. Количество строк в таблице.
SELECT COUNT(*) AS events_count
FROM real_events;

-- 2. Первые строки таблицы для визуальной проверки.
SELECT *
FROM real_events
ORDER BY start_date
LIMIT 10;

-- 3. Проверка типов мероприятий.
SELECT
    event_type,
    COUNT(*) AS events_count
FROM real_events
GROUP BY event_type
ORDER BY events_count DESC;

-- 4. Проверка форматов мероприятий.
SELECT
    event_format,
    COUNT(*) AS events_count
FROM real_events
GROUP BY event_format
ORDER BY events_count DESC;

-- 5. Проверка пустых обязательных полей.
SELECT *
FROM real_events
WHERE event_name IS NULL
   OR event_name = ''
   OR event_type IS NULL
   OR event_format IS NULL
   OR start_date IS NULL;

-- 6. Проверка случаев, когда участников больше, чем регистраций.
SELECT *
FROM real_events
WHERE participants_count > registrations_count;

-- 7. Проверка случаев, когда завершивших участников больше, чем участников.
SELECT *
FROM real_events
WHERE finished_participants_count > participants_count;

-- 8. Проверка отрицательных значений.
SELECT *
FROM real_events
WHERE registrations_count < 0
   OR participants_count < 0
   OR teams_count < 0
   OR submitted_projects_count < 0
   OR finished_participants_count < 0;

-- 9. Проверка дат.
SELECT *
FROM real_events
WHERE end_date < start_date;


-- Топ мероприятий по доле участников, дошедших до завершения

SELECT
    event_name,
    event_type,
    event_format,
    city,
    start_date,
    participants_count,
    finished_participants_count,
    ROUND(
        finished_participants_count::numeric
        / NULLIF(participants_count, 0) * 100,
        2
    ) AS finish_rate
FROM it_events
WHERE participants_count > 0
ORDER BY finish_rate DESC
LIMIT 10;


-- Топ мероприятий по конверсии из регистрации в фактическое участие

SELECT
    event_name,
    event_type,
    event_format,
    city,
    start_date,
    registrations_count,
    participants_count,
    ROUND(
        participants_count::numeric
        / NULLIF(registrations_count, 0) * 100,
        2
    ) AS participation_conversion
FROM it_events
WHERE registrations_count > 0
ORDER BY participation_conversion DESC
LIMIT 10;


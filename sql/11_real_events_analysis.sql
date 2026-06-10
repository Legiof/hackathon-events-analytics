-- Аналитические запросы по реальным обезличенным данным.

-- 1. Общая воронка участия.
SELECT
    SUM(registrations_count) AS total_registrations,
    SUM(participants_count) AS total_participants,
    SUM(submitted_projects_count) AS total_submitted_projects,
    SUM(finished_participants_count) AS total_finished_participants,
    ROUND(SUM(participants_count)::numeric / NULLIF(SUM(registrations_count), 0) * 100, 2) AS registration_to_participation_conversion,
    ROUND(SUM(submitted_projects_count)::numeric / NULLIF(SUM(participants_count), 0) * 100, 2) AS participation_to_submission_conversion,
    ROUND(SUM(finished_participants_count)::numeric / NULLIF(SUM(participants_count), 0) * 100, 2) AS participation_to_finish_conversion
FROM real_events;

-- 2. Динамика мероприятий по месяцам.
SELECT
    DATE_TRUNC('month', start_date)::date AS event_month,
    COUNT(*) AS events_count,
    SUM(registrations_count) AS total_registrations,
    SUM(participants_count) AS total_participants,
    SUM(teams_count) AS total_teams,
    SUM(submitted_projects_count) AS total_submitted_projects,
    SUM(finished_participants_count) AS total_finished_participants
FROM real_events
GROUP BY DATE_TRUNC('month', start_date)
ORDER BY event_month;

-- 3. Метрики по типам мероприятий.
SELECT
    event_type,
    COUNT(*) AS events_count,
    SUM(registrations_count) AS total_registrations,
    SUM(participants_count) AS total_participants,
    SUM(teams_count) AS total_teams,
    SUM(submitted_projects_count) AS total_submitted_projects,
    SUM(finished_participants_count) AS total_finished_participants,
    ROUND(SUM(participants_count)::numeric / NULLIF(SUM(registrations_count), 0) * 100, 2) AS registration_to_participation_conversion,
    ROUND(SUM(finished_participants_count)::numeric / NULLIF(SUM(participants_count), 0) * 100, 2) AS participation_to_finish_conversion
FROM real_events
GROUP BY event_type
ORDER BY total_participants DESC;

-- 4. Метрики по форматам мероприятий.
SELECT
    event_format,
    COUNT(*) AS events_count,
    SUM(registrations_count) AS total_registrations,
    SUM(participants_count) AS total_participants,
    SUM(teams_count) AS total_teams,
    SUM(submitted_projects_count) AS total_submitted_projects,
    SUM(finished_participants_count) AS total_finished_participants,
    ROUND(SUM(participants_count)::numeric / NULLIF(SUM(registrations_count), 0) * 100, 2) AS registration_to_participation_conversion,
    ROUND(SUM(finished_participants_count)::numeric / NULLIF(SUM(participants_count), 0) * 100, 2) AS participation_to_finish_conversion
FROM real_events
GROUP BY event_format
ORDER BY total_participants DESC;

-- 5. Сегментация мероприятий по размеру.
SELECT
    CASE
        WHEN participants_count < 100 THEN 'До 100 участников'
        WHEN participants_count BETWEEN 100 AND 999 THEN '100-999 участников'
        ELSE '1000+ участников'
    END AS event_size_segment,
    COUNT(*) AS events_count,
    SUM(registrations_count) AS total_registrations,
    SUM(participants_count) AS total_participants,
    SUM(teams_count) AS total_teams,
    SUM(submitted_projects_count) AS total_submitted_projects,
    SUM(finished_participants_count) AS total_finished_participants,
    ROUND(SUM(participants_count)::numeric / NULLIF(SUM(registrations_count), 0) * 100, 2) AS registration_to_participation_conversion,
    ROUND(SUM(finished_participants_count)::numeric / NULLIF(SUM(participants_count), 0) * 100, 2) AS participation_to_finish_conversion
FROM real_events
GROUP BY event_size_segment
ORDER BY
    CASE
        WHEN event_size_segment = 'До 100 участников' THEN 1
        WHEN event_size_segment = '100-999 участников' THEN 2
        ELSE 3
    END;

-- 6. Топ мероприятий по конверсии из регистрации в участие.
SELECT
    event_name,
    event_type,
    event_format,
    start_date,
    registrations_count,
    participants_count,
    ROUND(participants_count::numeric / NULLIF(registrations_count, 0) * 100, 2) AS participation_conversion
FROM real_events
WHERE registrations_count > 0
ORDER BY participation_conversion DESC
LIMIT 10;

-- 7. Топ мероприятий по доходимости до завершения.
SELECT
    event_name,
    event_type,
    event_format,
    start_date,
    participants_count,
    finished_participants_count,
    ROUND(finished_participants_count::numeric / NULLIF(participants_count, 0) * 100, 2) AS finish_rate
FROM real_events
WHERE participants_count > 0
ORDER BY finish_rate DESC
LIMIT 10;


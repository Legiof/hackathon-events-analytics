-- Динамика мероприятий, регистраций и участников по месяцам

SELECT
    DATE_TRUNC('month', start_date)::date AS event_month,
    COUNT(event_id) AS events_count,
    SUM(registrations_count) AS total_registrations,
    SUM(participants_count) AS total_participants,
    SUM(submitted_projects_count) AS total_submitted_projects,
    SUM(finished_participants_count) AS total_finished_participants
FROM it_events
GROUP BY DATE_TRUNC('month', start_date)
ORDER BY event_month;


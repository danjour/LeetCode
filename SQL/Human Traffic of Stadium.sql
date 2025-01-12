WITH cte AS (
    SELECT *,
           id - ROW_NUMBER() OVER (ORDER BY id) AS grp
    FROM Stadium
    WHERE people >= 100
)
SELECT id, visit_date, people
FROM (
    SELECT grp, COUNT(*) AS seq_length
    FROM cte
    GROUP BY grp
    HAVING COUNT(*) >= 3
) valid_sequences
JOIN cte ON cte.grp = valid_sequences.grp
ORDER BY id;

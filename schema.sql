-- ============================================================
-- TechParenthesis Finance Hub — Supabase Schema
-- Run this in: Supabase Dashboard → SQL Editor → New Query
-- ============================================================

-- ─────────────────────────────────────────────
-- TABLE 1: income
-- Tracks student enrollment payments
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS income (
    id            UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
    date          DATE          NOT NULL DEFAULT CURRENT_DATE,
    student_name  TEXT          NOT NULL,
    course_name   TEXT          NOT NULL
                                CHECK (course_name IN (
                                    'Python Launchpad',
                                    'Data Science & AI',
                                    'Jira Mastery'
                                )),
    amount        NUMERIC(12,2) NOT NULL CHECK (amount > 0),
    notes         TEXT,
    created_at    TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

-- ─────────────────────────────────────────────
-- TABLE 2: expenses
-- Tracks operational costs
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS expenses (
    id          UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
    date        DATE          NOT NULL DEFAULT CURRENT_DATE,
    category    TEXT          NOT NULL
                              CHECK (category IN (
                                  'Salaries',
                                  'Meta Ads',
                                  'Google Ads',
                                  'Website Maintenance',
                                  'Zoom',
                                  'Claude Subscription'
                              )),
    amount      NUMERIC(12,2) NOT NULL CHECK (amount > 0),
    notes       TEXT,
    created_at  TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

-- ─────────────────────────────────────────────
-- ROW LEVEL SECURITY (RLS)
-- Enable RLS and allow authenticated + anon reads
-- ─────────────────────────────────────────────
ALTER TABLE income   ENABLE ROW LEVEL SECURITY;
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;

-- Allow all operations for authenticated users
CREATE POLICY "Allow all for authenticated users" ON income
    FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all for authenticated users" ON expenses
    FOR ALL USING (true) WITH CHECK (true);

-- ─────────────────────────────────────────────
-- INDEXES for common query patterns
-- ─────────────────────────────────────────────
CREATE INDEX IF NOT EXISTS idx_income_date        ON income   (date DESC);
CREATE INDEX IF NOT EXISTS idx_income_course_name ON income   (course_name);
CREATE INDEX IF NOT EXISTS idx_expenses_date      ON expenses (date DESC);
CREATE INDEX IF NOT EXISTS idx_expenses_category  ON expenses (category);

-- ─────────────────────────────────────────────
-- SAMPLE DATA (optional — comment out if not needed)
-- ─────────────────────────────────────────────

-- Sample income records
INSERT INTO income (date, student_name, course_name, amount, notes) VALUES
    ('2025-04-01', 'Aarav Sharma',   'Python Launchpad',   9999.00,  'Batch #12 enrollment'),
    ('2025-04-03', 'Priya Nair',     'Data Science & AI',  14999.00, 'Early-bird discount applied'),
    ('2025-04-05', 'Rohan Mehta',    'Jira Mastery',        4999.00, 'Corporate referral'),
    ('2025-04-10', 'Sneha Patel',    'Python Launchpad',   9999.00,  NULL),
    ('2025-04-12', 'Vikram Reddy',   'Data Science & AI',  14999.00, 'EMI Plan - Installment 1');

-- Sample expense records
INSERT INTO expenses (date, category, amount, notes) VALUES
    ('2025-04-01', 'Salaries',            85000.00, 'April salary — 2 instructors'),
    ('2025-04-05', 'Meta Ads',             8500.00, 'Python Launchpad campaign'),
    ('2025-04-05', 'Google Ads',           6200.00, 'Data Science & AI campaign'),
    ('2025-04-07', 'Website Maintenance',  3500.00, 'SSL renewal + hosting'),
    ('2025-04-10', 'Zoom',                 1399.00, 'Pro plan monthly'),
    ('2025-04-10', 'Claude Subscription',  1700.00, 'Anthropic Pro plan');

-- ─────────────────────────────────────────────
-- VERIFICATION QUERIES
-- Run these after executing the above to confirm setup
-- ─────────────────────────────────────────────
-- SELECT * FROM income   ORDER BY date DESC;
-- SELECT * FROM expenses ORDER BY date DESC;
-- SELECT course_name, SUM(amount) AS total_revenue FROM income GROUP BY course_name;
-- SELECT category,   SUM(amount) AS total_spent   FROM expenses GROUP BY category;

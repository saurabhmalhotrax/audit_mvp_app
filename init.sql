-- Initialize audit MVP database
-- This script runs when the PostgreSQL container starts for the first time

-- Create basic tables for audit data (will be expanded in later phases)
CREATE TABLE IF NOT EXISTS audit_runs (
    id SERIAL PRIMARY KEY,
    transaction_id VARCHAR(255) NOT NULL,
    control_id VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index for common queries
CREATE INDEX IF NOT EXISTS idx_audit_runs_transaction_id ON audit_runs(transaction_id);
CREATE INDEX IF NOT EXISTS idx_audit_runs_control_id ON audit_runs(control_id);

-- Insert a test record
INSERT INTO audit_runs (transaction_id, control_id, status) 
VALUES ('test_transaction_001', 'AP_3WayMatch_10k', 'PENDING')
ON CONFLICT DO NOTHING; 
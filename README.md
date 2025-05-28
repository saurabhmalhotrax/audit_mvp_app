# Audit MVP Application

AI-driven audit application for autonomous control testing, focusing on the 3-way match control for Accounts Payable transactions exceeding $10,000.

## Overview

This MVP demonstrates autonomous audit control testing capabilities. The application:
- Processes transaction documents (Invoice, Purchase Order, Goods Received Note)
- Performs 3-way matching validation
- Generates audit reports and evidence
- Provides structured audit trail logging

## Architecture

- **Control Testing MCP**: Core audit logic and agents
- **Documentation MCP**: Audit logging and report generation
- **Shared Utils**: Common data models and utilities
- **PostgreSQL**: Data storage for audit results
- **FastAPI**: REST API for triggering audits

## Quick Start

### Prerequisites
- Python 3.9+
- Docker and Docker Compose
- Git

### Setup

1. **Clone and navigate to the project**:
   ```bash
   cd audit_mvp_app
   ```

2. **Set up Python virtual environment**:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

4. **Start PostgreSQL database**:
   ```bash
   docker-compose up -d postgres
   ```

5. **Run the application**:
   ```bash
   cd audit_mvp_app
   python -m uvicorn control_testing_mcp.main:app --reload
   ```

6. **Access the API**:
   - API: http://localhost:8000
   - Interactive docs: http://localhost:8000/docs
   - Health check: http://localhost:8000/health

## Development Status

### ✅ Phase 0: Setup & Basic Structure (COMPLETED)
- [x] Repository creation and Git setup
- [x] Directory structure
- [x] Initial dependencies
- [x] Docker setup for PostgreSQL
- [x] Placeholder agent files

### 🚧 Phase 1: Core Logic & Agents (IN PROGRESS)
- [ ] Control definitions JSON structure
- [ ] Shared data models (Pydantic)
- [ ] ControlDefinitionAgent implementation
- [ ] DocumentRetrieverAgent implementation
- [ ] TOEAgent (Test of Effectiveness) implementation
- [ ] OrchestratorAgent implementation
- [ ] FastAPI endpoints

### 📋 Phase 2: Documentation & Reporting (PLANNED)
- [ ] AuditLoggerAgent implementation
- [ ] WPAgent (Workpaper) implementation
- [ ] Integration with orchestrator
- [ ] End-to-end testing

### 📋 Phase 3: Integration Testing (PLANNED)
- [ ] Diverse sample document sets
- [ ] End-to-end workflow testing
- [ ] Bug fixes and refinements

### 📋 Phase 4: Demo Preparation (PLANNED)
- [ ] Code cleanup and documentation
- [ ] Demo scenarios
- [ ] Final testing

### 🔮 Future Integration Phase (POST-MVP)
- [ ] Integration with Core-services authentication
- [ ] Prometheus metrics export
- [ ] Structured logging to central system
- [ ] Service registry integration
- [ ] Frontend integration points

## Sample Usage

Once implemented, the API will support:

```bash
# Test a transaction against a control
curl -X POST "http://localhost:8000/test-control/AP_3WayMatch_10k/transaction/transaction_001"
```

## Project Structure

```
audit_mvp_app/
├── control_testing_mcp/          # Core audit logic
│   ├── agents/                   # Individual agent implementations
│   ├── services/                 # Supporting services
│   └── main.py                   # FastAPI application
├── documentation_mcp/            # Audit logging and reporting
│   └── agents/                   # Logger and report agents
├── shared_utils/                 # Common utilities and data models
├── tests/                        # Unit and integration tests
├── sample_documents/             # Test transaction documents
├── output_reports/               # Generated reports and evidence
├── config/                       # Configuration files
├── docker-compose.yml            # Database setup
└── requirements.txt              # Python dependencies
```

## Contributing

This is an MVP focused on demonstrating core audit capabilities. Future phases will add integration with the broader accounting application ecosystem.

## License

Private project - All rights reserved. 
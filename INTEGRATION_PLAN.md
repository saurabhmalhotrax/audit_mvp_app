# Integration Plan: Audit MVP ↔ Core-services

This document outlines the integration strategy for connecting the Audit MVP application with the existing Core-services infrastructure of the accounting application.

## Integration Overview

The Audit MVP will integrate with Core-services as a microservice within the broader accounting application ecosystem, providing plug-and-play audit functionality.

## Integration Points

### 1. Authentication & Authorization

**Current Core-services Setup:**
- JWT-based authentication
- Role-based access control (RBAC)
- Multiple auth providers (EMAIL_PASSWORD, GOOGLE, MICROSOFT, SAML, OIDC, API_KEY)
- MFA support

**Integration Strategy:**
- **Token Validation**: Audit MVP will validate JWT tokens issued by Core-services
- **Role Mapping**: Map audit-specific permissions to existing user roles
- **API Key Support**: Support service-to-service authentication via API keys

**Implementation Tasks:**
- [ ] Add JWT validation middleware to FastAPI
- [ ] Create audit-specific permission decorators
- [ ] Implement role-based access to audit endpoints
- [ ] Add API key authentication for service accounts

**Python Libraries:**
- `python-jose[cryptography]` for JWT validation
- `passlib` for password hashing (if needed)
- Custom middleware for Core-services token validation

### 2. Service Registry Integration

**Current Core-services Setup:**
- Service registry for microservice discovery
- Health check management
- Service status monitoring

**Integration Strategy:**
- **Service Registration**: Register Audit MVP as a discoverable service
- **Health Checks**: Implement health check endpoints compatible with Core-services
- **Service Discovery**: Enable other services to discover audit endpoints

**Implementation Tasks:**
- [ ] Implement service registration client
- [ ] Add comprehensive health check endpoints
- [ ] Create service metadata for discovery
- [ ] Add graceful shutdown handling

### 3. API Gateway Integration

**Current Core-services Setup:**
- Kong API Gateway
- Route management and load balancing
- Authentication at gateway level

**Integration Strategy:**
- **Route Registration**: Register audit endpoints with Kong
- **Gateway Authentication**: Leverage gateway-level auth
- **Rate Limiting**: Apply appropriate rate limits for audit operations

**Implementation Tasks:**
- [ ] Create Kong route configurations
- [ ] Implement gateway-compatible health checks
- [ ] Add request/response logging for gateway integration
- [ ] Configure rate limiting policies

### 4. Monitoring & Metrics

**Current Core-services Setup:**
- Prometheus metrics collection
- Custom metrics definitions
- HTTP request instrumentation
- Health check metrics

**Integration Strategy:**
- **Metrics Export**: Expose Prometheus-compatible metrics endpoint
- **Custom Metrics**: Define audit-specific metrics
- **Instrumentation**: Add request/response instrumentation

**Implementation Tasks:**
- [ ] Add `prometheus_client` dependency
- [ ] Implement `/metrics` endpoint
- [ ] Define audit-specific metrics (audit_runs_total, audit_duration_seconds, etc.)
- [ ] Add HTTP request instrumentation middleware
- [ ] Create health check status metrics

**Metrics to Implement:**
```python
# Counter metrics
audit_runs_total{control_id, status, transaction_type}
audit_errors_total{error_type, control_id}

# Histogram metrics  
audit_duration_seconds{control_id, transaction_type}
document_processing_duration_seconds{document_type}

# Gauge metrics
active_audit_runs{control_id}
audit_queue_size
```

### 5. Logging Integration

**Current Core-services Setup:**
- Structured logging (likely Pino-based)
- Centralized log aggregation
- Correlation ID tracking

**Integration Strategy:**
- **Structured Logging**: Output logs in format compatible with Core-services
- **Correlation IDs**: Support request correlation across services
- **Log Levels**: Align with Core-services logging standards

**Implementation Tasks:**
- [ ] Configure Python logging for structured output (JSON)
- [ ] Add correlation ID middleware
- [ ] Implement log level configuration
- [ ] Add request/response logging
- [ ] Create audit-specific log events

**Python Libraries:**
- `structlog` for structured logging
- Custom middleware for correlation ID handling

### 6. Database Integration

**Current Core-services Setup:**
- PostgreSQL database
- Potentially shared database or separate databases with API integration

**Integration Strategy:**
- **Separate Database**: Maintain audit-specific database for data isolation
- **API Integration**: Expose audit data via REST APIs for Core-services consumption
- **Data Synchronization**: Sync relevant transaction data from accounting system

**Implementation Tasks:**
- [ ] Design audit database schema
- [ ] Implement SQLAlchemy models
- [ ] Create data access layer
- [ ] Add database migration system
- [ ] Implement audit data APIs for Core-services consumption

### 7. Frontend Integration

**Current Core-services Setup:**
- Existing accounting application frontend
- Component-based architecture

**Integration Strategy:**
- **New Pages/Components**: Add audit-specific pages to existing frontend
- **API Integration**: Frontend calls audit endpoints
- **Shared UI Components**: Reuse existing UI components where possible

**Implementation Tasks:**
- [ ] Define audit UI/UX requirements
- [ ] Create audit dashboard components
- [ ] Implement audit report viewing
- [ ] Add audit configuration interfaces
- [ ] Integrate with existing navigation

## Implementation Phases

### Phase A: Core Integration (Authentication + Service Registry)
**Duration**: 1-2 weeks
**Priority**: High
- JWT validation middleware
- Service registration
- Basic health checks
- API gateway route registration

### Phase B: Monitoring & Logging (Observability)
**Duration**: 1 week  
**Priority**: High
- Prometheus metrics endpoint
- Structured logging
- Correlation ID support
- Request instrumentation

### Phase C: Database & API Integration
**Duration**: 2-3 weeks
**Priority**: Medium
- Database schema design
- SQLAlchemy models
- REST API endpoints for data access
- Data synchronization mechanisms

### Phase D: Frontend Integration
**Duration**: 2-4 weeks
**Priority**: Medium
- UI component development
- Dashboard implementation
- Report viewing interfaces
- User experience optimization

## Configuration Management

**Environment Variables:**
```bash
# Core-services integration
CORE_SERVICES_AUTH_URL=http://core-services:3000/auth
CORE_SERVICES_REGISTRY_URL=http://core-services:3000/registry
JWT_SECRET_KEY=<shared-secret>
JWT_ALGORITHM=HS256

# Service identity
SERVICE_ID=audit-mvp
SERVICE_VERSION=1.0.0
INSTANCE_ID=audit-mvp-001

# Monitoring
PROMETHEUS_ENABLED=true
METRICS_PORT=9090
LOG_LEVEL=INFO
CORRELATION_ID_HEADER=X-Correlation-ID

# Database
DATABASE_URL=postgresql://audit_user:audit_password@postgres:5432/audit_mvp
```

## Testing Strategy

### Integration Tests
- [ ] Authentication flow testing
- [ ] Service discovery testing  
- [ ] API gateway routing testing
- [ ] Metrics collection testing
- [ ] Log aggregation testing

### End-to-End Tests
- [ ] Full audit workflow with Core-services auth
- [ ] Frontend integration testing
- [ ] Performance testing with monitoring
- [ ] Failure scenario testing

## Rollback Strategy

- **Feature Flags**: Use feature flags to enable/disable integration features
- **Graceful Degradation**: Audit MVP should function independently if Core-services is unavailable
- **Database Isolation**: Maintain separate audit database to prevent data loss
- **Service Versioning**: Support multiple API versions during transition

## Security Considerations

- **Token Validation**: Validate all JWT tokens against Core-services
- **API Security**: Implement rate limiting and input validation
- **Data Isolation**: Ensure audit data is properly isolated and secured
- **Audit Logs**: Maintain immutable audit logs for compliance
- **Secret Management**: Use secure secret management for shared keys

## Success Metrics

- **Integration Completeness**: All integration points successfully implemented
- **Performance**: No significant performance degradation in Core-services
- **Reliability**: 99.9% uptime for audit services
- **User Experience**: Seamless user experience between accounting and audit features
- **Monitoring**: Full observability of audit operations

## Timeline

**Total Estimated Duration**: 6-10 weeks
**Dependencies**: Completion of MVP core functionality
**Resources**: 1-2 developers familiar with both Python and NestJS/TypeScript

This integration plan ensures the Audit MVP becomes a first-class citizen in the Core-services ecosystem while maintaining its independence and functionality. 
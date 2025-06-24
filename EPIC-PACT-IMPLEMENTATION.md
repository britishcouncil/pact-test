# EPIC: Implement Pact Contract Testing Across All Microservices

## 📋 Epic Overview
**Epic ID**: PACT-EPIC-001  
**Priority**: High  
**Estimated Duration**: 4 weeks  
**Team**: Platform/DevOps + Development Teams  

### 🎯 Objective
Implement comprehensive bi-directional Pact contract testing across all microservices to prevent API compatibility issues in production and ensure reliable service communication.

### 🏗️ Current Architecture
- **Frontend Consumer**: `geep` (Next.js)
- **Provider Services**:
  - `geep-chat-service` (Python/FastAPI)
  - `geep-dialogue-service` (Python/FastAPI)
  - `geep-prompt-service` (Node.js/NestJS)
  - `geep-task-service` (Python/FastAPI)

## ✅ **ACCEPTANCE CRITERIA**

### **🔧 Infrastructure Requirements**
- [ ] **AC-1**: Pact Broker is running locally via Docker with persistent storage
- [ ] **AC-2**: Pact Broker is accessible at `http://localhost:9292` with authentication
- [ ] **AC-3**: All services can publish and retrieve contracts from the broker
- [ ] **AC-4**: Pact Broker has automated cleanup policies configured

### **🔄 Consumer Contract Testing**
- [ ] **AC-5**: Frontend generates consumer contracts for ALL API endpoints across all 4 services
- [ ] **AC-6**: Consumer contracts cover successful API calls with realistic test data
- [ ] **AC-7**: Consumer contracts cover error scenarios (4xx, 5xx responses)
- [ ] **AC-8**: Consumer contracts are automatically published to Pact Broker on code changes
- [ ] **AC-9**: Consumer tests run in < 30 seconds locally

### **✅ Provider Verification Testing**
- [ ] **AC-10**: All 4 provider services have verification tests that validate published contracts
- [ ] **AC-11**: Provider verification tests use realistic test data and database fixtures
- [ ] **AC-12**: Provider verification covers all contract scenarios (success + error cases)
- [ ] **AC-13**: Provider verification tests run in < 2 minutes per service

### **🚀 CI/CD Integration**
- [ ] **AC-14**: GitHub Actions run consumer tests on frontend pull requests
- [ ] **AC-15**: GitHub Actions run provider verification on service pull requests
- [ ] **AC-16**: Deployment is blocked if contracts are incompatible ("Can-I-Deploy" checks)
- [ ] **AC-17**: Failed contract tests provide clear error messages and guidance
- [ ] **AC-18**: Contract verification status is visible in GitHub PR status checks

### **📊 Monitoring & Documentation**
- [ ] **AC-19**: Pact Broker dashboard shows contract compatibility matrix for all services
- [ ] **AC-20**: Auto-generated API documentation is available from contracts
- [ ] **AC-21**: Developers receive notifications when contracts fail
- [ ] **AC-22**: Contract versioning follows semantic versioning principles

### **🎓 Team Enablement**
- [ ] **AC-23**: Documentation exists for writing and maintaining contract tests
- [ ] **AC-24**: Troubleshooting guide available for common contract testing issues
- [ ] **AC-25**: Development team trained on contract testing workflow

## 📊 **Success Metrics**
- **Zero production API compatibility issues** within 3 months post-implementation
- **Contract test execution time** < 5 minutes total across all services
- **Developer feedback time** < 5 minutes for contract failures
- **Contract coverage** for 100% of critical API endpoints
- **Mean time to resolution** for API issues reduced by 80%

---

## 🎫 **STORY BREAKDOWN**

### **🏗️ Infrastructure Stories**

#### **Story 1: Pact Broker Infrastructure Setup**
**Story ID**: PACT-001  
**Points**: 5  
**Dependencies**: None  

**Description**: Set up Pact Broker infrastructure for local development and testing

**Tasks**:
- [ ] Configure Docker Compose for Pact Broker + PostgreSQL
- [ ] Set up authentication (basic auth)
- [ ] Configure database persistence and cleanup policies
- [ ] Verify broker accessibility and health checks
- [ ] Document broker setup and usage

**Acceptance Criteria**:
- Pact Broker accessible at http://localhost:9292
- Can authenticate with configured credentials
- Database persists data between restarts
- Health checks pass consistently

---

### **🔄 Consumer Contract Stories**

#### **Story 2: Chat Service Consumer Contracts**
**Story ID**: PACT-002  
**Points**: 8  
**Dependencies**: PACT-001  

**Description**: Create consumer contracts for frontend → chat service communication

**API Endpoints to Cover**:
- `POST /v1/turn` - Submit conversation turn
- `POST /v2/turn` - Submit conversation turn (v2)
- `POST /v1/dialogue` - Create dialogue session
- `POST /v1/eval-turn` - Evaluate conversation turn

**Tasks**:
- [ ] Set up consumer test structure in `geep/pact-contracts/chat-service/`
- [ ] Create contract tests for successful API calls
- [ ] Create contract tests for error scenarios
- [ ] Configure contract publishing to Pact Broker
- [ ] Add npm scripts for running consumer tests

**Acceptance Criteria**:
- All 4 endpoints have consumer contracts
- Contracts cover success and error cases
- Contracts publish successfully to broker
- Consumer tests pass locally

#### **Story 3: Dialogue Service Consumer Contracts**
**Story ID**: PACT-003  
**Points**: 8  
**Dependencies**: PACT-002  

**Description**: Create consumer contracts for frontend → dialogue service communication

**API Endpoints to Cover**:
- `POST /v2/dialogue` - Dialogue operations
- `POST /v1/transcript` - Transcript management
- `POST /v2/turn` - Turn management
- `POST /v1/survey` - Survey operations

#### **Story 4: Prompt Service Consumer Contracts**
**Story ID**: PACT-004  
**Points**: 6  
**Dependencies**: PACT-003  

**Description**: Create consumer contracts for frontend → prompt service communication

**API Endpoints to Cover**:
- Prompt controller endpoints (from `prompt.controller.ts`)

#### **Story 5: Task Service Consumer Contracts**
**Story ID**: PACT-005  
**Points**: 6  
**Dependencies**: PACT-004  

**Description**: Create consumer contracts for frontend → task service communication

---

### **✅ Provider Verification Stories**

#### **Story 6: Chat Service Provider Verification**
**Story ID**: PACT-006  
**Points**: 8  
**Dependencies**: PACT-002  

**Description**: Implement provider verification for chat service

**Tasks**:
- [ ] Add `pact-python` dependency to chat service
- [ ] Create provider verification test setup
- [ ] Configure test database and fixtures
- [ ] Implement verification for all consumer contracts
- [ ] Add provider verification to local test commands

**Acceptance Criteria**:
- Provider verification tests pass for all consumer contracts
- Test data fixtures provide realistic scenarios
- Verification runs in < 2 minutes
- Tests can run independently

#### **Story 7: Dialogue Service Provider Verification**
**Story ID**: PACT-007  
**Points**: 8  
**Dependencies**: PACT-003  

#### **Story 8: Prompt Service Provider Verification**
**Story ID**: PACT-008  
**Points**: 6  
**Dependencies**: PACT-004  

**Description**: Implement provider verification for prompt service (Node.js/NestJS)

#### **Story 9: Task Service Provider Verification**
**Story ID**: PACT-009  
**Points**: 6  
**Dependencies**: PACT-005  

---

### **🚀 CI/CD Integration Stories**

#### **Story 10: Frontend CI/CD Integration**
**Story ID**: PACT-010  
**Points**: 5  
**Dependencies**: PACT-002, PACT-003, PACT-004, PACT-005  

**Description**: Integrate consumer contract testing into frontend CI/CD pipeline

**Tasks**:
- [ ] Create GitHub Actions workflow for consumer tests
- [ ] Configure contract publishing on successful tests
- [ ] Add PR status checks for contract tests
- [ ] Configure failure notifications
- [ ] Document CI/CD workflow

#### **Story 11: Provider Services CI/CD Integration**
**Story ID**: PACT-011  
**Points**: 8  
**Dependencies**: PACT-006, PACT-007, PACT-008, PACT-009  

**Description**: Integrate provider verification into all service CI/CD pipelines

**Tasks**:
- [ ] Create GitHub Actions workflows for each service
- [ ] Configure Can-I-Deploy checks
- [ ] Set up deployment blocking on contract failures
- [ ] Configure webhook notifications from Pact Broker
- [ ] Add contract status to PR checks

---

### **📊 Monitoring & Documentation Stories**

#### **Story 12: Contract Monitoring & Dashboards**
**Story ID**: PACT-012  
**Points**: 3  
**Dependencies**: PACT-010, PACT-011  

**Description**: Set up monitoring and dashboards for contract testing

**Tasks**:
- [ ] Configure Pact Broker matrix dashboard
- [ ] Set up contract compatibility badges
- [ ] Configure automated notifications for failures
- [ ] Create contract versioning strategy
- [ ] Set up contract cleanup automation

#### **Story 13: Documentation & Training**
**Story ID**: PACT-013  
**Points**: 5  
**Dependencies**: All previous stories  

**Description**: Create comprehensive documentation and team training

**Tasks**:
- [ ] Write developer guide for contract testing
- [ ] Create troubleshooting documentation
- [ ] Document best practices and patterns
- [ ] Create video walkthrough for team
- [ ] Conduct team training sessions

---

## 📅 **IMPLEMENTATION TIMELINE**

### **Sprint 1 (Week 1)**
- PACT-001: Pact Broker Infrastructure Setup
- PACT-002: Chat Service Consumer Contracts
- PACT-006: Chat Service Provider Verification

### **Sprint 2 (Week 2)**
- PACT-003: Dialogue Service Consumer Contracts
- PACT-007: Dialogue Service Provider Verification
- PACT-010: Frontend CI/CD Integration (partial)

### **Sprint 3 (Week 3)**
- PACT-004: Prompt Service Consumer Contracts
- PACT-005: Task Service Consumer Contracts
- PACT-008: Prompt Service Provider Verification
- PACT-009: Task Service Provider Verification

### **Sprint 4 (Week 4)**
- PACT-010: Frontend CI/CD Integration (complete)
- PACT-011: Provider Services CI/CD Integration
- PACT-012: Contract Monitoring & Dashboards
- PACT-013: Documentation & Training

## 🎯 **Definition of Done**
- [ ] All acceptance criteria met
- [ ] All story tickets completed and verified
- [ ] CI/CD pipelines functional and preventing incompatible deployments
- [ ] Team trained and documentation complete
- [ ] Production deployment successful with contract testing active

## 🚨 **Risks & Mitigation**
- **Risk**: Team unfamiliar with contract testing
  - **Mitigation**: Comprehensive training and documentation
- **Risk**: Complex service interactions
  - **Mitigation**: Start simple, iterate and improve
- **Risk**: CI/CD pipeline disruption
  - **Mitigation**: Feature flags and gradual rollout

---

**Ready to start with PACT-001: Pact Broker Infrastructure Setup?** 
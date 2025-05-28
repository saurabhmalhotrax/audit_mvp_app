"""
Main FastAPI application for the Control Testing MCP.
This will serve as the entry point for the audit MVP application.
"""

from fastapi import FastAPI

app = FastAPI(
    title="Audit MVP - Control Testing MCP",
    description="AI-driven audit application for control testing",
    version="0.1.0"
)

@app.get("/")
async def root():
    return {"message": "Audit MVP Control Testing MCP is running"}

@app.get("/health")
async def health_check():
    return {"status": "healthy"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000) 
library(mcpr)

# Create MCP server
mcp <- new_server(
  name = "R MCP Server",
  description = "R-based MCP server providing statistical and data processing tools",
  version = "1.0.0"
)

# --- Define tools below, then add them with add_capability() ---

# Example: a simple calculator tool
calculator <- new_tool(
  name = "r_calculator",
  description = "Performs basic arithmetic operations",
  input_schema = schema(
    properties = properties(
      operation = property_enum(
        "Operation",
        "Math operation to perform",
        enum = c("add", "subtract", "multiply", "divide"),
        required = TRUE
      ),
      a = property_number("First number", "First operand", required = TRUE),
      b = property_number("Second number", "Second operand", required = TRUE)
    )
  ),
  handler = function(input) {
    result <- switch(input$operation,
      "add"      = input$a + input$b,
      "subtract" = input$a - input$b,
      "multiply" = input$a * input$b,
      "divide"   = input$a / input$b
    )
    response_text(paste("Result:", result))
  }
)

mcp <- add_capability(mcp, calculator)

# Serve via stdio (Claude Code MCP transport)
serve_io(mcp)

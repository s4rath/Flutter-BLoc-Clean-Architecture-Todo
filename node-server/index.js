
import express from "express";

const app = express();
const PORT = 3000;


app.use(express.json());

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET,PUT,PATCH,POST,DELETE");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept",
  );
  next();
});


let todos = [];
let nextId = 1;



// ✅ Get all todos
app.get("/todos", (req, res) => {
  res.json(todos);
});

// ✅ Add a new todo
app.post("/todos", (req, res) => {
  const { title, description } = req.body;

  if (!title) {
    return res.status(400).json({ error: "Title is required" });
  }

  const newTodo = {
    id: nextId++,
    title,
    description: description || "", // Optional description
    completed: false,
  };

  todos.push(newTodo);
  res.status(201).json(newTodo);
});

// ✅ Update (mark complete or edit title/description)
app.put("/todos/:id", (req, res) => {
  const id = parseInt(req.params.id);
  const todo = todos.find((t) => t.id === id);

  if (!todo) {
    return res.status(404).json({ error: "Todo not found" });
  }

  const { title, description, completed } = req.body;

  if (title !== undefined) todo.title = title;
  if (description !== undefined) todo.description = description;
  if (completed !== undefined) todo.completed = completed;

  res.json(todo);
});

// ✅ Delete a todo
app.delete("/todos/:id", (req, res) => {
  const id = parseInt(req.params.id);
  const exists = todos.some((t) => t.id === id);

  if (!exists) {
    return res.status(404).json({ error: "Todo not found" });
  }

  todos = todos.filter((t) => t.id !== id);
  res.json({ message: "Todo deleted successfully" });
});

// ✅ Root route
app.get("/", (req, res) => {
  res.send("✅ Simple To-Do API with description is running!");
});

// ✅ Start the server
app.listen(PORT, () => {
  console.log(`🚀 Server running at http://localhost:${PORT}`);
});

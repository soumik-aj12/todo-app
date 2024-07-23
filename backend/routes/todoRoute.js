import express from "express";
import { addTodos, fetchTodos, deleteTodos } from "../controllers/todoController.js";

const router = express.Router();

router.get("/todos", fetchTodos);
router.post("/todos", addTodos);
router.delete("/todos/:id", deleteTodos);

export {router as TodoRouter};

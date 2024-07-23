import connection from "../dbConfig.js";
export const fetchTodos = async (req, res) => {
    try{
        const [response] = await connection.query('SELECT * FROM todos');
        if(response.length>0){
            return res.json(response);
        }
        return res.json({"error":true});
    }catch(e){
        console.log(e);
    }
     
      
  }
export const addTodos =  async (req, res) => {
    try{
        const { title } = req.body;
        const [insert] = await connection.execute('INSERT INTO todos (title) VALUES (?)', [title]);
        if (insert.affectedRows > 0) {
          const [result] = await connection.execute('SELECT * FROM todos where id = (SELECT max(id) from todos)');
          console.log(result)
          if(result.length > 0){
            return res.json({ id: result[0].id, title });
          }else{
            return res.status(400).json({error:true, response: "Couln't get the latest data"});
          }
      
      }
      return res.status(400).json({error:true, response: "Couln't insert the latest data"});
    }
    catch(e){
        console.log(e);
    }
  }

export const deleteTodos = async (req, res) => {
  try{
    const { id } = req.params;
    const [result] = await connection.execute("DELETE FROM todos WHERE id = ?", [id]);
    if(result.affectedRows>0){
      return res.status(200).json({error:false, response: "Successfully deleted!"});
    }
  }catch(e){
      console.log(e);
  }
  }
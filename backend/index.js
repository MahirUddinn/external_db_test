import express from 'express';
import pkg from 'pg';
import cors from 'cors';

const { Pool } = pkg;

const app = express();
app.use(cors());
app.use(express.json());

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'test_app',
  password: '787898',
  port: 5432,
});

app.get('/items', async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT * FROM item_dtl ORDER BY item_id DESC'
    );
    res.json(result.rows);
  } catch (error) {
    console.error('DB ERROR:', error);
    res.status(500).json({ error: 'Database error' });
  }
});

app.post('/items', async (req, res) => {
  try {
    const {
      item_code,
      item_barcode,
      item_name,
      item_name_bn,
      item_des,
      item_stock,
      item_sales_price,
      item_general_discount,
      item_pur_price
    } = req.body;

    const query = `
      INSERT INTO item_dtl (
        item_code,
        item_barcode,
        item_name,
        item_name_bn,
        item_des,
        item_stock,
        item_sales_price,
        item_general_discount,
        item_pur_price
      )
      VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9)
      RETURNING *;
    `;

    const values = [
      item_code,
      item_barcode,
      item_name,
      item_name_bn,
      item_des,
      item_stock,
      item_sales_price,
      item_general_discount,
      item_pur_price
    ];

    const result = await pool.query(query, values);

    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('POST /items ERROR:', error);
    res.status(500).json({ error: 'Insert failed' });
  }
});

app.put('/items/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const {
      item_code,
      item_barcode,
      item_name,
      item_name_bn,
      item_des,
      item_stock,
      item_sales_price,
      item_general_discount,
      item_pur_price
    } = req.body;

    const query = `
      UPDATE item_dtl
      SET 
        item_code = $1,
        item_barcode = $2,
        item_name = $3,
        item_name_bn = $4,
        item_des = $5,
        item_stock = $6,
        item_sales_price = $7,
        item_general_discount = $8,
        item_pur_price = $9
      WHERE item_id = $10
      RETURNING *;
    `;

    const values = [
      item_code,
      item_barcode,
      item_name,
      item_name_bn,
      item_des,
      item_stock,
      item_sales_price,
      item_general_discount,
      item_pur_price,
      id
    ];

    const result = await pool.query(query, values);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Item not found' });
    }

    res.json(result.rows[0]);
  } catch (error) {
    console.error('PUT /items/:id ERROR:', error);
    res.status(500).json({ error: 'Update failed' });
  }
});

app.delete('/items/:id', async (req, res) => {
  try {
    const { id } = req.params;

    const result = await pool.query(
      'DELETE FROM item_dtl WHERE item_id = $1 RETURNING *;',
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Item not found' });
    }

    res.json({ message: 'Item deleted successfully', item: result.rows[0] });
  } catch (error) {
    console.error('DELETE /items/:id ERROR:', error);
    res.status(500).json({ error: 'Delete failed' });
  }
});


app.listen(3000, () => {
  console.log('API running on http://localhost:3000');
});

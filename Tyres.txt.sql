-- DROP SCHEMA tyres;

CREATE SCHEMA tyres AUTHORIZATION user02;
-- tyres.agent_type definition

-- Drop table

-- DROP TABLE tyres.agent_type;

CREATE TABLE tyres.agent_type (
	id int4 NOT NULL,
	title varchar NOT NULL,
	image varchar NULL,
	CONSTRAINT agent_type_pk PRIMARY KEY (id)
);


-- tyres.material_type definition

-- Drop table

-- DROP TABLE tyres.material_type;

CREATE TABLE tyres.material_type (
	id int4 NOT NULL,
	title varchar NOT NULL,
	defected_percent float8 NULL,
	CONSTRAINT material_type_pk PRIMARY KEY (id)
);


-- tyres.product_type definition

-- Drop table

-- DROP TABLE tyres.product_type;

CREATE TABLE tyres.product_type (
	id int4 NOT NULL,
	title varchar NOT NULL,
	defected_percent float4 NULL,
	CONSTRAINT product_type_pk PRIMARY KEY (id)
);


-- tyres.supplier definition

-- Drop table

-- DROP TABLE tyres.supplier;

CREATE TABLE tyres.supplier (
	id int4 NOT NULL,
	title varchar NOT NULL,
	inn varchar NOT NULL,
	start_date date NOT NULL,
	quality_rating int4 NULL,
	supplier_type varchar NULL,
	CONSTRAINT supplier_pk PRIMARY KEY (id)
);


-- tyres.agent definition

-- Drop table

-- DROP TABLE tyres.agent;

CREATE TABLE tyres.agent (
	id int4 NOT NULL,
	title varchar NOT NULL,
	agent_type_id int4 NOT NULL,
	address varchar NULL,
	inn varchar NOT NULL,
	kpp varchar NULL,
	director_name varchar NULL,
	phone varchar NOT NULL,
	email varchar NULL,
	logo varchar NULL,
	priority int4 NOT NULL,
	CONSTRAINT agent_pk PRIMARY KEY (id),
	CONSTRAINT agent_fk FOREIGN KEY (agent_type_id) REFERENCES tyres.agent_type(id)
);


-- tyres.agent_priority_history definition

-- Drop table

-- DROP TABLE tyres.agent_priority_history;

CREATE TABLE tyres.agent_priority_history (
	id int4 NOT NULL,
	agent_id int4 NOT NULL,
	change_date timestamp NOT NULL,
	prioroty_value int4 NOT NULL,
	CONSTRAINT agent_priority_history_pk PRIMARY KEY (id),
	CONSTRAINT agent_priority_history_fk FOREIGN KEY (agent_id) REFERENCES tyres.agent(id)
);


-- tyres.material definition

-- Drop table

-- DROP TABLE tyres.material;

CREATE TABLE tyres.material (
	id int4 NOT NULL,
	title varchar NOT NULL,
	countin_pack int4 NOT NULL,
	unit varchar NOT NULL,
	countin_stock float8 NULL,
	min_count float8 NULL,
	description varchar NULL,
	"cost" numeric NOT NULL,
	image varchar NULL,
	material_type_id int4 NULL,
	materia_type_id int4 NULL,
	CONSTRAINT material_pk PRIMARY KEY (id),
	CONSTRAINT material_fk FOREIGN KEY (material_type_id) REFERENCES tyres.material_type(id)
);


-- tyres.material_count_history definition

-- Drop table

-- DROP TABLE tyres.material_count_history;

CREATE TABLE tyres.material_count_history (
	id int4 NOT NULL,
	material_id int4 NOT NULL,
	change_date timestamp NOT NULL,
	count_value float8 NOT NULL,
	CONSTRAINT material_count_history_pk PRIMARY KEY (id),
	CONSTRAINT material_count_history_fk FOREIGN KEY (material_id) REFERENCES tyres.material(id)
);


-- tyres.material_supplier definition

-- Drop table

-- DROP TABLE tyres.material_supplier;

CREATE TABLE tyres.material_supplier (
	material_id int4 NOT NULL,
	supplier_id int4 NOT NULL,
	CONSTRAINT material_supplier_pk PRIMARY KEY (material_id, supplier_id),
	CONSTRAINT material_supplier_fk FOREIGN KEY (supplier_id) REFERENCES tyres.supplier(id),
	CONSTRAINT material_supplier_fk_1 FOREIGN KEY (material_id) REFERENCES tyres.material(id)
);


-- tyres.product definition

-- Drop table

-- DROP TABLE tyres.product;

CREATE TABLE tyres.product (
	id int4 NOT NULL,
	title varchar NOT NULL,
	product_type_id int4 NULL,
	article_number varchar NOT NULL,
	description varchar NULL,
	image varchar NULL,
	production_person_count int4 NULL,
	production_workshop_number int4 NULL,
	min_cost_for_agent numeric NOT NULL,
	CONSTRAINT product_pk PRIMARY KEY (id),
	CONSTRAINT product_fk FOREIGN KEY (product_type_id) REFERENCES tyres.product_type(id)
);


-- tyres.product_cost_history definition

-- Drop table

-- DROP TABLE tyres.product_cost_history;

CREATE TABLE tyres.product_cost_history (
	id int4 NOT NULL,
	product_id int4 NOT NULL,
	change_date timestamp NOT NULL,
	cost_value numeric NOT NULL,
	CONSTRAINT product_cost_history_pk PRIMARY KEY (id),
	CONSTRAINT product_cost_history_fk FOREIGN KEY (product_id) REFERENCES tyres.product(id)
);


-- tyres.product_material definition

-- Drop table

-- DROP TABLE tyres.product_material;

CREATE TABLE tyres.product_material (
	product_id int4 NOT NULL,
	material_id int4 NOT NULL,
	count float8 NULL,
	CONSTRAINT product_material_pk PRIMARY KEY (product_id, material_id),
	CONSTRAINT product_material_fk FOREIGN KEY (material_id) REFERENCES tyres.material(id),
	CONSTRAINT product_material_fk1 FOREIGN KEY (product_id) REFERENCES tyres.product(id)
);


-- tyres.product_sale definition

-- Drop table

-- DROP TABLE tyres.product_sale;

CREATE TABLE tyres.product_sale (
	id int4 NOT NULL,
	agent_id int4 NOT NULL,
	product_id int4 NOT NULL,
	sale_date date NOT NULL,
	product_count int4 NOT NULL,
	CONSTRAINT product_sale_pk PRIMARY KEY (id),
	CONSTRAINT product_sale_fk FOREIGN KEY (agent_id) REFERENCES tyres.agent(id),
	CONSTRAINT product_sale_fk1 FOREIGN KEY (product_id) REFERENCES tyres.product(id)
);


-- tyres.shop definition

-- Drop table

-- DROP TABLE tyres.shop;

CREATE TABLE tyres.shop (
	id int4 NOT NULL,
	title varchar NOT NULL,
	address varchar NULL,
	agent_id int4 NOT NULL,
	CONSTRAINT shop_pk PRIMARY KEY (id),
	CONSTRAINT shop_fk FOREIGN KEY (agent_id) REFERENCES tyres.agent(id)
);


INSERT INTO tyres.material_type (id,title,defected_percent) VALUES
	 (1,'Резина',NULL),
	 (2,'Шипы',NULL);


INSERT INTO tyres.material (id,title,countin_pack,unit,countin_stock,min_count,description,"cost",image,material_type_id,materia_type_id) VALUES
	 (1,'Резина для зимы 0x3',4,'м',726.0,46.0,NULL,37293.00,NULL,NULL,1),
	 (2,'Резина для зимы 1x0',5,'кг',929.0,48.0,NULL,43046.00,NULL,NULL,1),
	 (3,'Резина для зимы 1x3',9,'м',84.0,50.0,NULL,27823.00,NULL,NULL,1),
	 (4,'Резина для зимы 2x3',3,'м',344.0,12.0,NULL,53323.00,NULL,NULL,1),
	 (5,'Резина для зимы 3x1',9,'кг',690.0,24.0,NULL,25844.00,NULL,NULL,1),
	 (6,'Резина для зимы 3x3',2,'кг',275.0,28.0,NULL,31356.00,NULL,NULL,1),
	 (7,'Резина для лета 0x1',9,'кг',127.0,17.0,NULL,23936.00,NULL,NULL,1),
	 (8,'Резина для лета 0x2',4,'кг',753.0,33.0,NULL,9069.00,NULL,NULL,1),
	 (9,'Резина для лета 1x0',5,'м',234.0,32.0,NULL,25499.00,NULL,NULL,1),
	 (10,'Резина для лета 2x1',2,'м',561.0,39.0,NULL,47610.00,NULL,NULL,1);
INSERT INTO tyres.material (id,title,countin_pack,unit,countin_stock,min_count,description,"cost",image,material_type_id,materia_type_id) VALUES
	 (11,'Резина для лета 2x2',2,'м',542.0,20.0,NULL,54298.00,NULL,NULL,1),
	 (12,'Резина для лета 3x3',6,'м',652.0,28.0,NULL,6764.00,NULL,NULL,1),
	 (13,'Резина для льда 0x1',5,'м',964.0,34.0,NULL,53394.00,NULL,NULL,1),
	 (14,'Резина для льда 0x2',2,'кг',816.0,21.0,NULL,48785.00,NULL,NULL,1),
	 (15,'Резина для льда 1x3',2,'кг',286.0,39.0,NULL,23551.00,NULL,NULL,1),
	 (16,'Резина для льда 2x0',6,'м',86.0,8.0,NULL,24767.00,NULL,NULL,1),
	 (17,'Резина для льда 3x3',7,'кг',909.0,35.0,NULL,23174.00,NULL,NULL,1),
	 (18,'Резина для пустыни 0x3',8,'м',761.0,7.0,NULL,8094.00,NULL,NULL,1),
	 (19,'Резина для пустыни 1x1',6,'кг',120.0,21.0,NULL,11642.00,NULL,NULL,1),
	 (20,'Резина для пустыни 1x2',9,'кг',496.0,36.0,NULL,24876.00,NULL,NULL,1);
INSERT INTO tyres.material (id,title,countin_pack,unit,countin_stock,min_count,description,"cost",image,material_type_id,materia_type_id) VALUES
	 (21,'Резина для пустыни 1x3',5,'кг',222.0,9.0,NULL,21546.00,NULL,NULL,1),
	 (22,'Резина для пустыни 2x0',5,'кг',769.0,14.0,NULL,17425.00,NULL,NULL,1),
	 (23,'Резина для пустыни 2x1',10,'кг',918.0,12.0,NULL,34518.00,NULL,NULL,1),
	 (24,'Резина для пустыни 2x3',5,'м',103.0,38.0,NULL,55679.00,NULL,NULL,1),
	 (25,'Резина для пустыни 3x2',1,'м',931.0,43.0,NULL,5854.00,NULL,NULL,1),
	 (26,'Резина для пустыни 3x3',9,'м',840.0,11.0,NULL,5144.00,NULL,NULL,1),
	 (27,'Шипы для зимы 0x1',3,'г',255.0,25.0,NULL,6484.00,NULL,NULL,2),
	 (28,'Шипы для зимы 2x0',3,'шт',466.0,8.0,NULL,34841.00,NULL,NULL,2),
	 (29,'Шипы для зимы 3x0',6,'г',192.0,48.0,NULL,9260.00,NULL,NULL,2),
	 (30,'Шипы для зимы 3x3',4,'г',652.0,33.0,NULL,15159.00,NULL,NULL,2);
INSERT INTO tyres.material (id,title,countin_pack,unit,countin_stock,min_count,description,"cost",image,material_type_id,materia_type_id) VALUES
	 (31,'Шипы для лета 0x1',2,'кг',974.0,35.0,NULL,28825.00,NULL,NULL,2),
	 (32,'Шипы для лета 2x0',1,'г',68.0,43.0,NULL,8206.00,NULL,NULL,2),
	 (33,'Шипы для лета 2x2',4,'г',15.0,10.0,NULL,44506.00,NULL,NULL,2),
	 (34,'Шипы для лета 3x1',6,'кг',184.0,40.0,NULL,51974.00,NULL,NULL,2),
	 (35,'Шипы для лета 3x2',1,'г',547.0,11.0,NULL,43288.00,NULL,NULL,2),
	 (36,'Шипы для льда 0x0',2,'кг',585.0,37.0,NULL,21188.00,NULL,NULL,2),
	 (37,'Шипы для льда 0x1',2,'шт',147.0,8.0,NULL,49557.00,NULL,NULL,2),
	 (38,'Шипы для льда 1x0',10,'г',914.0,22.0,NULL,25538.00,NULL,NULL,2),
	 (39,'Шипы для льда 1x1',7,'г',335.0,33.0,NULL,48279.00,NULL,NULL,2),
	 (40,'Шипы для льда 2x0',4,'шт',214.0,15.0,NULL,17996.00,NULL,NULL,2);
INSERT INTO tyres.material (id,title,countin_pack,unit,countin_stock,min_count,description,"cost",image,material_type_id,materia_type_id) VALUES
	 (41,'Шипы для льда 2x2',1,'г',479.0,22.0,NULL,13077.00,NULL,NULL,2),
	 (42,'Шипы для льда 3x0',9,'г',885.0,5.0,NULL,52272.00,NULL,NULL,2),
	 (43,'Шипы для льда 3x2',3,'г',470.0,26.0,NULL,6511.00,NULL,NULL,2),
	 (44,'Шипы для льда 2x1',10,'шт',634.0,25.0,NULL,23287.00,NULL,NULL,2),
	 (45,'Шипы для льда 2x3',10,'шт',237.0,7.0,NULL,27105.00,NULL,NULL,2),
	 (46,'Шипы для льда 3x1',8,'г',123.0,43.0,NULL,42668.00,NULL,NULL,2),
	 (47,'Шипы для пустыни 0x1',4,'шт',612.0,24.0,NULL,55689.00,NULL,NULL,2),
	 (48,'Шипы для пустыни 0x2',4,'г',792.0,46.0,NULL,8571.00,NULL,NULL,2),
	 (49,'Шипы для пустыни 3x1',4,'г',37.0,43.0,NULL,27104.00,NULL,NULL,2),
	 (50,'Шипы для пустыни 3x2',2,'г',923.0,19.0,NULL,28748.00,NULL,NULL,2);


INSERT INTO tyres.product_type (id,title,defected_percent) VALUES
	 (1,'Колесо',NULL),
	 (2,'Запаска',NULL),
	 (3,'Шина',NULL),
	 (4,'Диск',NULL);


INSERT INTO tyres.product (id,title,product_type_id,article_number,description,image,production_person_count,production_workshop_number,min_cost_for_agent) VALUES
	 (1,'Колесо R14 Кованый',1,'429265','','',3,6,11838.00),
	 (2,'Колесо R15 Кованый',1,'376388','','',3,4,9439.00),
	 (3,'Колесо R16 Лето',1,'337577','','\products\tire_2.jpg',1,9,10161.00),
	 (4,'Колесо R16 Липучка',1,'263261','','',4,1,14521.00),
	 (5,'Колесо R17 Зима',1,'381949','','',4,6,5902.00),
	 (6,'Колесо R17 Лето',1,'332936','','\products\tire_28.jpg',2,1,11145.00),
	 (7,'Колесо R17 Липучка',1,'281537','','',1,2,4365.00),
	 (8,'Колесо R18 Зима',1,'387609','','\products\tire_9.jpg',1,4,3445.00),
	 (9,'Колесо R18 Кованый',1,'241659','','\products\tire_15.jpg',4,10,11509.00),
	 (10,'Колесо R18 Лето',1,'412238','','\products\tire_14.jpg',2,7,13892.00);
INSERT INTO tyres.product (id,title,product_type_id,article_number,description,image,production_person_count,production_workshop_number,min_cost_for_agent) VALUES
	 (11,'Колесо R18 Липучка',1,'332858','','\products\tire_12.jpg',3,7,14804.00),
	 (12,'Колесо R19 Лето',1,'298778','','\products\tire_38.jpg',1,10,7493.00),
	 (13,'Колесо R19 Липучка',1,'440973','','\products\tire_5.jpg',4,4,8439.00),
	 (14,'Колесо R20 Зима',1,'427198','','',4,10,2397.00),
	 (15,'Колесо R20 Кованый',1,'445217','','\products\tire_1.jpg',3,10,9569.00),
	 (16,'Колесо R20 Лето',1,'434626','','\products\tire_31.jpg',5,8,11959.00),
	 (17,'Колесо R20 Липучка',1,'363664','','',1,8,12681.00),
	 (18,'Колесо R21 Лето',1,'276905','','',1,2,10343.00),
	 (19,'Колесо R21 Липучка',1,'403378','','\products\tire_55.jpg',3,10,3626.00),
	 (20,'Запаска R14 Зима',2,'440993','','',5,2,6020.00);
INSERT INTO tyres.product (id,title,product_type_id,article_number,description,image,production_person_count,production_workshop_number,min_cost_for_agent) VALUES
	 (21,'Запаска R14 Кованый',2,'412235','','\products\tire_47.jpg',4,6,12891.00),
	 (22,'Запаска R14 Лето',2,'448396','','\products\tire_32.jpg',1,5,12878.00),
	 (23,'Запаска R15 Зима',2,'251241','','',3,10,3874.00),
	 (24,'Запаска R15 Кованый',2,'327657','','\products\tire_64.jpg',2,8,8667.00),
	 (25,'Запаска R15 Лето',2,'348910','','\products\tire_50.jpg',1,9,4969.00),
	 (26,'Запаска R15 Липучка',2,'237228','','\products\tire_18.jpg',3,8,5510.00),
	 (27,'Запаска R16 Зима',2,'394413','','\products\tire_49.jpg',3,10,12679.00),
	 (28,'Запаска R16 Кованый',2,'432234','','',3,7,13556.00),
	 (29,'Запаска R17 Кованый',2,'372287','','\products\tire_57.jpg',5,3,5808.00),
	 (30,'Запаска R17 Лето',2,'331576','','\products\tire_39.jpg',3,8,4803.00);
INSERT INTO tyres.product (id,title,product_type_id,article_number,description,image,production_person_count,production_workshop_number,min_cost_for_agent) VALUES
	 (31,'Запаска R17 Липучка',2,'327883','','\products\tire_10.jpg',2,2,12332.00),
	 (32,'Запаска R18 Лето',2,'305509','','\products\tire_41.jpg',1,3,5192.00),
	 (33,'Запаска R18 Липучка',2,'279256','','\products\tire_53.jpg',4,5,9759.00),
	 (34,'Запаска R19 Зима',2,'254860','','',2,5,5568.00),
	 (35,'Запаска R19 Кованый',2,'390434','','\products\tire_46.jpg',5,8,14258.00),
	 (36,'Запаска R19 Лето',2,'283112','','\products\tire_33.jpg',3,4,3362.00),
	 (37,'Запаска R19 Липучка',2,'438383','','',3,1,12000.00),
	 (38,'Запаска R20 Зима',2,'241577','','\products\tire_51.jpg',2,6,9125.00),
	 (39,'Запаска R20 Кованый',2,'249737','','',5,5,7509.00),
	 (40,'Запаска R20 Липучка',2,'335226','','',1,2,9988.00);
INSERT INTO tyres.product (id,title,product_type_id,article_number,description,image,production_person_count,production_workshop_number,min_cost_for_agent) VALUES
	 (41,'Запаска R21 Зима',2,'365509','','',5,6,14556.00),
	 (42,'Запаска R21 Лето',2,'299112','','\products\tire_43.jpg',2,8,3694.00),
	 (43,'Запаска R21 Липучка',2,'247470','','\products\tire_62.jpg',1,2,10139.00),
	 (44,'Запаска R22 Зима',2,'268886','','',3,2,13471.00),
	 (45,'Запаска R22 Кованый',2,'341800','','',2,4,5447.00),
	 (46,'Запаска R22 Липучка',2,'328305','','\products\tire_13.jpg',2,1,10116.00),
	 (47,'Запаска R23 Зима',2,'394768','','\products\tire_8.jpg',1,9,13019.00),
	 (48,'Шина R14 Кованый',3,'274477','','\products\tire_34.jpg',5,5,9527.00),
	 (49,'Шина R14 Лето',3,'330951','','\products\tire_29.jpg',4,7,6786.00),
	 (50,'Шина R14 Липучка',3,'331598','','\products\tire_17.jpg',4,1,13879.00);
INSERT INTO tyres.product (id,title,product_type_id,article_number,description,image,production_person_count,production_workshop_number,min_cost_for_agent) VALUES
	 (51,'Шина R15 Зима',3,'312952','','',2,5,4039.00),
	 (52,'Шина R15 Кованый',3,'274665','','\products\tire_63.jpg',2,10,13101.00),
	 (53,'Шина R15 Липучка',3,'349418','','\products\tire_48.jpg',1,4,6393.00),
	 (54,'Шина R16 Зима',3,'300433','','',4,2,2570.00),
	 (55,'Шина R16 Кованый',3,'421321','','',1,2,14691.00),
	 (56,'Шина R16 Лето',3,'437927','','',3,6,7181.00),
	 (57,'Шина R16 Липучка',3,'320970','','\products\tire_60.jpg',1,2,2264.00),
	 (58,'Шина R17 Зима',3,'291319','','\products\tire_54.jpg',2,4,6426.00),
	 (59,'Шина R17 Кованый',3,'299692','','\products\tire_58.jpg',3,10,11463.00),
	 (60,'Шина R17 Лето',3,'354738','','\products\tire_20.jpg',2,10,11329.00);
INSERT INTO tyres.product (id,title,product_type_id,article_number,description,image,production_person_count,production_workshop_number,min_cost_for_agent) VALUES
	 (61,'Шина R17 Липучка',3,'280863','','',4,8,11695.00),
	 (62,'Шина R18 Зима',3,'444280','','\products\tire_44.jpg',4,6,13168.00),
	 (63,'Шина R18 Кованый',3,'275809','','\products\tire_40.jpg',4,10,3258.00),
	 (64,'Шина R18 Лето',3,'425463','','',4,10,11625.00),
	 (65,'Шина R18 Липучка',3,'319450','','',3,6,4951.00),
	 (66,'Шина R19 Зима',3,'444141','','',2,8,2741.00),
	 (67,'Шина R19 Кованый',3,'291359','','\products\tire_27.jpg',5,10,14682.00),
	 (68,'Шина R19 Лето',3,'335030','','',4,10,4870.00),
	 (69,'Шина R19 Липучка',3,'341034','','\products\tire_36.jpg',1,5,13063.00),
	 (70,'Шина R20 Кованый',3,'330937','','\products\tire_45.jpg',3,1,10928.00);
INSERT INTO tyres.product (id,title,product_type_id,article_number,description,image,production_person_count,production_workshop_number,min_cost_for_agent) VALUES
	 (71,'Шина R20 Липучка',3,'348553','','',2,2,3508.00),
	 (72,'Шина R21 Зима',3,'398710','','\products\tire_7.jpg',2,2,9378.00),
	 (73,'Шина R21 Кованый',3,'329576','','\products\tire_59.jpg',2,2,7989.00),
	 (74,'Шина R21 Лето',3,'266521','','\products\tire_6.jpg',4,1,10561.00),
	 (75,'Шина R21 Липучка',3,'308647','','\products\tire_26.jpg',4,6,12830.00),
	 (76,'Шина R22 Зима',3,'382661','','',1,2,10373.00),
	 (77,'Шина R22 Кованый',3,'416324','','\products\tire_30.jpg',2,8,13841.00),
	 (78,'Шина R22 Лето',3,'406784','','\products\tire_37.jpg',3,5,14692.00),
	 (79,'Диск R15 Лето',4,'347427','','',1,1,5071.00),
	 (80,'Диск R16 Кованый',4,'440075','','\products\tire_25.jpg',3,9,9068.00);
INSERT INTO tyres.product (id,title,product_type_id,article_number,description,image,production_person_count,production_workshop_number,min_cost_for_agent) VALUES
	 (81,'Диск R16 Лето',4,'251201','','',3,10,8149.00),
	 (82,'Диск R16 Липучка',4,'435703','','',5,2,9934.00),
	 (83,'Диск R17 Зима',4,'343841','','',3,9,12768.00),
	 (84,'Диск R17 Лето',4,'400508','','\products\tire_24.jpg',1,4,12941.00),
	 (85,'Диск R17 Липучка',4,'282569','','\products\tire_42.jpg',5,5,12356.00),
	 (86,'Диск R18 Зима',4,'255211','','\products\tire_21.jpg',1,6,13239.00),
	 (87,'Диск R18 Лето',4,'317858','','\products\tire_52.jpg',5,3,8435.00),
	 (88,'Диск R19 Зима',4,'358851','','\products\tire_16.jpg',5,6,5695.00),
	 (89,'Диск R19 Лето',4,'243152','','\products\tire_0.jpg',1,9,6264.00),
	 (90,'Диск R19 Липучка',4,'318661','','',1,6,5544.00);
INSERT INTO tyres.product (id,title,product_type_id,article_number,description,image,production_person_count,production_workshop_number,min_cost_for_agent) VALUES
	 (91,'Диск R20 Зима',4,'252453','','',4,9,14526.00),
	 (92,'Диск R20 Лето',4,'300047','','\products\tire_56.jpg',3,10,10323.00),
	 (93,'Диск R20 Липучка',4,'447543','','\products\tire_3.jpg',4,8,11661.00),
	 (94,'Диск R21 Зима',4,'250714','','\products\tire_11.jpg',5,5,8762.00),
	 (95,'Диск R21 Кованый',4,'299085','','\products\tire_61.jpg',3,3,4757.00),
	 (96,'Диск R21 Лето',4,'449834','','\products\tire_35.jpg',4,8,2698.00),
	 (97,'Диск R22 Зима',4,'453650','','\products\tire_22.jpg',5,3,11459.00),
	 (98,'Диск R22 Кованый',4,'388520','','\products\tire_19.jpg',3,2,7498.00),
	 (99,'Диск R22 Лето',4,'406411','','\products\tire_23.jpg',2,4,2904.00),
	 (100,'Диск R22 Липучка',4,'418286','','\products\tire_4.jpg',4,2,10670.00);


INSERT INTO tyres.product_material (product_id,material_id,count) VALUES
	 (3,1,14.0),
	 (3,2,2.0),
	 (3,49,11.0),
	 (6,3,20.0),
	 (6,11,3.0),
	 (6,14,5.0),
	 (6,36,4.0),
	 (8,1,10.0),
	 (8,40,5.0),
	 (8,48,14.0);
INSERT INTO tyres.product_material (product_id,material_id,count) VALUES
	 (9,11,8.0),
	 (9,35,16.0),
	 (9,47,20.0),
	 (10,11,4.0),
	 (10,10,10.0),
	 (10,38,9.0),
	 (11,6,5.0),
	 (11,20,6.0),
	 (11,34,14.0),
	 (11,31,12.0);
INSERT INTO tyres.product_material (product_id,material_id,count) VALUES
	 (13,8,15.0),
	 (13,24,5.0),
	 (13,50,5.0),
	 (16,15,14.0),
	 (21,1,11.0),
	 (21,4,18.0),
	 (21,5,16.0),
	 (21,12,6.0),
	 (21,33,15.0),
	 (21,36,1.0);
INSERT INTO tyres.product_material (product_id,material_id,count) VALUES
	 (21,43,9.0),
	 (22,25,7.0),
	 (26,34,10.0),
	 (26,43,19.0),
	 (27,10,4.0),
	 (27,18,3.0),
	 (30,6,5.0),
	 (31,9,14.0),
	 (31,32,9.0),
	 (32,27,13.0);
INSERT INTO tyres.product_material (product_id,material_id,count) VALUES
	 (32,33,8.0),
	 (32,35,13.0),
	 (35,5,6.0),
	 (36,8,8.0),
	 (36,18,13.0),
	 (36,41,11.0),
	 (42,2,4.0),
	 (42,20,19.0),
	 (46,32,8.0),
	 (48,4,9.0);
INSERT INTO tyres.product_material (product_id,material_id,count) VALUES
	 (48,7,14.0),
	 (48,37,14.0),
	 (48,47,10.0),
	 (49,48,12.0),
	 (50,3,3.0),
	 (50,6,3.0),
	 (50,31,10.0),
	 (50,32,9.0),
	 (53,4,2.0),
	 (60,40,6.0);
INSERT INTO tyres.product_material (product_id,material_id,count) VALUES
	 (62,2,14.0),
	 (62,23,9.0),
	 (69,2,5.0),
	 (69,21,19.0),
	 (69,25,13.0),
	 (69,34,12.0),
	 (70,8,11.0),
	 (70,20,5.0),
	 (72,25,3.0),
	 (72,37,4.0);
INSERT INTO tyres.product_material (product_id,material_id,count) VALUES
	 (74,3,11.0),
	 (74,4,3.0),
	 (75,20,18.0),
	 (75,22,2.0),
	 (75,31,13.0),
	 (75,32,16.0),
	 (78,19,14.0),
	 (80,33,18.0),
	 (80,34,13.0),
	 (80,50,16.0);
INSERT INTO tyres.product_material (product_id,material_id,count) VALUES
	 (84,46,15.0),
	 (85,20,5.0),
	 (85,21,11.0),
	 (85,39,8.0),
	 (85,46,4.0),
	 (86,34,19.0),
	 (88,9,9.0),
	 (88,40,2.0),
	 (88,44,8.0),
	 (89,12,8.0);
INSERT INTO tyres.product_material (product_id,material_id,count) VALUES
	 (89,40,5.0),
	 (93,43,14.0),
	 (97,1,8.0),
	 (97,12,11.0),
	 (97,39,8.0),
	 (98,12,1.0),
	 (99,5,3.0),
	 (100,5,10.0),
	 (100,14,14.0),
	 (100,38,4.0);
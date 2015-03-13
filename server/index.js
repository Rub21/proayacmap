var express = require('express');
var cors = require('cors');
var pg = require('pg');
var argv = require('optimist').argv;
var geojson2osm = require('geojson2osm');
var client = new pg.Client(
	"postgres://" + (argv.pguser || 'postgres') +
	":" + (argv.pgpassword || '1234') +
	"@" + (argv.pghost || 'localhost') +
	"/" + (argv.pgdatabase || 'dbimportayac')
);
var url = "http://" + (argv.dbhost || 'localhost') + ":3019/";
console.log('Running on: ' + url);
var client = new pg.Client(client);
var app = express();
app.use(cors());
client.connect(function(err) {
	if (err) {
		return console.error('could not connect to postgres', err);
	}
});
app.get('/buil/:id', function(req, res) {
	var id = req.params.id;
	var json = {
		"type": "FeatureCollection",
		"features": []
	};
	var query = {
		text: "SELECT  ST_AsGeoJSON(geom) as geom,  building, height, min_height, \"building:levels\" as b_l," +
			"\"building:material\" as b_m , \"source:height\" as s_h, \"building:levels:underground\" as b_l_u, \"building:part\" as b_p, \"roof:material\" as r_m, " +
			"\"roof:shape\" as r_s, \"roof:height\" as r_h  FROM buildings WHERE id_block = $1",
		values: [id]
	};
	client.query(query, function(error, result) {
		if (error) {
			res.statusCode = 404;
			return res.send('Error 404: No quote found');
		} else {
			try {
				for (var i = 0; i < result.rows.length; i++) {
					var way = {
						"type": "Feature",
						"properties": {},
						"geometry": {}
					};
					if (result.rows[i].building !== null) {
						way.properties['building'] = result.rows[i].building;
					}
					if (result.rows[i].height !== null) {
						way.properties['height'] = result.rows[i].height;
					}
					if (result.rows[i].min_height !== null) {
						way.properties['min_height'] = result.rows[i].min_height;
					}
					if (result.rows[i].b_l !== null) {
						way.properties['building:levels'] = result.rows[i].b_l;
					}
					if (result.rows[i].b_l !== null) {
						way.properties['building:material'] = result.rows[i].b_m;
					}
					if (result.rows[i].b_l !== null) {
						way.properties['source:height'] = result.rows[i].s_h;
					}
					if (result.rows[i].b_l !== null) {
						way.properties['building:levels:underground'] = result.rows[i].b_l_u;
					}
					if (result.rows[i].b_l !== null) {
						way.properties['building:part'] = result.rows[i].b_p;
					}
					if (result.rows[i].b_l !== null) {
						way.properties['building:part'] = result.rows[i].b_p;
					}
					if (result.rows[i].b_l !== null) {
						way.properties['roof:material'] = result.rows[i].r_m;
					}
					if (result.rows[i].b_l !== null) {
						way.properties['roof:shape'] = result.rows[i].r_s;
					}
					if (result.rows[i].b_l !== null) {
						way.properties['roof:height'] = result.rows[i].r_h;
					}
					way.geometry = JSON.parse(result.rows[i].geom);
					json.features.push(way);
				}
				var osm = geojson2osm.geojson2osm(json);
				res.set('Content-Type', 'text/xml');
				res.send(osm);
			} catch (e) {
				console.log("entering catch block2");
			}
		}
	});
});
app.get('/addr/:id', function(req, res) {
	var id = req.params.id;
	var json = {
		"type": "FeatureCollection",
		"features": []
	};
	var query = {
		text: "SELECT \"addr:housenumber\" as a_n, ST_AsGeoJSON(geom) as geom, \"addr:postcode\" as a_p ,\"addr:province\" as a_pro,  \"addr:district\" as a_dis  FROM address WHERE id_block = $1",
		values: [id]
	};
	client.query(query, function(error, result) {
		if (error) {
			res.statusCode = 404;
			return res.send('Error 404: No quote found');
		} else {
			try {
				for (var i = 0; i < result.rows.length; i++) {
					var way = {
						"type": "Feature",
						"properties": {},
						"geometry": {}
					};
					if (result.rows[i].a_n !== null) {
						way.properties['addr:housenumber'] = result.rows[i].a_n;
					}
					if (result.rows[i].a_p !== null) {
						way.properties['addr:postcode'] = result.rows[i].a_p;
					}
					if (result.rows[i].a_pro !== null) {
						way.properties['addr:province'] = result.rows[i].a_pro;
					}
					if (result.rows[i].a_dis !== null) {
						way.properties['addr:district'] = result.rows[i].a_dis;
					}
					way.geometry = JSON.parse(result.rows[i].geom);
					json.features.push(way);
				}
				var osm = geojson2osm.geojson2osm(json);
				res.set('Content-Type', 'text/xml');
				res.send(osm);
			} catch (e) {
				console.log("entering catch block2");
			}
		}
	});
});
app.listen(process.env.PORT || 3019);
# turtle inputs: 
#   turtle ID 
#   current coordinates 
#   request type 

# cc outputs:
#   turtle ID
#   action type (move, place block, destroy block, inspect, wait)
#   destination
#   meta data type: (dest coordinates, block type, wait seconds)
#   meta data value: ()


from urlparse import parse_qs
import json
import psycopg2

# commands: move_to, update_coordinates, dig_block, place_block, detect_block, place_turtle

def vncc(environ, start_response):
        return_json = {}
        qs = parse_qs(environ['QUERY_STRING'])
        if 'turtleid' not in qs or 'xcoord' not in qs:
            data = "fuck you"
        else:
            return_json['turtleid'] = qs['turtleid'][0]
            return_json['xcoord'] = int(qs['xcoord'][0]) + 1
            return_json['zcoord'] = qs['zcoord'][0]
            return_json['ycoord'] = qs['ycoord'][0]
            return_json['command'] = 'moveto'
            data = json.dumps(return_json)
        data = bytes(data)

        start_response("200 OK", [
            ("Content-Type", "text/plain"),
            ("Content-Length", str(len(data)))
        ])
        return iter([data])
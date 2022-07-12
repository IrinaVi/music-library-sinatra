1. Design 
POST /artists
Returns Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing
Method: POST
Path /artists
Query Params: name, genre

2. Response
When sending the following params 
name=Wild nothing
genre=Indie
The response is nil, but the artist get added to the db


3. Examples

POST /artist name=Wild nothing
genre=Indie

GET /artists
# expect output
Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos, Wild nothing






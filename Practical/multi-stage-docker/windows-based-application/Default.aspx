<%@ Page Language="C#" %>

<!DOCTYPE html>
<html>
<head>
    <title>European Destinations</title>

    <style>
        body {
            font-family: Arial;
            background: linear-gradient(to right, #74ebd5, #ACB6E5);
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: white;
        }

        .container {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .card {
            width: 300px;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.3);
        }

        .card img {
            width: 100%;
            height: 220px;
            object-fit: cover;
        }

        .card h2 {
            padding: 10px;
            margin: 0;
            color: #333;
        }

        .card p {
            padding: 10px;
            color: #666;
        }
    </style>
</head>

<body>

    <h1>🌍 Beautiful European Destinations</h1>

    <div class="container">

        <div class="card">
            <img src="https://upload.wikimedia.org/wikipedia/commons/a/a8/Venezia.jpg" />
            <h2>🇮🇹 Venice, Italy</h2>
            <p>
                Venice is famous for canals, gondolas, and romantic architecture.
            </p>
        </div>

        <div class="card">
            <img src="https://upload.wikimedia.org/wikipedia/commons/e/e6/Paris_Night.jpg" />
            <h2>🇫🇷 Paris, France</h2>
            <p>
                Paris is known for the Eiffel Tower, cafes, and beautiful culture.
            </p>
        </div>

        <div class="card">
            <img src="https://upload.wikimedia.org/wikipedia/commons/9/97/Santorini.jpg" />
            <h2>🇬🇷 Santorini, Greece</h2>
            <p>
                Santorini is famous for white-blue houses and stunning sunsets.
            </p>
        </div>

    </div>

</body>
</html>

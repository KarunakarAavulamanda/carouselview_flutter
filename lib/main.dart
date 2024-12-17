import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carouselview Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Carouselview Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // First Carouselview
            SizedBox(
              height: 400,
              child: CarouselView(
                elevation: 2,
                onTap: (tapIndex) {
                  _showImageDialog(
                      context, 'assets/images/image_${tapIndex + 1}.jpeg');
                },
                padding: const EdgeInsets.all(10),
                itemExtent: MediaQuery.of(context).size.width - 30,
                itemSnapping: true,
                children: List.generate(5, (index) {
                  return Image.asset(
                    'assets/images/image_${index + 1}.jpeg',
                    fit: BoxFit.cover,
                  );
                }),
              ),
            ),
            // Spacer
            const SizedBox(height: 50),
            // Second Carouselview
            //Using the Picsum API to generate random images
            SizedBox(
              height: 400,
              child: CarouselView(
                elevation: 2,
                padding: const EdgeInsets.all(10),
                itemExtent: MediaQuery.of(context).size.width - 30,
                itemSnapping: true,
                children: List.generate(5, (index) {
                  // Using the Picsum API to generate random images
                  String imageUrl =
                      'https://picsum.photos/id/${237 + index}/200/300';
                  return Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  );
                }),
              ),
            ),
            // Spacer
            const SizedBox(height: 50),
            // third Carouselview
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: CarouselView(
                  itemExtent: 330,
                  shrinkExtent: 200,
                  itemSnapping: true, // Smooth snapping behavior
                  children: List<Widget>.generate(20, (int index) {
                    return UncontainedLayoutCard(
                        index: index, label: 'Item $index');
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imageUrl),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class UncontainedLayoutCard extends StatelessWidget {
  const UncontainedLayoutCard({
    super.key,
    required this.index,
    required this.label,
  });

  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.primaries[index % Colors.primaries.length].withOpacity(0.5),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 20),
          overflow: TextOverflow.clip,
          softWrap: false,
        ),
      ),
    );
  }
}

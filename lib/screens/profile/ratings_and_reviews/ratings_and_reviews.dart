import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rabbi_roots_delivery/models/users_data.dart';

class RatingsAndReviewsScreen extends StatelessWidget {
  final UserData userData;
  const RatingsAndReviewsScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header section with profile and name
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://imgs.search.brave.com/tSrEwxuHjzrigvT92_siz84PUwtOycTttTDQLyYmGz4/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/dmVjdG9yc3RvY2su/Y29tL2kvcHJldmll/dy0xeC84Ny8yNC9t/YW4tcHJvZmlsZS12/ZWN0b3ItMzE5ODg3/MjQuanBn'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${userData.name}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Ratings And Reviews',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Reviewed By section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reviewed By Amit Mane',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Tue Mar 4',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Ratings section
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3.5,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: [
                  _buildRatingItem('Punctuality', 5),
                  _buildRatingItem('Communication', 4),
                  _buildRatingItem('Professionalism', 3.5),
                  _buildRatingItem('Overall Experience', 4),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Close button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingItem(String title, double rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          itemCount: 5,
          itemSize: 20,
          direction: Axis.horizontal,
        ),
      ],
    );
  }
}

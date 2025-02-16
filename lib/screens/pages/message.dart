import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class Message extends StatefulWidget {
  const Message({super.key});
  @override
  State<Message> createState() => _Message();
}

class _Message extends State<Message> {
  TextEditingController controller = TextEditingController();
  int maxRating = 5;
  int ratingNow = 0;
  List<bool> rating = [false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Message')),
        body: Container(
          padding: const EdgeInsets.all(16.00),
          child: ListView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16.00,
                ),
                Text(
                  'Message pour ameliorer notre service .Nous écoutons tout ce que vous pensez de notre service.',
                  style: GoogleFonts.openSans(fontSize: 20),
                ),
                const SizedBox(
                  height: 20.00,
                ),
                Text(
                  'Titre du message:',
                  style: GoogleFonts.openSans(
                      fontSize: 16, decoration: TextDecoration.underline),
                ),
                Container(
                    padding: const EdgeInsets.all(8.00),
                    child: TextField(
                      controller: controller,
                      maxLines: 1,
                      enabled: true,
                      decoration: const InputDecoration(
                        focusColor: Colors.black,
                        hintText: 'ex: Embouteillage',
                        border: OutlineInputBorder(),
                        //labelText: 'Description de votre Destination'
                      ),
                    )),
                const SizedBox(
                  height: 16.00,
                ),
                Text(
                  'Description du message:',
                  style: GoogleFonts.openSans(
                      fontSize: 16, decoration: TextDecoration.underline),
                ),
                Container(
                    padding: const EdgeInsets.all(8.00),
                    child: TextField(
                      controller: controller,
                      maxLines: 3,
                      enabled: true,
                      decoration: InputDecoration(
                        focusColor: Colors.black,
                        hintText:
                            'ex: Vous devez implementer une systeme de detection d\'embouteillage',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.1, color: theme.primaryColor)),
                        //labelText: 'Description de votre Destination'
                      ),
                    )),
                const SizedBox(
                  height: 16.00,
                ),
                Text(
                  'Notes:',
                  style: GoogleFonts.openSans(
                      fontSize: 16, decoration: TextDecoration.underline),
                ),
                etoileRanking(ratingNow),
                const SizedBox(
                  height: 16.00,
                ),
                 Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShadButton(
                      backgroundColor: theme.secondaryHeaderColor,
                      width: 200,
                      child: Text('Envoyez le message',style: TextStyle(color: theme.primaryColor),),
                    ),
                  ],
                )
              ],
            ),
          ]),
        ));
  }

  void etoileRankingDay(int index, List<bool> rating) {
    if (rating[index]) {
      for (int i = 4; i >= index; i--) {
        rating[i] = false;
      }
    } else {
      for (int i = 0; i <= index; i++) {
        rating[i] = true;
      }
    }
  }

  int numberTrue(List<bool> rate) {
    int nowRating = 0;
    for (int i = 0; i < 5; i++) {
      if (rate[i] == true) {
        nowRating++;
      }
    }
    return nowRating;
  }

  Widget etoileRanking(int ratingNow) {
    return Container(
      padding: const EdgeInsets.only(left: 16.00, right: 16.00),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(maxRating, (index) {
          return IconButton(
              onPressed: () {
                setState(() {
                  // rating[index] = !rating[index];
                  // rating[index] ? ratingNow += 1 : ratingNow -= 1;
                  etoileRankingDay(index, rating);
                });
                ratingNow = numberTrue(rating);
              },
              icon: Icon(
                rating[index] ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 30,
              ));
        }),
      ),
    );
  }
}

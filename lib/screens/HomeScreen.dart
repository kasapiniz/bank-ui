import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterbank/constants/color_constant.dart';
import 'package:flutterbank/models/card_model.dart';
import 'package:flutterbank/models/operation_model.dart';
import 'package:flutterbank/models/transaction_model.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int current = 0;

  List<T> map<T>(List list, Function handler){
    List<T> result = [];
    for (var i=0; i< list.length; i++){
      result.add(handler(i, list[i]));
    }
    return result;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top:8),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.only(left: 16,right: 16.0,top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      print("Cizgi Tıklandı");
                    },
                      child: SvgPicture.asset('assets/svg/drawer_icon.svg')
                  ),
                  Container(
                    height: 59,
                    width: 59,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage("assets/images/s.png")
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 25,
            ),

            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16,),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("İyi Geceler!", style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: kBlackColor,
                  ),),
                  Text("Mehmet KASAP", style: GoogleFonts.inter(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: kBlackColor,
                  ),),
                ],
              ),
            ),

            Container(
              height: 199,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 16,right: 6),
                  itemCount: cards.length,
                  itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Container(
                    height: 199,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Color(cards[index].cardBackground),

                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          child: SvgPicture.asset(cards[index].cardElementTop),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: SvgPicture.asset(cards[index].cardElementBottom),
                        ),
                        Positioned(
                          left: 29,
                          top: 48,
                          child: Text("KART NUMARASI", style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: kWhiteColor,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 29,
                          top: 65,
                          child: Text(cards[index].cardNumber, style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: kWhiteColor,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 21,
                          top: 35,
                          child: Image.asset(cards[index].cardType, width: 27, height: 27,),
                        ),
                        Positioned(
                          left: 29,
                          bottom: 45,
                          child: Text("KART SAHİBİNİN ADI",style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: kWhiteColor,

                          )),
                        ),
                        Positioned(
                          left: 29,
                          bottom: 21,
                          child: Text(cards[index].user,style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: kWhiteColor,

                          )),
                        ),
                        Positioned(
                          left: 202,
                          bottom: 45,
                          child: Text("SON KULLANMA TARİHİ",style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: kWhiteColor,

                          )),
                        ),
                        Positioned(
                          left: 202,
                          bottom: 21,
                          child: Text(cards[index].cardExpired,style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: kWhiteColor,

                          )),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            //operator kısmı
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 13, top: 29,right:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Operatör", style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: kBlackColor,
                  )),
                  Row(
                    children:  map<Widget>(
                        datas ,
                            (index, selected)
                        {
                      return Container(
                        alignment: Alignment.centerLeft,
                        height: 9,
                        width: 9,
                        margin: EdgeInsets.only(right: 6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: current==index
                              ? kBlueColor
                              : kTwentyBlueColor),
                      );
                    }),
                  ),
                ],
              ),
            ),
            
            Container(
              height: 123,

              child: ListView.builder(
                itemCount: datas.length,
                  padding: EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                     setState((){
                       current=index;

                     });
                    },
                    child: OperationCard(
                      operation: datas[index].name,
                      selectedIcon: datas[index].selectedIcon,
                      unselectedIcon: datas[index].unselectedIcon,
                      isSelected: current == index,
                     context:this
                    ),
                  );
                  }),
            ),
            //para kısmı
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 13, top: 29,right:10),
              child: Text("İşlem Geçmişi", style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: kBlackColor,
              )),
            ),

            ListView.builder(
              itemCount: transactions.length,
              padding: EdgeInsets.only(left: 16, right: 16),
              shrinkWrap: true,
              itemBuilder: (contex, index){
                return Container(
                  height: 57,
                  margin: EdgeInsets.only(bottom:13),
                  padding: EdgeInsets.only(left: 24, top:12, bottom: 12, right: 22),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: kTenBlackColor,
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: Offset(8.0,8.0),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: <Widget>[
                      Row(
                        children: <Widget>[Container(
                            height: 57,
                            width: 57,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(transactions[index].photo),),
                            ),
                        ),
                        SizedBox(
                          width: 13,
                        ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(transactions[index].name),
                              Text(transactions[index].date),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(transactions[index].amount, style: GoogleFonts.inder(
                            color: kBlueColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            //sonyer!
          ],
        ),
      ),
    );
  }
}

class OperationCard extends StatefulWidget {
 final String operation;
 final String selectedIcon;
 final String unselectedIcon;
 final bool  isSelected;
 _HomeScreenState context;

   OperationCard(
      {this.operation, this.selectedIcon, this.unselectedIcon, this.isSelected, this.context}
      );



  @override
  _OperationCardState createState() => _OperationCardState();
}

class _OperationCardState extends State<OperationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(right: 16),
      width: 123,
        height: 123,
      decoration: BoxDecoration(
     boxShadow: [
       BoxShadow(
         color: kTenBlackColor,
         blurRadius: 10,
         spreadRadius: 5,
         offset: Offset(8.0,8.0),)
     ], borderRadius: BorderRadius.circular(20),
          color: widget.isSelected ? kBlueColor:kWhiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
              widget.isSelected ? widget.selectedIcon : widget.unselectedIcon),
          SizedBox(
            height: 9,
          ),
          Text(
            widget.operation, textAlign: TextAlign.center, style: GoogleFonts.inter(
            fontSize: 15,
          fontWeight: FontWeight.w700,
          color: widget.isSelected ? kWhiteColor : kBlueColor ),),
        ],
      ),
    );
  }
}

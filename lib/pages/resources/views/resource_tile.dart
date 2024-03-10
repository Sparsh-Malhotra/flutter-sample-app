import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathshala/pages/resources/controllers/resource_controller.dart';
import 'package:pathshala/pages/resources/models/resources_response.dart';
import 'package:pathshala/pages/read_text/views/read_text.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/resources_manager.dart';

class ResourceTile extends StatefulWidget {
  const ResourceTile({Key? key, required this.resource}) : super(key: key);

  final TextResource resource;

  @override
  State<ResourceTile> createState() => _ResourceTileState();
}

class _ResourceTileState extends State<ResourceTile> {
  late ResourceController _resourceController;
  final ResourcesManager _resourcesManager = ResourcesManager();

  @override
  void initState() {
    super.initState();
    _resourceController = ResourceController();
  }

  @override
  void dispose() {
    _resourceController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
        return ListTile(
          tileColor: AppColors.cardColor,
          title: Text(widget.resource.name!),
          onTap: () async {
            try {
              String? resourceData = await _resourceController.getTextResourcesHandler(widget.resource.id!);
              if (resourceData != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadTextScreen(text: resourceData, title: widget.resource.name!),
                  ),
                );
              } else {
                // Handle the case when data fetching fails
                print('Error fetching data.');
              }
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ReadTextScreen(text: resourceText),
              //     // builder: (context) => ReadTextScreen(text: 'तुम निरखत मुझको मिली, मेरी सम्पति आज।\n\nकहाँ चक्रवर्ति-संपदा कहाँ स्वर्ग-साम्राज॥ १॥\n\n \n\nतुम वन्दत जिनदेव जी, नित नव मंगल होय।\n\nविघ्न कोटि ततछिन टरैं, लहहिं सुजस सब लोय॥ २॥\n\n \n\nतुम जाने बिन नाथ जी, एक स्वाँस के माँहिं।\n\nजन्म-मरण अठदस किये, साता पाई नाहिं॥ ३॥\n\n \n\nआप बिना पूजत लहे, दु:ख नरक के बीच।\n\nभूख प्यास पशुगति सही, कर्यो निरादर नीच॥ ४॥\n\n \n\nनाम उचारत सुख लहै, दर्शनसों अघ जाय।\n\nपूजत पावै देव पद, ऐसे हैं जिनराय॥ ५॥\n\n \n\nवंदत हूँ जिनराज मैं, धर उर समताभाव।\n\nतन - धन - जन जगजाल तैं धर विरागता भाव॥ ६॥\n\n \n\nसुनो अरज हे नाथ जी, त्रिभुवन के आधार।\n\nदुष्ट कर्म का नाश कर, वेगि करो उद्धार ॥ ७॥\n\n \n\nजाचत हूँ मैं आपसों, मेरे जियके माँहिं।\n\nरागद्वेष की कल्पना, कबहूँ उपजै नाहिं ॥ ८॥\n\n \n\nअति अद्भुत प्रभुता लखी, वीतरागता माँहिं।\n\nविमुख होहिं ते दु:ख लहैं, सन्मुख सुखी लखाहिं ॥ ९॥\n\n \n\nकलमल कोटिक नहिं रहैं, निरखत ही जिनदेव।\n\nज्यों रवि ऊगत जगत् में, हरै तिमिर स्वयमेव ॥ १०॥\n\n \n\nपरमाणू पुद्गलतणी, परमातम संजोग ।\n\nभई पूज्य सब लोक में, हरे जन्म का रोग ॥ ११॥\n\n \n\nकोटि जन्म में कर्म जो, बाँधे हुते अनन्त ।\n\nते तुम छवी विलोकते, छिन में हो हैं अन्त ॥ १२॥\n\n \n\nआन नृपति किरपा करै, तब कछु दे धन धान ।\n\nतुम प्रभु अपने भक्त को, करल्यो आप समान॥ १३ ॥\n\n \n\nयंत्र मंत्र मणि औषधी, विषहर राखत प्रान ।\n\nत्यों जिनछवि सब भ्रम हरै, करै सर्व परधान ॥ १४ ॥\n\n \n\nत्रिभुवनपति हो ताहि तैं, छत्र विराजैं तीन ।\n\nसुरपति नाग नरेशपद, रहैं चरन आधीन ॥ १५ ॥\n\n \n\nभवि निरखत भव आपने, तुम भामण्डल बीच ।\n\nभ्रम मेटैं समता गहै, नाहिं सहै गति नीच ॥ १६ ॥\n\n \n\nदोई ओर ढोरत अमर, चौंसठ चमर सफेद ।\n\nनिरखत भविजन का हरैं, भव अनेक का खेद ॥ १७ ॥\n\n \n\nतरु अशोक तुम हरत है, भवि-जीवन का शोक ।\n\nआकुलता कुल मेटि कें, करैं निराकुल लोक॥१८ ॥\n\n \n\nअन्तर बाहिर परिगहन, त्यागा सकल समाज ।\n\nसिंहासन पर रहत हैं, अन्तरीक्ष जिनराज ॥ १९॥\n\n \n\nजीत भई रिपु मोहतैं, यश सूचत है तास ।\n\nदेव दुन्दुभिन के सदा, बाजे बजैं आकाश ॥ २०॥\n\n \n\nबिन अक्षर इच्छा रहित, रुचिर दिव्यध्वनि होय।\n\nसुर नर पशु समझैं सबै, संशय रहै न कोय ॥ २१॥\n\n \n\nबरसत सुरतरु के कुसुम, गुंजत अलि चहुँ ओर ।\n\nफैलत सुजस सुवासना, हरषत भवि सब ठौर ॥ २२॥\n\n \n\nसमुद्र बाध अरु रोग अहि, अर्गल बंध संग्राम ।\n\nविघ्न विषम सब ही टरैं, सुमरत ही जिन नाम ॥ २३॥\n\n \n\nसिरीपाल, चंडाल पुनि, अञ्जन भीलकुमार ।\n\nहाथी हरि अरि सब तरे, आज हमारी बार ॥ २४॥\n\n \n\nबुधजन यह विनती करै, हाथ जोड़ शिर नाय।\n\nजबलौं शिव नहिं होय तुमभक्ति हृदय अधिकाय ॥२५॥"'),  // Pass the actual text content
              //   ),
              // );
            } catch (e) {
              print('Error fetching data: $e');
            }
          },
        );

  }
}
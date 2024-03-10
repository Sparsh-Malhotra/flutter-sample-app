import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathshala/pages/Resources/models/resources_response.dart';
import 'package:pathshala/pages/resources/controllers/resources_controller.dart';
import 'package:pathshala/pages/resources/views/resource_tile.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/curves/small_curve.dart';
import 'package:pathshala/utils/functions.dart';
import 'package:pathshala/utils/resources_manager.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  final ResourcesController _resourcesController = Get.put(ResourcesController());
  final resourcesManager = ResourcesManager();

  @override
  void initState() {
    super.initState();
    resourcesManager.init();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double topBarHeight = 135;

    return Scaffold(
      body: FutureBuilder(
        future: _resourcesController.getResourcesHandler(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('No resources found'),
            );
          } else if (snapshot.hasData) {
            return Stack(
              children: [
                SizedBox(
                  height: height,
                  width: width,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 132, bottom: 20),
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final resource = snapshot.data![index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 20),
                            clipBehavior: Clip.antiAlias,
                            child: ResourceTile(resource: resource),
                          );
                        },
                      )
                    ],
                  ),
                ),
                CustomPaint(
                  size: Size(width, topBarHeight),
                  painter: SmallCurve(),
                  child: appBar(
                    'Resources',
                    topBarHeight,
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('No resources found'),
            ); // Initial state
          }
        },
      ),
    );
  }
}

import 'package:event_bus/event_bus.dart';
import 'package:flutter_cisslab/pages/ProductContent.dart';

EventBus eventBus = EventBus();

class ProductContentEvent {

  String str;

  ProductContentEvent(String str) {
    this.str = str;
  }
}
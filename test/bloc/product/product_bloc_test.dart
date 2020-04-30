import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../blackout_test_base.dart';

void main() {
  ModelChangeRepository modelChangeRepository;
  ProductBloc productBloc;

  setUp(() {
    modelChangeRepository = ModelChangeRepositoryMock();
    productBloc = ProductBloc(modelChangeRepository);
  });

  test('Load and show product', () async {
    when(modelChangeRepository.findAllByProductIdAndHomeId(DEFAULT_PRODUCT_ID, DEFAULT_HOME_ID)).thenAnswer((realInvocation) => Future.value([createDefaultModelChange(ModelChangeType.create, product: createDefaultProduct()..id = DEFAULT_PRODUCT_ID)]));

    expectLater(productBloc, emitsInOrder([ProductInitialState(), isA<ShowProduct>()]));

    productBloc.add(LoadProduct(createDefaultProduct()..id = DEFAULT_PRODUCT_ID));
  });
}

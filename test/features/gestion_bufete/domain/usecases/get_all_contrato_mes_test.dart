import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/data/models/contrato_model.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/domain/repository/contrato_bufete_repository.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/domain/usecases/get_all_contrato_mes.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ContratoBufeteRepository])
import 'get_all_contrato_mes_test.mocks.dart';

void main() {
  late MockContratoBufeteRepository mockContratoBufeteRepository;
  late GetAllContratoMes usecase;

  setUp(() {
    mockContratoBufeteRepository = MockContratoBufeteRepository();
    usecase = GetAllContratoMes(repository: mockContratoBufeteRepository);
  });

  const String tMes = 'Enero';
  const tContrato = ContratoModel(
      id: 1, mes: 'Enero', nombre: 'Pinocho', numero: '50', precio: 678.49);

  const Map<dynamic, ContratoModel> tListContrato = {'1': tContrato};

  test('Comprobando que se Obtienen todos los Contratos', () async {
    when(mockContratoBufeteRepository.getAllContratosMes(any))
        .thenAnswer((_) async => const Right(tListContrato));
    final results = await usecase(mes: tMes);
    expect(results, const Right(tListContrato));
    verify(mockContratoBufeteRepository.getAllContratosMes(tMes));
    verifyNoMoreInteractions(mockContratoBufeteRepository);
  });
}

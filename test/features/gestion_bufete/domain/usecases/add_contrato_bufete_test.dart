import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/data/models/contrato_model.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/domain/repository/contrato_bufete_repository.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/domain/usecases/add_contrato_bufete.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ContratoBufeteRepository])
import 'add_contrato_bufete_test.mocks.dart';

void main() {
  late MockContratoBufeteRepository mockContratoBufeteRepository;
  late AddContratoBufete usecase;

  setUp(() {
    mockContratoBufeteRepository = MockContratoBufeteRepository();
    usecase = AddContratoBufete(repository: mockContratoBufeteRepository);
  });
  const bool tBool = true;
  const ContratoModel tContrato = ContratoModel(
      id: 1, mes: 'Enero', nombre: 'Pinocho', numero: '50', precio: 678.49);

  test('Comprobando que se Agrega el Contrato Correctamente', () async {
    when(mockContratoBufeteRepository.addContratoBufete(any))
        .thenAnswer((realInvocation) async => const Right(tBool));
    final response = await usecase(contrato: tContrato);
    expect(response, const Right(tBool));
    verify(mockContratoBufeteRepository.addContratoBufete(tContrato));
    verifyNoMoreInteractions(mockContratoBufeteRepository);
  });
}
